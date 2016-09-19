From: mengdong.lin@linux.intel.com
Subject: [PATCH] topology: Add support for included files
Date: Mon, 19 Sep 2016 13:34:53 +0800
Message-ID: <a72d18664477cf051e60bbc5efeedb5b4804ed17.1474262798.git.mengdong.lin@linux.intel.com>
References: <cover.1474262798.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F3CB261567
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 07:28:30 +0200 (CEST)
In-Reply-To: <cover.1474262798.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Users can include a list of files by SectionInclude in the text config
file. This allows user to define common info in separate files (e.g.
vendor tokens, tuples) and share them for different platforms, by
including them. This can save the total size of files. Users can also
specifiy a list of directories relative to "usr/share/alsa/topology"
to search the included files.

The topology library will search and open an included file in the
following order of priority:
1. directly open the file by its name;
2. search for the file name in the directory containing current file;
3. search for the file name in "usr/share/alsa/topology";
4. search for the file name in user specified subdirectories under
   "usr/share/alsa/topology".

The order of the included files need not to be same as their dependencies,
because the toplogy library will load all of them before parsing their
dependencies.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 0675b52..86520df 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -623,6 +623,43 @@ extern "C" {
  *	data "name"			# optional private data
  * }
  * </pre>
+ *
+ * <h4>Include other files</h4>
+ * Users can include a list of files by SectionInclude in the text config
+ * file. This allows user to define common info in separate files (e.g.
+ * vendor tokens, tuples) and share them for different platforms, by
+ * including them. This can save the total size of files. <br><br>
+ * Users can also specifiy a list of subdirectories under
+ * "usr/share/alsa/topology", the installation directory of toplogy
+ * configuration files, to search the included files. <br><br>
+ *
+ * The topology library will search and open an included file in the
+ * following order of priority:
+ *  1. directly open the file by its name;
+ *  2. search for the file name in the directory containing current file;
+ *  3. search for the file name in "usr/share/alsa/topology";
+ *  4. search for the file name in user specified subdirectories under
+ *     "usr/share/alsa/topology".
+ *
+ * The order of the included files need not to be same as their
+ * dependencies, since the tool will load them all before parsing their
+ * dependencies.
+ *
+ * <pre>
+ * SectionInclude."name" {
+ *	path [		# Optional subdirectories to search included files
+ *		"1st subdirectory"
+ *		"2nd subdirectory"
+ *		...
+ *	]
+ *
+ *	include [	# Name of included files, use relative path
+ *		"name of 1st included file"
+ *		"name of 2nd included file"
+ *		...
+ *	]
+ * }
+ * </pre>
  */
 
 /** Maximum number of channels supported in one control */
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 3ab64f4..f0004d2 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -17,9 +17,19 @@
 */
 
 #include <sys/stat.h>
+#include <libgen.h>
 #include "list.h"
 #include "tplg_local.h"
 
+/* installation directory of topology configuration files */
+const char install_dir[] = "/usr/share/alsa/topology/";
+
+static int tplg_load_config(const char *file, const char *base_dir,
+			    struct list_head *include_paths,
+			    snd_config_t **cfg);
+static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg,
+			     const char *base_dir);
+
 /*
  * Parse compound
  */
@@ -58,7 +68,248 @@ int tplg_parse_compound(snd_tplg_t *tplg, snd_config_t *cfg,
 	return err;
 }
 
-static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
+
+/**
+ * add_include_path - Add a diretory to the paths to search included files
+ * @tplg: Topology context.
+ * @dir: Name of directory to add.
+ *
+ * The direcotry will be taken as a subdiretory of topology installation
+ * directory "/usr/share/alsa/topology".
+ */
+static int add_include_path(snd_tplg_t *tplg, const char *dir)
+{
+	struct tplg_path *path;
+
+	path = calloc(1, sizeof(*path));
+	if (!path)
+		return -ENOMEM;
+
+	path->dir = calloc(1, PATH_MAX + 1);
+	if (!path->dir)
+		return -ENOMEM;
+
+	strcpy(path->dir, install_dir);
+	strncat(path->dir, dir, PATH_MAX - sizeof(install_dir));
+
+	tplg_dbg("Include path: %s\n", path->dir);
+	list_add_tail(&path->list, &tplg->include_paths);
+	return 0;
+}
+
+/* Free all include paths in the list */
+static void free_include_paths(snd_tplg_t *tplg)
+{
+	struct list_head *pos, *npos, *base;
+	struct tplg_path *path;
+
+	base = &tplg->include_paths;
+	list_for_each_safe(pos, npos, base) {
+		path = list_entry(pos, struct tplg_path, list);
+		list_del(&path->list);
+		if (path->dir)
+			free(path->dir);
+		free(path);
+	}
+}
+
+/* Parse the include paths
+ */
+static int parse_include_path(snd_tplg_t *tplg, snd_config_t *cfg)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *dir;
+	int err;
+
+	snd_config_for_each(i, next, cfg) {
+
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_string(n, &dir) < 0)
+			continue;
+
+		if (!strlen(dir))
+			continue;
+
+		err = add_include_path(tplg, dir);
+		if (err < 0) {
+			SNDERR("error: failed to add include path %s\n",
+				dir);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/* Add a child config to topology context, to free it finally */
+static int add_child_config(snd_tplg_t *tplg, snd_config_t *cfg)
+{
+	struct tplg_config *child;
+
+	child = calloc(1, sizeof(*child));
+	if (!child)
+		return -ENOMEM;
+
+	child->cfg = cfg;
+	list_add_tail(&child->list, &tplg->child_cfg_list);
+
+	return 0;
+}
+
+
+/* Free all child configs of the topology context */
+static void free_child_configs(snd_tplg_t *tplg)
+{
+	struct list_head *pos, *npos, *base;
+	struct tplg_config *child;
+
+	base = &tplg->child_cfg_list;
+	list_for_each_safe(pos, npos, base) {
+		child = list_entry(pos, struct tplg_config, list);
+		list_del(&child->list);
+		snd_config_delete(child->cfg);
+		free(child);
+	}
+}
+
+/**
+ * parse_included_file - Parse included files.
+ * @ tplg: topology context
+ * @ cfg: config that contains a list of included files
+ * @ base_dir: direcotry of the parent config file, to search
+ *             the included files.
+ */
+static int parse_included_file(snd_tplg_t *tplg, snd_config_t *cfg,
+			       const char *base_dir)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n, *child;
+	const char *file;
+	char *full_path = NULL, *child_dir = NULL;
+	int err = 0, pos;
+
+	full_path = calloc(1, PATH_MAX + 1);
+	if (!full_path)
+		return -ENOMEM;
+
+	/* Current base directory will be used to calculate base directory
+	 * of each included file (child) that may further include other files.
+	 */
+	strncpy(full_path, base_dir, PATH_MAX);
+	strcat(full_path, "/");
+	pos = strlen(full_path);
+
+	snd_config_for_each(i, next, cfg) {
+
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_string(n, &file) < 0)
+			continue;
+
+		/* load config from the included file */
+		tplg_dbg("Include file: %s\n", file);
+		err = tplg_load_config(file, base_dir,
+				       &tplg->include_paths,
+				       &child);
+		if (err < 0) {
+			SNDERR("error: failed to load topology file %s\n",
+				full_path);
+			goto out;
+		}
+
+		/* store the config as a child */
+		err = add_child_config(tplg, child);
+		if (err < 0) {
+			SNDERR("error: failed to add child config of file %s\n",
+				full_path);
+			goto out;
+		}
+
+		/* Get the base directory for the child config, which may
+		 * further include other files. Duplicate the path since
+		 * dirname() may modify the input.
+		 */
+		full_path[pos] = 0;
+		strcat(full_path, file);
+		child_dir = strdup(full_path);
+		if (!child_dir) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		/* parse topology items in the child confg */
+		err = tplg_parse_config(tplg, child, dirname(child_dir));
+		free(child_dir);
+		if (err < 0) {
+			SNDERR("error: failed to parse config of file %s\n",
+				full_path);
+			goto out;
+		}
+	}
+
+out:
+	if (full_path)
+		free(full_path);
+
+	return err;
+}
+
+/**
+ * tplg_parse_include - Parse included files and additional directories
+ *			for searching them.
+ * @ tplg: topology context
+ * @ cfg: config that contains the included files and directories
+ * @ private: Base direcotry, which contains current config file,
+ *            for searching included files as well.
+ */
+static int tplg_parse_include(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	int err;
+	const char *base_dir, *inc_id;
+
+	if (snd_config_get_type(cfg) != SND_CONFIG_TYPE_COMPOUND) {
+		SNDERR("error: compound is expected for include definition\n");
+		return -EINVAL;
+	}
+
+	/* directory of the included files */
+	base_dir = (const char *)private;
+	snd_config_get_id(cfg, &inc_id);
+
+	snd_config_for_each(i, next, cfg) {
+		const char *id;
+
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+
+		if (strcmp(id, "path") == 0) {
+			err = parse_include_path(tplg, n);
+			if (err < 0) {
+				SNDERR("error: failed to parse path %s\n",
+					inc_id);
+				return err;
+			}
+		}
+
+		if (strcmp(id, "include") == 0) {
+			err = parse_included_file(tplg, n, base_dir);
+			if (err < 0) {
+				SNDERR("error: failed to parse include %s\n",
+					inc_id);
+				return err;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg,
+			     const char *base_dir)
 {
 	snd_config_iterator_t i, next;
 	snd_config_t *n;
@@ -198,19 +449,111 @@ static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
 			continue;
 		}
 
+		if (strcmp(id, "SectionInclude") == 0) {
+			err = tplg_parse_compound(tplg, n,
+						  tplg_parse_include,
+						  (void *)base_dir);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
 		SNDERR("error: unknown section %s\n", id);
 	}
 	return 0;
 }
 
-static int tplg_load_config(const char *file, snd_config_t **cfg)
+/**
+ * open_tplg_file - Search and open a topology configuration file.
+ * @file: Name of the configuration file.
+ * @base_dir: Optional, directory of the parent config file of this file.
+ * @include_paths: Optional, addtional directories to search the file.
+ *
+ * This function will search and open the file in the following order
+ * of priority:
+ * 1. directly open the file by its name;
+ * 2. search for the file name in the directory of its parent file;
+ * 3. search for the file name in "usr/share/alsa/topology";
+ * 4. search for the file name in user specified additional directories,
+ *    which are subdirectories of "usr/share/alsa/topology".
+ */
+static FILE *open_tplg_file(const char *file, const char *base_dir,
+	struct list_head *include_paths)
+{
+	FILE *fp;
+	struct list_head *pos, *npos, *base;
+	struct tplg_path *path;
+	char *full_path = NULL;
+
+	fp = fopen(file, "r");
+	if (fp)
+		goto out;
+
+	full_path = calloc(1, PATH_MAX + 1);
+	if (!full_path)
+		return NULL;
+
+	/* search file in base directory */
+	if (base_dir) {
+		strncpy(full_path, base_dir, PATH_MAX);
+		strcat(full_path, "/");
+		strcat(full_path, file);
+		fp = fopen(full_path, "r");
+		if (fp)
+			goto out;
+	}
+
+	/* search file in top installation directory */
+	strcpy(full_path, install_dir);
+	strcat(full_path, file);
+	fp = fopen(full_path, "r");
+	if (fp)
+		goto out;
+
+	/* search file in user specified include paths */
+	if (include_paths) {
+		base = include_paths;
+		list_for_each_safe(pos, npos, base) {
+			path = list_entry(pos, struct tplg_path, list);
+			if (!path->dir)
+				continue;
+
+			strncpy(full_path, path->dir, PATH_MAX);
+			strcat(full_path, "/");
+			strcat(full_path, file);
+			fp = fopen(full_path, "r");
+			if (fp)
+				goto out;
+		}
+	}
+
+out:
+	if (full_path)
+		free(full_path);
+
+	return fp;
+}
+
+
+/**
+ * tplg_load_config - Load the config from a file.
+ * @file: Name of the config file to open and load.
+ * @base_dir: Optional, directory of the parent config file, to search
+ *            this file.
+ * @include_paths: Optional, addtional directories to search the file.
+ * @cfg: output config loaded from this file.
+ *
+ */
+static int tplg_load_config(const char *file, const char *base_dir,
+			    struct list_head *include_paths,
+			    snd_config_t **cfg)
 {
 	FILE *fp;
 	snd_input_t *in;
 	snd_config_t *top;
 	int ret;
 
-	fp = fopen(file, "r");
+	fp = open_tplg_file(file, base_dir, include_paths);
 	if (fp == NULL) {
 		SNDERR("error: could not open configuration file %s",
 			file);
@@ -290,6 +633,7 @@ int snd_tplg_build_file(snd_tplg_t *tplg, const char *infile,
 	const char *outfile)
 {
 	snd_config_t *cfg = NULL;
+	char *base_dir, *infile_bak = NULL;
 	int err = 0;
 
 	tplg->out_fd =
@@ -300,14 +644,26 @@ int snd_tplg_build_file(snd_tplg_t *tplg, const char *infile,
 		return -errno;
 	}
 
-	err = tplg_load_config(infile, &cfg);
+	err = tplg_load_config(infile, NULL, NULL, &cfg);
 	if (err < 0) {
 		SNDERR("error: failed to load topology file %s\n",
 			infile);
 		goto out_close;
 	}
 
-	err = tplg_parse_config(tplg, cfg);
+	/* Set the base directory from the config file path. Name of
+	 * included topology config files can be relative to this base.
+	 * Get dirname on the duplicated path because dirname() can
+	 * modify input.
+	 */
+	infile_bak = strndup(infile, PATH_MAX);
+	if (!infile_bak) {
+		err = -ENOMEM;
+		goto out;
+	}
+	base_dir = dirname(infile_bak);
+
+	err = tplg_parse_config(tplg, cfg, base_dir);
 	if (err < 0) {
 		SNDERR("error: failed to parse topology\n");
 		goto out;
@@ -327,6 +683,9 @@ int snd_tplg_build_file(snd_tplg_t *tplg, const char *infile,
 
 out:
 	snd_config_delete(cfg);
+	if (infile_bak)
+		free(infile_bak);
+
 out_close:
 	close(tplg->out_fd);
 	return err;
@@ -435,6 +794,8 @@ snd_tplg_t *snd_tplg_new(void)
 	if (!tplg)
 		return NULL;
 
+	INIT_LIST_HEAD(&tplg->include_paths);
+	INIT_LIST_HEAD(&tplg->child_cfg_list);
 	tplg->manifest.size = sizeof(struct snd_soc_tplg_manifest);
 
 	INIT_LIST_HEAD(&tplg->tlv_list);
@@ -479,5 +840,8 @@ void snd_tplg_free(snd_tplg_t *tplg)
 	tplg_elem_free_list(&tplg->token_list);
 	tplg_elem_free_list(&tplg->tuple_list);
 
+	free_include_paths(tplg);
+	free_child_configs(tplg);
+
 	free(tplg);
 }
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index cfde4cc..ce8f4b3 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -48,6 +48,11 @@ struct snd_tplg {
 	/* out file */
 	int out_fd;
 
+	/* user specified paths to search included files */
+	struct list_head include_paths;
+	/* child configs of included files */
+	struct list_head child_cfg_list;
+
 	int verbose;
 	unsigned int version;
 
@@ -169,6 +174,18 @@ struct tplg_elem {
 	void (*free)(void *obj);
 };
 
+/* child topology config from an included file */
+struct tplg_config {
+	snd_config_t *cfg;
+	struct list_head list; /* list of all child configs */
+};
+
+/* path to search included files */
+struct tplg_path {
+	char *dir;
+	struct list_head list; /* list of all include paths */
+};
+
 struct map_elem {
 	const char *name;
 	int id;
-- 
2.5.0

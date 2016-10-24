From: mengdong.lin@linux.intel.com
Subject: [PATCH v4 2/3] alsaconf: Search included files under
	user specified configuration directories
Date: Mon, 24 Oct 2016 21:22:11 +0800
Message-ID: <0a3d891a0a3c09c3f844a06eb6189ede96ec5754.1477315063.git.mengdong.lin@linux.intel.com>
References: <cover.1477315063.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E7CF266C10
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 15:21:00 +0200 (CEST)
In-Reply-To: <cover.1477315063.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Users can include file by giving a relative path or just a file name via
alsaconf syntax <xxx>. ALSA conf will search the file in top configuration
directory and additional configuration directories defined by users via
alsaconf syntax <searchdir:xxx>.

ALSA conf will search and open an included file in the following order
of priority:

1. directly open the file by its name;
2. search for the file name in top config direcotry "/usr/share/alsa/";
3. search for the file name in additional configuration directories
   specified by users, via alsaconf syntax
   <searchdir:relative-path/to/user/share/alsa>;
   These directories will be searched in the same order as their
   definition.

The configuration directories defined by a file will only be used to
search the files included by this file.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/conf.c b/src/conf.c
index a516611..c0999bc 100644
--- a/src/conf.c
+++ b/src/conf.c
@@ -456,6 +456,18 @@ struct filedesc {
 	snd_input_t *in;
 	unsigned int line, column;
 	struct filedesc *next;
+
+	/* list of the include paths (configuration directories),
+	 * defined by <searchdir:relative-path/to/top-alsa-conf-dir>,
+	 * for searching its included files.
+	 */
+	struct list_head include_paths;
+};
+
+/* path to search included files */
+struct include_path {
+	char *dir;
+	struct list_head list;
 };
 
 #define LOCAL_ERROR			(-0x68000000)
@@ -501,6 +513,108 @@ static inline void snd_config_unlock(void) { }
 
 #endif
 
+/**
+ * Add a diretory to the paths to search included files.
+ * param fd -  File object that owns these paths to search files included by it.
+ * param dir - Path of the directory to add. Allocated externally and need to
+*              be freed manually later.
+ * return - Zero if successful, otherwise a negative error code.
+ *
+ * The direcotry should be a subdiretory of top configuration directory
+ * "/usr/share/alsa/".
+ */
+static int add_include_path(struct filedesc *fd, char *dir)
+{
+	struct include_path *path;
+
+	path = calloc(1, sizeof(*path));
+	if (!path)
+		return -ENOMEM;
+
+	path->dir = dir;
+	list_add_tail(&path->list, &fd->include_paths);
+	return 0;
+}
+
+/**
+ * Free all include paths of a file descriptor.
+ * param fd - File object that owns these paths to search files included by it.
+ */
+static void free_include_paths(struct filedesc *fd)
+{
+	struct list_head *pos, *npos, *base;
+	struct include_path *path;
+
+	base = &fd->include_paths;
+	list_for_each_safe(pos, npos, base) {
+		path = list_entry(pos, struct include_path, list);
+		list_del(&path->list);
+		if (path->dir)
+			free(path->dir);
+		free(path);
+	}
+}
+
+/**
+ * Search and open a file, and creates a new input object reading from the file.
+ * param inputp - The functions puts the pointer to the new input object
+ *               at the address specified by \p inputp.
+ * param file - Name of the configuration file.
+ * param include_paths - Optional, addtional directories to search the file.
+ * return - Zero if successful, otherwise a negative error code.
+ *
+ * This function will search and open the file in the following order
+ * of priority:
+ * 1. directly open the file by its name;
+ * 2. search for the file name in top configuration directory
+ *     "/usr/share/alsa/";
+ * 3. search for the file name in in additional configuration directories
+ *     specified by users, via alsaconf syntax
+ *     <searchdir:relative-path/to/user/share/alsa>;
+ *     These directories should be subdirectories of /usr/share/alsa.
+ */
+static int input_stdio_open(snd_input_t **inputp, const char *file,
+			    struct list_head *include_paths)
+{
+	struct list_head *pos, *base;
+	struct include_path *path;
+	char full_path[PATH_MAX + 1];
+	int err = 0;
+
+	err = snd_input_stdio_open(inputp, file, "r");
+	if (err == 0)
+		goto out;
+
+	if (file[0] == '/') /* not search file with absolute path */
+		return err;
+
+	/* search file in top configuration directory /usr/share/alsa */
+	snprintf(full_path, PATH_MAX, "%s/%s", ALSA_CONFIG_DIR, file);
+	err = snd_input_stdio_open(inputp, full_path, "r");
+	if (err == 0)
+		goto out;
+
+	/* search file in user specified include paths. These directories
+	 * are subdirectories of /usr/share/alsa.
+	 */
+	if (include_paths) {
+		base = include_paths;
+		list_for_each(pos, base) {
+			path = list_entry(pos, struct include_path, list);
+			if (!path->dir)
+				continue;
+
+			snprintf(full_path, PATH_MAX, "%s/%s", path->dir, file);
+			err = snd_input_stdio_open(inputp, full_path, "r");
+			if (err == 0)
+				goto out;
+		}
+	}
+
+out:
+	return err;
+}
+
 static int safe_strtoll(const char *str, long long *val)
 {
 	long long v;
@@ -629,10 +743,44 @@ static int get_char_skip_comments(input_t *input)
 			char *str;
 			snd_input_t *in;
 			struct filedesc *fd;
+			DIR *dirp;
 			int err = get_delimstring(&str, '>', input);
 			if (err < 0)
 				return err;
+
+			if (!strncmp(str, "searchdir:", 10)) {
+				/* directory to search included files */
+				char *tmp;
+
+				tmp = malloc(strlen(ALSA_CONFIG_DIR) + 1
+					     + strlen(str + 10) + 1);
+				if (tmp == NULL) {
+					free(str);
+					return -ENOMEM;
+				}
+				sprintf(tmp, ALSA_CONFIG_DIR "/%s", str + 10);
+				free(str);
+				str = tmp;
+
+				dirp = opendir(str);
+				if (!dirp) {
+					SNDERR("Invalid search dir %s", str);
+					free(str);
+					return -EINVAL;
+				}
+				closedir(dirp);
+
+				err = add_include_path(input->current, str);
+				if (err < 0) {
+					SNDERR("Cannot add search dir %s", str);
+					free(str);
+					return err;
+				}
+				continue;
+			}
+
 			if (!strncmp(str, "confdir:", 8)) {
+				/* file in the specified directory */
 				char *tmp = malloc(strlen(ALSA_CONFIG_DIR) + 1 + strlen(str + 8) + 1);
 				if (tmp == NULL) {
 					free(str);
@@ -641,8 +789,12 @@ static int get_char_skip_comments(input_t *input)
 				sprintf(tmp, ALSA_CONFIG_DIR "/%s", str + 8);
 				free(str);
 				str = tmp;
+				err = snd_input_stdio_open(&in, str, "r");
+			} else { /* absolute or relative file path */
+				err = input_stdio_open(&in, str,
+						&input->current->include_paths);
 			}
-			err = snd_input_stdio_open(&in, str, "r");
+
 			if (err < 0) {
 				SNDERR("Cannot access file %s", str);
 				free(str);
@@ -658,6 +810,7 @@ static int get_char_skip_comments(input_t *input)
 			fd->next = input->current;
 			fd->line = 1;
 			fd->column = 0;
+			INIT_LIST_HEAD(&fd->include_paths);
 			input->current = fd;
 			continue;
 		}
@@ -1668,6 +1821,7 @@ static int snd_config_load1(snd_config_t *config, snd_input_t *in, int override)
 	fd->line = 1;
 	fd->column = 0;
 	fd->next = NULL;
+	INIT_LIST_HEAD(&fd->include_paths);
 	input.current = fd;
 	input.unget = 0;
 	err = parse_defs(config, &input, 0, override);
@@ -1708,9 +1862,12 @@ static int snd_config_load1(snd_config_t *config, snd_input_t *in, int override)
 		fd_next = fd->next;
 		snd_input_close(fd->in);
 		free(fd->name);
+		free_include_paths(fd);
 		free(fd);
 		fd = fd_next;
 	}
+
+	free_include_paths(fd);
 	free(fd);
 	return err;
 }
-- 
2.5.0

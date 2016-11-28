From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 1/3] ucm: Skip component directories when
	scanning sound card configuration files
Date: Mon, 28 Nov 2016 13:33:34 +0800
Message-ID: <fd9afbc2c36d5374fdc3402002ec34dc0203e83f.1480309753.git.mengdong.lin@linux.intel.com>
References: <cover.1480309753.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 082012669E3
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2016 06:31:39 +0100 (CET)
In-Reply-To: <cover.1480309753.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Cards are defined by machines. DSPs embedded in SoC and off-soc codecs
can be taken as components for machines, and can be reused by different
machines/cards. Codec and SoC vendors can define their own UCM config
files. If a codec or DSP is used by a machine, the card configuration file
can include the conf file of the codec and DSP. Later patches will
complete support for this feature.

Two new directories will be used to store the UCM configuration files for
a specific codec or DSP firmware:
- /usr/share/alsa/ucm/dsps ... for DSP embedded in SoC
- /usr/share/alsa/ucm/codecs ... for off-soc codecs

These two directories will be skipped when UCM manager scans the card
directories under /usr/share/alsa/ucm.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 13f62d7..5c99ab4 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -36,6 +36,25 @@
 /** The name of the environment variable containing the UCM directory */
 #define ALSA_CONFIG_UCM_VAR "ALSA_CONFIG_UCM"
 
+/* Directories to store UCM configuration files for components, like
+ * off-soc codecs or embedded DSPs. Components can define their own
+ * devices and sequences, to be reused by sound cards/machines. UCM
+ * manager should not scan these component directories.
+ * Machine use case files can include component configratuation files
+ * via alsaconf syntax:
+ * <searchdir:component-directory-name> and <component-conf-file-name>.
+ * Alsaconf will import the included files automatically. After including
+ * a component file, a machine device's sequence can enable or disable
+ * a component device via syntax:
+ * enadev "component_device_name"
+ * disdev "component_device_name"
+ */
+static const char * const component_dir[] = {
+	"codecs",	/* for off-soc codecs */
+	"dsps",		/* for DSPs embedded in SoC */
+	NULL,		/* terminator */
+};
+
 static int parse_sequence(snd_use_case_mgr_t *uc_mgr,
 			  struct list_head *base,
 			  snd_config_t *cfg);
@@ -1259,7 +1278,28 @@ static int filename_filter(const struct dirent *dirent)
 	return 0;
 }
 
-/* scan all cards and comments */
+/* whether input dir is a predefined component directory */
+static int is_component_directory(const char *dir)
+{
+	int i = 0;
+
+	while (component_dir[i]) {
+		if (!strncmp(dir, component_dir[i], PATH_MAX))
+			return 1;
+		i++;
+	};
+
+	return 0;
+}
+
+/* scan all cards and comments
+ *
+ * Cards are defined by machines. Each card/machine installs its UCM
+ * configuration files in a subdirectory with the same name as the sound
+ * card under /usr/share/alsa/ucm. This function will scan all the card
+ * directories and skip the component directories defined in the array
+ * component_dir.
+ */
 int uc_mgr_scan_master_configs(const char **_list[])
 {
 	char filename[MAX_FILE], dfl[MAX_FILE];
@@ -1309,6 +1349,11 @@ int uc_mgr_scan_master_configs(const char **_list[])
 	}
 
 	for (i = 0; i < cnt; i++) {
+
+		/* Skip the directories for component devices */
+		if (is_component_directory(namelist[i]->d_name))
+			continue;
+
 		err = load_master_config(namelist[i]->d_name, &cfg);
 		if (err < 0)
 			goto __err;
-- 
2.7.4

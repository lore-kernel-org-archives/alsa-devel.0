From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 07/14] ASoC: Intel: Skylake: Add function to cleanup debugfs interface
Date: Wed,  5 Jun 2019 15:45:49 +0200
Message-ID: <20190605134556.10322-8-amadeuszx.slawinski@linux.intel.com>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Currently debugfs has no cleanup function. Add skl_debufs_exit function
so we can clean after ourselves properly.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/skylake/skl-debug.c | 9 +++++++++
 sound/soc/intel/skylake/skl.h       | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index 5d7ac2ee7a3c..e81c3dafc0d0 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -259,3 +259,12 @@ struct skl_debug *skl_debugfs_init(struct skl *skl)
 	debugfs_remove_recursive(d->fs);
 	return NULL;
 }
+
+void skl_debugfs_exit(struct skl *skl)
+{
+	struct skl_debug *d = skl->debugfs;
+
+	debugfs_remove_recursive(d->fs);
+
+	d = NULL;
+}
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 85f8bb6687dc..d2e269867a44 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -164,6 +164,7 @@ struct skl_module_cfg;
 
 #ifdef CONFIG_DEBUG_FS
 struct skl_debug *skl_debugfs_init(struct skl *skl);
+void skl_debugfs_exit(struct skl *skl);
 void skl_debug_init_module(struct skl_debug *d,
 			struct snd_soc_dapm_widget *w,
 			struct skl_module_cfg *mconfig);
@@ -172,6 +173,10 @@ static inline struct skl_debug *skl_debugfs_init(struct skl *skl)
 {
 	return NULL;
 }
+
+static inline void skl_debugfs_exit(struct skl *skl)
+{}
+
 static inline void skl_debug_init_module(struct skl_debug *d,
 					 struct snd_soc_dapm_widget *w,
 					 struct skl_module_cfg *mconfig)
-- 
2.17.1

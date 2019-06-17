From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2 06/11] ASoC: Intel: Skylake: Add function to cleanup debugfs interface
Date: Mon, 17 Jun 2019 13:36:39 +0200
Message-ID: <20190617113644.25621-7-amadeuszx.slawinski@linux.intel.com>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
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
index 69cbe9eb026b..b9b4a72a4334 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -251,3 +251,12 @@ struct skl_debug *skl_debugfs_init(struct skl *skl)
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
index e7870ec81a9b..6fab1a2e133a 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -155,6 +155,7 @@ struct skl_module_cfg;
 
 #ifdef CONFIG_DEBUG_FS
 struct skl_debug *skl_debugfs_init(struct skl *skl);
+void skl_debugfs_exit(struct skl *skl);
 void skl_debug_init_module(struct skl_debug *d,
 			struct snd_soc_dapm_widget *w,
 			struct skl_module_cfg *mconfig);
@@ -163,6 +164,10 @@ static inline struct skl_debug *skl_debugfs_init(struct skl *skl)
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

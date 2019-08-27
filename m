From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 5/6] ASoC: Intel: Skylake: Release topology when we are done with it
Date: Tue, 27 Aug 2019 16:17:11 +0200
Message-ID: <20190827141712.21015-6-amadeuszx.slawinski@linux.intel.com>
References: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Currently topology is kept in memory while driver is running. It's
unnecessary, as it's only needed during parsing.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 20 ++++++++++----------
 sound/soc/intel/skylake/skl.h          |  1 -
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index ae5c75d03fdc..69cd7a81bf2a 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3579,23 +3579,25 @@ int skl_tplg_init(struct snd_soc_component *component, struct hdac_bus *bus)
 	 * The complete tplg for SKL is loaded as index 0, we don't use
 	 * any other index
 	 */
-	ret = snd_soc_tplg_component_load(component,
-					&skl_tplg_ops, fw, 0);
+	ret = snd_soc_tplg_component_load(component, &skl_tplg_ops, fw, 0);
 	if (ret < 0) {
 		dev_err(bus->dev, "tplg component load failed%d\n", ret);
-		release_firmware(fw);
-		return -EINVAL;
+		goto err;
 	}
 
-	skl->tplg = fw;
 	ret = skl_tplg_create_pipe_widget_list(component);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		dev_err(bus->dev, "tplg create pipe widget list failed%d\n",
+				ret);
+		goto err;
+	}
 
 	list_for_each_entry(ppl, &skl->ppl_list, node)
 		skl_tplg_set_pipe_type(skl, ppl->pipe);
 
-	return 0;
+err:
+	release_firmware(fw);
+	return ret;
 }
 
 void skl_tplg_exit(struct snd_soc_component *component, struct hdac_bus *bus)
@@ -3609,6 +3611,4 @@ void skl_tplg_exit(struct snd_soc_component *component, struct hdac_bus *bus)
 
 	/* clean up topology */
 	snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);
-
-	release_firmware(skl->tplg);
 }
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index f8c714153610..2bfbf59277c4 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -75,7 +75,6 @@ struct skl_dev {
 	const char *fw_name;
 	char tplg_name[64];
 	unsigned short pci_id;
-	const struct firmware *tplg;
 
 	int supend_active;
 
-- 
2.17.1

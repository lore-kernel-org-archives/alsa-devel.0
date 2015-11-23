From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: Intel: Skylake: fix memory leak
Date: Mon, 23 Nov 2015 16:38:48 +0530
Message-ID: <1448276928-9081-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

We have requested the firmware but missed releasing it.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/intel/skylake/skl-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 0937ea2..87b9c3e 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1251,6 +1251,7 @@ int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
 	 */
 	ret = snd_soc_tplg_component_load(&platform->component,
 					&skl_tplg_ops, fw, 0);
+	release_firmware(fw);
 	if (ret < 0) {
 		dev_err(bus->dev, "tplg component load failed%d\n", ret);
 		return -EINVAL;
-- 
1.9.1

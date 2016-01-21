From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: Intel: Skylake: Fix memory leak
Date: Thu, 21 Jan 2016 17:27:59 +0530
Message-ID: <1453377479-8487-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

If snd_soc_tplg_component_load() fails we just printed an error message
and returned the error code but we missed releasing the firmware.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/intel/skylake/skl-topology.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 4624556..e81c020 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1510,6 +1510,7 @@ int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
 					&skl_tplg_ops, fw, 0);
 	if (ret < 0) {
 		dev_err(bus->dev, "tplg component load failed%d\n", ret);
+		release_firmware(fw);
 		return -EINVAL;
 	}
 
-- 
1.9.1

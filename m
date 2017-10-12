From: Chintan Patel <chintan.m.patel@intel.com>
Subject: [PATCH v2] ASoC: Intel: Skylake: Decrease loglevel for topology loading
Date: Thu, 12 Oct 2017 09:44:37 -0700
Message-ID: <1507826678-25509-1-git-send-email-chintan.m.patel@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: vinod.koul@intel.com, Chintan Patel <chintan.m.patel@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jeeja KP <jeeja.kp@intel.com>, "guneshwor.o.singh@intel.com" <guneshwor.o.singh@intel.com>, Shreyas NC <shreyas.nc@intel.com>, Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>, Ramesh Babu <ramesh.babu@intel.com>, Dharageswari R <dharageswari.r@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

In case of failure in loading customize topology firmware, dfw_sst.bin
gets loaded. However, current log provides this message as error even
after successfully falling back to default topology "dfw_sst.bin".

Hence to convey proper message, changing log level and message.

Signed-off-by: Chintan Patel <chintan.m.patel@intel.com>
---
Changes in v2:
Addressing review comments from Takashi Iwai by changing
loglevel as info

sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 22f768ca3c73..12f383fd7c39 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3404,7 +3404,7 @@ int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
 
 	ret = request_firmware(&fw, skl->tplg_name, bus->dev);
 	if (ret < 0) {
-		dev_err(bus->dev, "tplg fw %s load failed with %d\n",
+		dev_info(bus->dev, "tplg fw %s load failed with %d, falling back to dfw_sst.bin",
 				skl->tplg_name, ret);
 		ret = request_firmware(&fw, "dfw_sst.bin", bus->dev);
 		if (ret < 0) {
-- 
1.9.1

From: Chintan Patel <chintan.m.patel@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Decrease loglevel for
	topology loading
Date: Tue, 12 Sep 2017 12:54:58 -0700
Message-ID: <1505246098-10366-1-git-send-email-chintan.m.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 69A66266B1C
 for <alsa-devel@alsa-project.org>; Tue, 12 Sep 2017 21:55:29 +0200 (CEST)
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
Cc: Chintan Patel <chintan.m.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

In case of failure in loading customize topology firmware, dfw_sst.bin
gets loaded. However, current log provides this message as error even
after successfully falling back to default topology "dfw_sst.bin".

Hence to convey proper message, changing log level and message.

Signed-off-by: Chintan Patel <chintan.m.patel@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 22f768ca3c73..14dafa9f5b35 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -3404,7 +3404,7 @@ int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
 
 	ret = request_firmware(&fw, skl->tplg_name, bus->dev);
 	if (ret < 0) {
-		dev_err(bus->dev, "tplg fw %s load failed with %d\n",
+		dev_warn(bus->dev, "tplg fw %s load failed with %d, falling back to dfw_sst.bin",
 				skl->tplg_name, ret);
 		ret = request_firmware(&fw, "dfw_sst.bin", bus->dev);
 		if (ret < 0) {
-- 
1.9.1

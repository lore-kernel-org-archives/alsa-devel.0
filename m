From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 04/17] ASoC: Intel: Skylake: Fix to ignore
	codec_mask check in probe
Date: Tue, 27 Oct 2015 09:22:47 +0900
Message-ID: <1445905380-18167-5-git-send-email-vinod.koul@intel.com>
References: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B850265191
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 01:23:23 +0100 (CET)
In-Reply-To: <1445905380-18167-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

We have both I2S and hda codec support in the driver. codec_mask
check is relevant only for hda codec and some boards may have
only I2S Codec, so removed probe error in case no hda codec is
found and update the log to info as it may not be error.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 5319529aedf7..211ef6e2fa21 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -434,8 +434,7 @@ static int skl_first_init(struct hdac_ext_bus *ebus)
 
 	/* codec detection */
 	if (!bus->codec_mask) {
-		dev_err(bus->dev, "no codecs found!\n");
-		return -ENODEV;
+		dev_info(bus->dev, "no hda codecs found!\n");
 	}
 
 	return 0;
-- 
2.4.3

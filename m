From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 3/4] ASoC: Intel: Skylake: Remove return check
	for skl_codec_create()
Date: Fri, 28 Jul 2017 16:12:15 +0530
Message-ID: <20170728104216.26859-3-guneshwor.o.singh@intel.com>
References: <20170728104216.26859-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 24AD12676E7
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 12:43:07 +0200 (CEST)
In-Reply-To: <20170728104216.26859-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

Since skl_codec_create() always returns 0, make it return void and remove
return check.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index a56dfde3928c..f6dc5497ea50 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -528,7 +528,7 @@ static int probe_codec(struct hdac_ext_bus *ebus, int addr)
 }
 
 /* Codec initialization */
-static int skl_codec_create(struct hdac_ext_bus *ebus)
+static void skl_codec_create(struct hdac_ext_bus *ebus)
 {
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	int c, max_slots;
@@ -559,8 +559,6 @@ static int skl_codec_create(struct hdac_ext_bus *ebus)
 			}
 		}
 	}
-
-	return 0;
 }
 
 static const struct hdac_bus_ops bus_core_ops = {
@@ -612,9 +610,7 @@ static void skl_probe_work(struct work_struct *work)
 		dev_info(bus->dev, "no hda codecs found!\n");
 
 	/* create codec instances */
-	err = skl_codec_create(ebus);
-	if (err < 0)
-		goto out_err;
+	skl_codec_create(ebus);
 
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
 		err = snd_hdac_display_power(bus, false);
-- 
2.13.0

From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 09/11] ASoC: hdac_hdmi: Fix static checker
	warning for sprintf usage
Date: Tue,  7 Nov 2017 16:16:24 +0530
Message-ID: <20171107104626.25800-10-guneshwor.o.singh@intel.com>
References: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F15C2673AF
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 11:47:38 +0100 (CET)
In-Reply-To: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

Use snprintf instead of sprintf to shut the warning.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index e824d47cc22b..6f3ff15c0962 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -942,7 +942,8 @@ static int hdac_hdmi_create_pin_port_muxs(struct hdac_ext_device *edev,
 	if (!se)
 		return -ENOMEM;
 
-	sprintf(kc_name, "Pin %d port %d Input", pin->nid, port->id);
+	snprintf(kc_name, NAME_SIZE, "Pin %d port %d Input",
+						pin->nid, port->id);
 	kc->name = devm_kstrdup(&edev->hdac.dev, kc_name, GFP_KERNEL);
 	if (!kc->name)
 		return -ENOMEM;
-- 
2.14.2

From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH] ASoC: hdac_hdmi: Add vendor id for Cannonlake
	HDMI codec
Date: Thu, 21 Dec 2017 08:45:29 +0530
Message-ID: <20171221031529.14234-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C2164266DD5
 for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2017 04:15:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

Cannonlake HDMI codec has the same nid as Geminilake. This adds the
vendor id for Cannonlake in hdmi device id list.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 68a4a6b4e68e..69d7404dfbc4 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -2184,6 +2184,8 @@ static const struct hda_device_id hdmi_list[] = {
 	HDA_CODEC_EXT_ENTRY(0x80862809, 0x100000, "Skylake HDMI", 0),
 	HDA_CODEC_EXT_ENTRY(0x8086280a, 0x100000, "Broxton HDMI", 0),
 	HDA_CODEC_EXT_ENTRY(0x8086280b, 0x100000, "Kabylake HDMI", 0),
+	HDA_CODEC_EXT_ENTRY(0x8086280c, 0x100000, "Cannonlake HDMI",
+						   &intel_glk_drv_data),
 	HDA_CODEC_EXT_ENTRY(0x8086280d, 0x100000, "Geminilake HDMI",
 						   &intel_glk_drv_data),
 	{}
-- 
2.15.1

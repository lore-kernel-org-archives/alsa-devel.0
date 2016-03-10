From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] ASoC: hdac_hdmi: Fix infoframe programming
Date: Thu, 10 Mar 2016 09:04:07 +0530
Message-ID: <1457580847-32479-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id CFFB3260694
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 04:33:55 +0100 (CET)
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Audio infoframe used incorrect buffer, so fix it.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 7851dd2..4f7bd1f 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -303,7 +303,6 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 		if (ret < 0)
 			return ret;
 
-		dip = (u8 *)&frame;
 		break;
 
 	case DRM_ELD_CONN_TYPE_DP:
@@ -332,9 +331,9 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 	/*  Fill infoframe. Index auto-incremented */
 	hdac_hdmi_set_dip_index(hdac, pin_nid, 0x0, 0x0);
 	if (conn_type == DRM_ELD_CONN_TYPE_HDMI) {
-		for (i = 0; i < sizeof(frame); i++)
+		for (i = 0; i < sizeof(buffer); i++)
 			snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
-				AC_VERB_SET_HDMI_DIP_DATA, dip[i]);
+				AC_VERB_SET_HDMI_DIP_DATA, buffer[i]);
 	} else {
 		for (i = 0; i < sizeof(dp_ai); i++)
 			snd_hdac_codec_write(&hdac->hdac, pin_nid, 0,
-- 
1.9.1

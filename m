From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 08/18] ALSA: hda: move patch_analog to use hdac
	helpers
Date: Tue,  6 Oct 2015 16:07:45 +0100
Message-ID: <1444144075-28963-9-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D768265917
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:10:31 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Move patch_analog to use newly moved snd_hdac_read/write_codec()
APIs.

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/patch_analog.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index c033a4ee6547..1b21a13772dc 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -89,11 +89,13 @@ static void ad198x_power_eapd_write(struct hda_codec *codec, hda_nid_t front,
 				hda_nid_t hp)
 {
 	if (snd_hda_query_pin_caps(codec, front) & AC_PINCAP_EAPD)
-		snd_hda_codec_write(codec, front, 0, AC_VERB_SET_EAPD_BTLENABLE,
-			    !codec->inv_eapd ? 0x00 : 0x02);
+		snd_hdac_codec_write(&codec->core, front, 0,
+				     AC_VERB_SET_EAPD_BTLENABLE,
+				     !codec->inv_eapd ? 0x00 : 0x02);
 	if (snd_hda_query_pin_caps(codec, hp) & AC_PINCAP_EAPD)
-		snd_hda_codec_write(codec, hp, 0, AC_VERB_SET_EAPD_BTLENABLE,
-			    !codec->inv_eapd ? 0x00 : 0x02);
+		snd_hdac_codec_write(&codec->core, hp, 0,
+				     AC_VERB_SET_EAPD_BTLENABLE,
+				     !codec->inv_eapd ? 0x00 : 0x02);
 }
 
 static void ad198x_power_eapd(struct hda_codec *codec)
-- 
2.4.3

From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 06/18] ALSA: hda: move hda_jack to use hdac
	helpers
Date: Tue,  6 Oct 2015 16:07:43 +0100
Message-ID: <1444144075-28963-7-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8607B26574C
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:08:45 +0200 (CEST)
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

Move hda_jack to use newly moved snd_hdac_read_codec() API

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_jack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 366efbf87d41..e9f458a20a52 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -55,11 +55,11 @@ static u32 read_pin_sense(struct hda_codec *codec, hda_nid_t nid)
 	if (!codec->no_trigger_sense) {
 		pincap = snd_hda_query_pin_caps(codec, nid);
 		if (pincap & AC_PINCAP_TRIG_REQ) /* need trigger? */
-			snd_hda_codec_read(codec, nid, 0,
-					AC_VERB_SET_PIN_SENSE, 0);
+			snd_hdac_codec_read(&codec->core, nid, 0,
+					    AC_VERB_SET_PIN_SENSE, 0);
 	}
-	val = snd_hda_codec_read(codec, nid, 0,
-				  AC_VERB_GET_PIN_SENSE, 0);
+	val = snd_hdac_codec_read(&codec->core, nid, 0, AC_VERB_GET_PIN_SENSE,
+				  0);
 	if (codec->inv_jack_detect)
 		val ^= AC_PINSENSE_PRESENCE;
 	return val;
-- 
2.4.3

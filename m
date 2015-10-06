From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 04/18] ALSA: hda: move hda_generic to use hdac
	helpers
Date: Tue,  6 Oct 2015 16:07:41 +0100
Message-ID: <1444144075-28963-5-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 49DDC265747
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:08:43 +0200 (CEST)
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

Mover hda_generic to use newly moved snd_hdac_read/write_codec() and
snd_hdac_check_power_state APIs.

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_generic.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 24f91114a32c..b0ef87f648bc 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -841,9 +841,9 @@ static hda_nid_t path_power_update(struct hda_codec *codec,
 			state = AC_PWRST_D0;
 		else
 			state = AC_PWRST_D3;
-		if (!snd_hda_check_power_state(codec, nid, state)) {
-			snd_hda_codec_write(codec, nid, 0,
-					    AC_VERB_SET_POWER_STATE, state);
+		if (!snd_hdac_check_power_state(&codec->core, nid, state)) {
+			snd_hdac_codec_write(&codec->core, nid, 0,
+					     AC_VERB_SET_POWER_STATE, state);
 			changed = nid;
 			/* all known codecs seem to be capable to handl
 			 * widgets state even in D3, so far.
@@ -865,7 +865,8 @@ static void sync_power_state_change(struct hda_codec *codec, hda_nid_t nid)
 {
 	if (nid) {
 		msleep(10);
-		snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_POWER_STATE, 0);
+		snd_hdac_codec_read(&codec->core, nid, 0,
+				    AC_VERB_GET_POWER_STATE, 0);
 	}
 }
 
-- 
2.4.3

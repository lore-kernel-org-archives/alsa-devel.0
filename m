From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 02/18] ALSA: hda: move hda beep to use hdac
	helpers
Date: Tue,  6 Oct 2015 16:07:39 +0100
Message-ID: <1444144075-28963-3-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2977F265727
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:08:40 +0200 (CEST)
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

Mover this driver to use newly moved snd_hdac_read/write_codec()
APIs.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_beep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index c397e7da0eac..ecf4a0b4fd63 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -44,8 +44,8 @@ static void generate_tone(struct hda_beep *beep, int tone)
 			beep->power_hook(beep, true);
 		beep->playing = 1;
 	}
-	snd_hda_codec_write(codec, beep->nid, 0,
-			    AC_VERB_SET_BEEP_CONTROL, tone);
+	snd_hdac_codec_write(&codec->core, beep->nid, 0,
+			     AC_VERB_SET_BEEP_CONTROL, tone);
 	if (!tone && beep->playing) {
 		beep->playing = 0;
 		if (beep->power_hook)
-- 
2.4.3

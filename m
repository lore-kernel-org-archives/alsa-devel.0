From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH] ALSA: hda/hdmi - consider eld_valid also in
	sync_eld_via_acomp()
Date: Thu, 13 Jun 2019 15:09:01 +0200
Message-ID: <20190613130901.26558-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B57EAF8076F
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 15:09:12 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

In the commit 7f641e26a6df9269cb25dd7a4b0a91d6586ed441 (ALSA: hda/hdmi
- Consider eld_valid when reporting jack event) the eld_valid check was
added for the jack event reports. Do the same in sync_eld_via_acomp()
function. Apparently, it is required for the NVIDIA proprietary driver
(monitor presence reported first, but ELD is available later).

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/pci/hda/patch_hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 0c61c05503f5..b522314ec5be 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1627,7 +1627,8 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 	if (jack == NULL)
 		goto unlock;
 	snd_jack_report(jack,
-			eld->monitor_present ? SND_JACK_AVOUT : 0);
+			(eld->monitor_present && eld->eld_valid) ?
+				SND_JACK_AVOUT : 0);
  unlock:
 	mutex_unlock(&per_pin->lock);
 }
-- 
2.20.1

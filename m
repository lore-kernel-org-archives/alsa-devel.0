From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: hda - Avoid possible race of beep
	on/off
Date: Tue,  3 Jul 2012 18:03:17 +0200
Message-ID: <1341331397-21182-5-git-send-email-tiwai@suse.de>
References: <1341331397-21182-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id AD5B4244EE
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 18:03:29 +0200 (CEST)
In-Reply-To: <1341331397-21182-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Call cancel_work_sync() when turning off the beep switch so that the
mute call is executed in a proper order.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_beep.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index e6cf2a2..0bc2315 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -165,12 +165,13 @@ static int snd_hda_do_attach(struct hda_beep *beep)
 int snd_hda_enable_beep_device(struct hda_codec *codec, int enable)
 {
 	struct hda_beep *beep = codec->beep;
-	enable = !!enable;
-	if (beep == NULL)
+	if (!beep)
 		return 0;
+	enable = !!enable;
 	if (beep->enabled != enable) {
 		beep->enabled = enable;
 		if (!enable) {
+			cancel_work_sync(&beep->beep_work);
 			/* turn off beep */
 			snd_hda_codec_write(beep->codec, beep->nid, 0,
 						  AC_VERB_SET_BEEP_CONTROL, 0);
-- 
1.7.10.4

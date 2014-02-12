From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 22/24] staging/line6: Convert to snd_card_new()
	with a device pointer
Date: Wed, 12 Feb 2014 11:35:38 +0100
Message-ID: <1392201340-27113-23-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 200B6265068
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:51 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B553CAC9B
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Also remove superfluous snd_card_set_dev() calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/line6/audio.c | 5 +++--
 drivers/staging/line6/midi.c  | 2 --
 drivers/staging/line6/pcm.c   | 2 --
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/line6/audio.c b/drivers/staging/line6/audio.c
index a92e21f7d55b..171d80c1b020 100644
--- a/drivers/staging/line6/audio.c
+++ b/drivers/staging/line6/audio.c
@@ -24,8 +24,9 @@ int line6_init_audio(struct usb_line6 *line6)
 	struct snd_card *card;
 	int err;
 
-	err = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
-			      THIS_MODULE, 0, &card);
+	err = snd_card_new(line6->ifcdev,
+			   SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
+			   THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/staging/line6/midi.c b/drivers/staging/line6/midi.c
index 3f6d78c585fb..c61cd0515baf 100644
--- a/drivers/staging/line6/midi.c
+++ b/drivers/staging/line6/midi.c
@@ -307,8 +307,6 @@ int line6_init_midi(struct usb_line6 *line6)
 	if (err < 0)
 		return err;
 
-	snd_card_set_dev(line6->card, line6->ifcdev);
-
 	err = snd_line6_new_midi(line6midi);
 	if (err < 0)
 		return err;
diff --git a/drivers/staging/line6/pcm.c b/drivers/staging/line6/pcm.c
index df8331bce175..661080b3c39d 100644
--- a/drivers/staging/line6/pcm.c
+++ b/drivers/staging/line6/pcm.c
@@ -501,8 +501,6 @@ int line6_init_pcm(struct usb_line6 *line6,
 	if (err < 0)
 		return err;
 
-	snd_card_set_dev(line6->card, line6->ifcdev);
-
 	err = snd_line6_new_pcm(line6pcm);
 	if (err < 0)
 		return err;
-- 
1.8.5.2

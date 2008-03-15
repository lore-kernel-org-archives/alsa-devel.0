From: Joachim Foerster <mls.JOFT@gmx.de>
Subject: [PATCH] [ML403-AC97CR] Remove duplicate
	snd_card_set_dev().
Date: Sat, 15 Mar 2008 10:43:09 +0100
Message-ID: <1205574189.14214.10.camel@md40100b.ft>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id BCE892442C
	for <alsa-devel@alsa-project.org>; Sat, 15 Mar 2008 10:43:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I noticed, that there was a change in ml403-ac97cr.c, which introduces a
second call of snd_card_set_dev() in the _probe()-function. The
"original" one is in the snd_ml403_ac97cr_create()-function.

According the other changes, I guess, we want to have it in the
_probe()-function, now (=> following patch)?


From: Joachim Foerster <JOFT@gmx.de>

We want to have snd_card_set_dev() in _probe(), but not a second one in
snd_ml403_ac97cr_create().

Signed-off-by: Joachim Foerster <JOFT@gmx.de>
---
 sound/drivers/ml403-ac97cr.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 05a871a..b654007 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1191,8 +1191,6 @@ snd_ml403_ac97cr_create(struct snd_card *card, struct platform_device *pfdev,
 		return err;
 	}
 
-	snd_card_set_dev(card, &pfdev->dev);
-
 	*rml403_ac97cr = ml403_ac97cr;
 	return 0;
 }
-- 
1.5.4.3

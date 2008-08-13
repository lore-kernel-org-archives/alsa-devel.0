From: Rene Herman <rene.herman@keyaccess.nl>
Subject: snd_assert() removal
Date: Wed, 13 Aug 2008 12:16:33 +0200
Message-ID: <48A2B481.9060808@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id D42D010385C
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 12:16:02 +0200 (CEST)
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi.

Just see the snd_assert() removal. Much better as far as I'm concerned 
but just as a remark -- there's many combined ones of the form:

diff --git a/sound/isa/cs423x/cs4236_lib.c b/sound/isa/cs423x/cs4236_lib.c
index 33e9cf1..6a85fdc 100644
--- a/sound/isa/cs423x/cs4236_lib.c
+++ b/sound/isa/cs423x/cs4236_lib.c
@@ -967,7 +967,8 @@ int snd_cs4236_mixer(struct snd_wss *chip)
         int err;
         struct snd_kcontrol_new *kcontrol;

-       snd_assert(chip != NULL && chip->card != NULL, return -EINVAL);
+       if (snd_BUG_ON(!chip || !chip->card))
+               return -EINVAL;
         card = chip->card;
         strcpy(card->mixername, snd_wss_chip_id(chip));

in there. Just thought I'd point that Andrew Morton has been pushing 
back on multiple conditions per regular BUG_ON()/WARN_ON() lately as 
they end up giving less useful information then split ones ("so what 
triggered?").

Just a remark as said but if you agree with him, maybe now is the best 
time to split them directly as well.

Rene.

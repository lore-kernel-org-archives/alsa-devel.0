From: Dan Carpenter <error27@gmail.com>
Subject: [patch -next] sound/es1688: add pedantic range checks
Date: Fri, 14 May 2010 16:48:28 +0200
Message-ID: <20100514144824.GB17487@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A1F224574
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 16:48:54 +0200 (CEST)
Received: by wwf26 with SMTP id 26so775172wwf.38
	for <alsa-devel@alsa-project.org>; Fri, 14 May 2010 07:48:53 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Jean Delvare <khali@linux-fr.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Smatch complains that if (dev == SNDRV_CARDS) we're one past the end of
the array.  That's unlikely to happen in real life, I suppose.

Also smatch complains about "strcpy(card->shortname, pcm->name);"
The "pcm->name" buffer is 80 characters and "card->shortname" is 32
characters.  If you follow the call paths it turns out we never actually
use more than 16 characters so it's not a problem.  But anyway, let's 
make it easy for people auditing this in the future.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index fdcce31..0cde813 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -149,10 +149,11 @@ static int __devinit snd_es1688_probe(struct snd_card *card, unsigned int n)
 	if (error < 0)
 		return error;
 
-	strcpy(card->driver, "ES1688");
-	strcpy(card->shortname, pcm->name);
-	sprintf(card->longname, "%s at 0x%lx, irq %i, dma %i", pcm->name,
-		chip->port, chip->irq, chip->dma8);
+	strlcpy(card->driver, "ES1688", sizeof(card->driver));
+	strlcpy(card->shortname, pcm->name, sizeof(card->shortname));
+	snprintf(card->longname, sizeof(card->longname),
+		"%s at 0x%lx, irq %i, dma %i", pcm->name, chip->port,
+		 chip->irq, chip->dma8);
 
 	if (fm_port[n] == SNDRV_AUTO_PORT)
 		fm_port[n] = port[n];	/* share the same port */
@@ -271,6 +272,8 @@ static int __devinit snd_es968_pnp_detect(struct pnp_card_link *pcard,
 		if (enable[dev] && isapnp[dev])
 			break;
 	}
+	if (dev == SNDRV_CARDS)
+		return -ENODEV;
 
 	error = snd_card_create(index[dev], id[dev], THIS_MODULE,
 				sizeof(struct snd_es1688), &card);

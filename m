From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] Turtle Beach Multisound Classic/Pinnacle
 driver (4th rev)
Date: Tue, 27 Jan 2009 21:44:10 +0100
Message-ID: <20090127214410.5974c8ca.krzysztof.h1@poczta.fm>
References: <20090124133528.05da0507.krzysztof.h1@poczta.fm>
	<s5hmyde5tul.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id EDB3A243BA
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 21:41:10 +0100 (CET)
In-Reply-To: <s5hmyde5tul.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Jan 2009 09:56:02 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> Thanks, this looks pretty good.
> But, one thing I forgot to ask...
> 
> 
> Could you use the new API snd_card_create() introduced recently?
> 
> 

The patch with conversion only is below.

---
From: Krzysztof Helt <krzysztof.h1@wp.pl>

Convert driver to use new snd_card_create()
function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index b0231cf..845470b 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -893,10 +893,10 @@ static int __devinit snd_msnd_isa_probe(struct device *pdev, unsigned int idx)
 		return -ENODEV;
 	}
 
-	card = snd_card_new(index[idx], id[idx], THIS_MODULE,
-			    sizeof(struct snd_msnd));
-	if (!card)
-		return -ENOMEM;
+	err = snd_card_create(index[idx], id[idx], THIS_MODULE,
+			      sizeof(struct snd_msnd), &card);
+	if (err < 0)
+		return err;
 
 	snd_card_set_dev(card, pdev);
 	chip = card->private_data;
@@ -1113,10 +1113,10 @@ static int __devinit snd_msnd_pnp_detect(struct pnp_card_link *pcard,
 	 * Create a new ALSA sound card entry, in anticipation
 	 * of detecting our hardware ...
 	 */
-	card = snd_card_new(index[idx], id[idx], THIS_MODULE,
-			    sizeof(struct snd_msnd));
-	if (!card)
-		return -ENOMEM;
+	ret = snd_card_create(index[idx], id[idx], THIS_MODULE,
+			      sizeof(struct snd_msnd), &card);
+	if (ret < 0)
+		return ret;
 
 	chip = card->private_data;
 	chip->card = card;

----------------------------------------------------------------------
Speak Up. Angielski szybko i skutecznie. 3 miesiace nauki gratis.
Sprawdz. >> http://link.interia.pl/f2019

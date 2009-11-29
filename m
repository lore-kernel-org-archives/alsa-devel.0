From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/2] opti-93x: fix irq freeing after
	request_irq error
Date: Sun, 29 Nov 2009 20:22:26 +0100
Message-ID: <20091129202226.cb5703ee.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id D46081037EA
	for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2009 20:20:27 +0100 (CET)
Received: from poczta.interia.pl (mi02.poczta.interia.pl [10.217.12.2])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id 6541327027E
	for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2009 20:20:15 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 87E182BC0E6
	for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2009 20:20:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Set snd_opti->irq value to -1 if the request_irq() fails to avoid
freeing the irq inside the snd_card_free().

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/opti9xx/opti92x-ad1848.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 5cd5553..438c1da 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -688,9 +688,9 @@ static void snd_card_opti9xx_free(struct snd_card *card)
 	if (chip) {
 #ifdef OPTi93X
 		struct snd_wss *codec = chip->codec;
-		if (codec && codec->irq > 0) {
-			disable_irq(codec->irq);
-			free_irq(codec->irq, codec);
+		if (codec && chip->irq > 0) {
+			disable_irq(chip->irq);
+			free_irq(chip->irq, codec);
 		}
 #endif
 		release_and_free_resource(chip->res_mc_base);
@@ -767,6 +767,7 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 			    IRQF_DISABLED, DEV_NAME" - WSS", codec);
 	if (error < 0) {
 		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", chip->irq);
+		chip->irq = -1;
 		return error;
 	}
 #endif
-- 
1.6.4


----------------------------------------------------------------------
Codziennie 11 tys. ofert pracy!
Sprawdz: http://link.interia.pl/f2447

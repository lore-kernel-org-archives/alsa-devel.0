From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cs4236: add missing pnp_request_card_device()
Date: Tue, 22 Jul 2008 23:51:00 +0200
Message-ID: <20080722235100.0ecfa7f8.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id EBC0B1038DC
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 23:46:08 +0200 (CEST)
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
Cc: Rene Herman <rene.herman@keyaccess.nl>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

There is a missing pnp_request_card_device() call
for cs4232 card. The acard->wss pointer is left
uninitialized which leads to crash during detection.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This bug was found in the 2.6.26-git9 kernel.

Please compare the snd_card_cs4232_pnp() and
the snd_card_cs423x_pnpc().

--- linux-2.6.26/sound/isa/cs423x/cs4236.c~	2008-07-13 23:51:29.000000000 +0200
+++ linux-2.6.26/sound/isa/cs423x/cs4236.c	2008-07-22 23:41:56.010942922 +0200
@@ -325,6 +325,9 @@ static int __devinit snd_cs423x_pnp_init
 static int __devinit snd_card_cs4232_pnp(int dev, struct snd_card_cs4236 *acard,
 					 struct pnp_dev *pdev)
 {
+	acard->wss = pnp_request_card_device(card, id->devs[0].id, NULL);
+	if (acard->wss == NULL)
+		return -EBUSY;
 	if (snd_cs423x_pnp_init_wss(dev, acard->wss) < 0)
 		return -EBUSY;
 	cport[dev] = -1;

----------------------------------------------------------------------
Czy Twoj mezczyzna gotuje dla Ciebie? 
Wygraj nagrody >>> http://link.interia.pl/f1e86 

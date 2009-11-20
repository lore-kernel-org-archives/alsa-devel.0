From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: opti-miro: fix missing semicolon
Date: Fri, 20 Nov 2009 21:04:03 +0100
Message-ID: <20091120210403.f7a6b3fc.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4543184155601369030=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240]) by alsa0.perex.cz (Postfix) with ESMTP id 5C7482434E
	for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2009 21:02:49 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--===============4543184155601369030==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Fix the mistake introduced by me earlier patch.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
I have borrowed the Miro PCM20 card. I can test the driver while making patches.

diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index b8170ad..1776103 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -1277,7 +1277,7 @@ static int __devinit snd_miro_probe(struct device *devptr, unsigned int n)
 		if (mpu_port < 0) {
 			snd_card_free(card);
 			snd_printk(KERN_ERR "unable to find a free MPU401 port\n");
-			return -EBUSY
+			return -EBUSY;
 		}
 	}
 	if (miro->irq == SNDRV_AUTO_IRQ) {

----------------------------------------------------------------------
KONKURS! Kliknij i wygraj luksusowe auto na weekend
lub jedn± z 650 innych nagród od L&#8217;Oreal Men Expert!! >> 
http://link.interia.pl/f2428


--===============4543184155601369030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4543184155601369030==--

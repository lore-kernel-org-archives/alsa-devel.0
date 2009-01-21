From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] do not create OPL3 timers if there is no OPL3
	irq wired
Date: Wed, 21 Jan 2009 15:08:03 +0100
Message-ID: <20090121150803.e5ca7aa8.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 38BD31037E3
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 15:05:01 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Most cards have OPL3 FM synthetiser but
they do not have OPL3 interrupt wired to
a sound chip or CPU.

Do not create OPL3 timers for such cards
as the timers are useless witthout interrupt.

This patch removes OPL3 timers for following
alsa drivers: snd-ad1816a, snd-opti93x,
snd-opti92x, snd-sc6000, snd-cmi8330.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/ad1816a/ad1816a.c        |    7 ++-----
 sound/isa/cmi8330.c                |    4 ----
 sound/isa/opti9xx/opti92x-ad1848.c |   10 ++--------
 sound/isa/sc6000.c                 |    4 ----
 4 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index 7752424..3810833 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -207,11 +207,8 @@ static int __devinit snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard
 				    OPL3_HW_AUTO, 0, &opl3) < 0) {
 			printk(KERN_ERR PFX "no OPL device at 0x%lx-0x%lx.\n", fm_port[dev], fm_port[dev] + 2);
 		} else {
-			if ((error = snd_opl3_timer_new(opl3, 1, 2)) < 0) {
-				snd_card_free(card);
-				return error;
-			}
-			if ((error = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
+			error = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+			if (error < 0) {
 				snd_card_free(card);
 				return error;
 			}
diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index dec6ea5..1154379 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -546,10 +546,6 @@ static int __devinit snd_cmi8330_probe(struct snd_card *card, int dev)
 				   "no OPL device at 0x%lx-0x%lx ?\n",
 				   fmport[dev], fmport[dev] + 2);
 		} else {
-			err = snd_opl3_timer_new(opl3, 0, 1);
-			if (err < 0)
-				return err;
-
 			err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
 			if (err < 0)
 				return err;
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 19706b0..5deb7e6 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -815,14 +815,8 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 				   chip->fm_port, chip->fm_port + 4 - 1);
 		}
 		if (opl3) {
-#ifdef CS4231
-			const int t1dev = 1;
-#else
-			const int t1dev = 0;
-#endif
-			if ((error = snd_opl3_timer_new(opl3, t1dev, t1dev+1)) < 0)
-				return error;
-			if ((error = snd_opl3_hwdep_new(opl3, 0, 1, &synth)) < 0)
+			error = snd_opl3_hwdep_new(opl3, 0, 1, &synth);
+			if (error < 0)
 				return error;
 		}
 	}
diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index ca35924..bbc5369 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -576,10 +576,6 @@ static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
 		snd_printk(KERN_ERR PFX "no OPL device at 0x%x-0x%x ?\n",
 			   0x388, 0x388 + 2);
 	} else {
-		err = snd_opl3_timer_new(opl3, 0, 1);
-		if (err < 0)
-			goto err_unmap2;
-
 		err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
 		if (err < 0)
 			goto err_unmap2;
-- 
1.5.2.2


-----------------------------------------------------------------------
Promocja w Speak Up. Kwartal angielskiego za darmo. 
3 miesiace nauki gratis. Sprawdz teraz! >> http://link.interia.pl/f2019

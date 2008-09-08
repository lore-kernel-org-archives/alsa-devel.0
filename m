From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<ukleinek@informatik.uni-freiburg.de>
Subject: [RESEND, PATCH] Fix section for sa11xx-uda1341 platform driver
Date: Mon, 8 Sep 2008 20:51:23 +0200
Message-ID: <20080908185123.GA22076@informatik.uni-freiburg.de>
References: <20080902210501.GA4306@informatik.uni-freiburg.de> <1220876004-5784-1-git-send-email-ukleinek@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755440AbYIHSvn@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1220876004-5784-1-git-send-email-ukleinek@informatik.uni-freiburg.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Jaroslav Kysela <perex@perex.cz>, Brian Avery <b.avery@hp.com>, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Don't use __init but __devinit to define probe function.  A pointer to
sa11xx_uda1341_probe is passed to the core via platform_driver_register=
 and
so the function must not disappear after the module is loaded.  Using _=
_init
and having HOTPLUG=3Dy and SND_SA11XX_UDA1341=3Dm the following probabl=
y oopses:

	echo -n sa11xx_uda1341.1 > /sys/bus/platform/driver/sa11xx_uda1341/unb=
ind
	echo -n sa11xx_uda1341.1 > /sys/bus/platform/driver/sa11xx_uda1341/bin=
d

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Brian Avery <b.avery@hp.com>
Cc: alsa-devel@alsa-project.org
Cc: Andrew Morton <akpm@linux-foundation.org>

---
Hello,

uups, I forgot to add the right cc:.  Sorry.

@Andrew,  I have a few more patches of this type pending.  Is it OK for
you if they go via you?  This would ease the process a bit for me.

Uwe

 sound/arm/sa11xx-uda1341.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/sa11xx-uda1341.c b/sound/arm/sa11xx-uda1341.c
index b9c51bf..da25b41 100644
--- a/sound/arm/sa11xx-uda1341.c
+++ b/sound/arm/sa11xx-uda1341.c
@@ -879,7 +879,7 @@ void snd_sa11xx_uda1341_free(struct snd_card *card)
 	audio_dma_free(&chip->s[SNDRV_PCM_STREAM_CAPTURE]);
 }
=20
-static int __init sa11xx_uda1341_probe(struct platform_device *devptr)
+static int __devinit sa11xx_uda1341_probe(struct platform_device *devp=
tr)
 {
 	int err;
 	struct snd_card *card;
--=20
tg: (7686ad5..) t/sectionfixes/sa11xx_uda1341 (depends on: t/sectionfix=
es/sa11xx_uda1341)

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+electron+mass%3D

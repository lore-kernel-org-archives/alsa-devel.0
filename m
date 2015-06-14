From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] mips/ad1843: convert time to jiffies HZ independent
Date: Sun, 14 Jun 2015 10:20:59 +0200
Message-ID: <1434270059-20472-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

PI compliance scanning with coccinelle flagged:
./sound/mips/ad1843.c:503:2-32: WARNING: 
	timeout (5) seems HZ dependent

This was introduced in 'commit 862c2c0a61c5 ("ALSA: ALSA driver for SGI O2
audio board")'. schedule_timeout_interruptible() expects a timeout in
jiffies so the numeric constant makes the effective timeout HZ dependent.
Simply put it through msecs_to_jiffies() to make it HZ independent.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

The loop here is bounded by 500 jiffies and it does not seem reasonable that
it would loop 10 times faster on HZ=1000 configs over HZ=100 configs. The
conversion via msecs_to_jiffies(5) ensures that it will loop at most 100
times for all configs of HZ which seems reasonable (to me) but needs to be
checked by someone that knows the details of this driver. 

Note that the CONFIG_SND_PCM_OSS dependency was not listed in the 
Depends on: in Kconfig (which it probably should)

Patch was compile tested with ip32_defconfig + CONFIG_SOUND=m,
CONFIG_SND=m, CONFIG_SND_PCM_OSS=y, CONFIG_SND_SGI_O2=m

Patch is against 4.1-rc7 (localversion-next is -next-20150612)

 sound/mips/ad1843.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/mips/ad1843.c b/sound/mips/ad1843.c
index 5869075..ec22b55 100644
--- a/sound/mips/ad1843.c
+++ b/sound/mips/ad1843.c
@@ -500,7 +500,7 @@ int ad1843_init(struct snd_ad1843 *ad1843)
 			       "ad1843: AD1843 won't power up\n");
 			return -EIO;
 		}
-		schedule_timeout_interruptible(5);
+		schedule_timeout_interruptible(msecs_to_jiffies(5));
 	}
 
 	/* 5. Power up the clock generators and enable clock output pins. */
-- 
1.7.10.4

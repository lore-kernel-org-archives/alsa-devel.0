From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: question on snd minors
Date: Tue, 15 Nov 2011 13:15:39 +0530
Message-ID: <1321343139.1516.60.camel@vkoul-udesk3>
References: <1321330163.1516.51.camel@vkoul-udesk3>
	<s5h62ildh3z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id B2696103862
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 08:50:25 +0100 (CET)
In-Reply-To: <s5h62ildh3z.wl%tiwai@suse.de>
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
Cc: alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-11-15 at 07:39 +0100, Takashi Iwai wrote:
> At Tue, 15 Nov 2011 09:39:23 +0530,
> Vinod Koul wrote:
> > 
> > Hi,
> > 
> > for the compressed path work I had a question regarding the minor
> > numbers.
> >  
> > Looks like we have 32 minors (5 bits) and going by current table there
> > is no space for new devices.
> > So should i increase the number to 64 (6bits), add compressed playback
> > and capture devices as 32-39, 40-48 respectively and keep rest as
> > reserved, or would you like it to be kept 32 and realign the table?
> 
> For the large number of concurrent accesses, we usually take an
> approach with sub-streams instead of scattering too many device
> files.
Perhaps I should have worded my question better :)

For compressed path (i had posted RFC roughly two months back [1]), we
are creating new devices /dev/snd/comprCxDxp which would be registered
as SNDRV_DEV_COMPRESS. For the registration part we need to assign the
minors, right? Hence the above question

Or did I miss something very obvious here...

This is how I wrote it now, I wanted to run this with you folks first

diff --git a/include/sound/core.h b/include/sound/core.h
index 1fa2407..9d1e54b 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -62,6 +62,7 @@ typedef int __bitwise snd_device_type_t;
 #define        SNDRV_DEV_BUS           ((__force snd_device_type_t) 0x1007)
 #define        SNDRV_DEV_CODEC         ((__force snd_device_type_t) 0x1008)
 #define        SNDRV_DEV_JACK          ((__force snd_device_type_t) 0x1009)
+#define        SNDRV_DEV_COMPRESS      ((__force snd_device_type_t) 0x100A)
 #define        SNDRV_DEV_LOWLEVEL      ((__force snd_device_type_t) 0x2000)
 
 typedef int __bitwise snd_device_state_t;
diff --git a/include/sound/minors.h b/include/sound/minors.h
index 8f76420..ffa6001 100644
--- a/include/sound/minors.h
+++ b/include/sound/minors.h
@@ -23,10 +23,10 @@
 
 #define SNDRV_OS_MINORS                        256
 
-#define SNDRV_MINOR_DEVICES            32
-#define SNDRV_MINOR_CARD(minor)                ((minor) >> 5)
-#define SNDRV_MINOR_DEVICE(minor)      ((minor) & 0x001f)
-#define SNDRV_MINOR(card, dev)         (((card) << 5) | (dev))
+#define SNDRV_MINOR_DEVICES            64
+#define SNDRV_MINOR_CARD(minor)                ((minor) >> 6)
+#define SNDRV_MINOR_DEVICE(minor)      ((minor) & 0x003f)
+#define SNDRV_MINOR(card, dev)         (((card) << 6) | (dev))
 
 /* these minors can still be used for autoloading devices (/dev/aload*) */
 #define SNDRV_MINOR_CONTROL            0       /* 0 */
@@ -40,6 +40,8 @@
 #define SNDRV_MINOR_RAWMIDI            8       /* 8 - 15 */
 #define SNDRV_MINOR_PCM_PLAYBACK       16      /* 16 - 23 */
 #define SNDRV_MINOR_PCM_CAPTURE                24      /* 24 - 31 */
+#define SNDRV_MINOR_COMPR_PLAYBACK     32      /* 32 - 35 */
+#define SNDRV_MINOR_COMPR_CAPTURE      36      /* 36 - 39 */



-- 
~Vinod

1:
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-September/043408.html

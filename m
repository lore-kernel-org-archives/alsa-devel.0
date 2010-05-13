From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 1/5] allow up to 32 PCM devices
Date: Thu, 13 May 2010 10:21:26 +0800
Message-ID: <20100513022126.GA13559@localhost>
References: <20100512013015.752623810@intel.com>
	<20100512015713.762299923@intel.com>
	<alpine.LNX.2.00.1005120925400.6856@eeebox2.perex-int.cz>
	<s5htyqdsg0w.wl%tiwai@suse.de> <20100512083950.GB11001@localhost>
	<s5hbpclsdbu.wl%tiwai@suse.de> <4BEA80F1.7040600@ladisch.de>
	<s5h7hn9s836.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E61232464F
	for <alsa-devel@alsa-project.org>;
	Thu, 13 May 2010 04:21:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7hn9s836.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wed, May 12, 2010 at 06:55:09PM +0800, Takashi Iwai wrote:
> At Wed, 12 May 2010 12:20:33 +0200,
> Clemens Ladisch wrote:
> > 
> > Takashi Iwai wrote:
> > > Wu Fengguang wrote:
> > > > > Jaroslav Kysela wrote:
> > > > > > I don't agree to have only 4 slots for soundcards in the static minor 
> > > > > > numbering. Maybe the driver should be converted to use subdevices or we 
> > > > > > might drop the static minor number allocation at all (it might have only 
> > > > > > impact for old distros).
> > > > 
> > > > Jaroslav, will there be so many sound cards in one system?
> > > 
> > > In the old time, yes.  Now we have less and less PCI slots.
> > > In theory, we may have lots of USB audio devices, though :)
> > 
> > I implemented CONFIG_SND_DYNAMIC_MINORS because people had been asking
> > for more than eight cards.  (And by now I have lots of cards too,
> > although my computer probably isn't very typical.)
> > 
> > Anyway, static numbering is needed only for systems without udev/devfs,
> > and there we shouldn't change it for backwards compatibility.  The HDA
> > driver already requires kernels >= 2.6, so I don't see a problem with
> > requiring CONFIG_SND_DYNAMIC_MINORS to get all HDMI outputs.
> 
> Right.  We can make it dependent.
> 

Like this?

 config SND_HDA_CODEC_INTELHDMI
 	bool "Build INTEL HDMI HD-audio codec support"
+	select SND_DYNAMIC_MINORS
 	default y

That will effectively turn on CONFIG_SND_DYNAMIC_MINORS by default
(distribution kernels will have to enable it).

Another backwards compatible solution is to fall back to the two
reserved values. This makes me a bit more comfortable :)

--- drm-intel.orig/include/sound/minors.h	2010-05-13 10:06:52.000000000 +0800
+++ drm-intel/include/sound/minors.h	2010-05-13 10:10:06.000000000 +0800
@@ -35,7 +35,9 @@
 #define SNDRV_MINOR_TIMER		(SNDRV_MINOR_GLOBAL + 1 * 32)
 
 #ifndef CONFIG_SND_DYNAMIC_MINORS
-						/* 2 - 3 (reserved) */
+
+#define SNDRV_MINOR_BACKUP1		2
+#define SNDRV_MINOR_BACKUP2		3
 #define SNDRV_MINOR_HWDEP		4	/* 4 - 7 */
 #define SNDRV_MINOR_RAWMIDI		8	/* 8 - 15 */
 #define SNDRV_MINOR_PCM_PLAYBACK	16	/* 16 - 23 */
--- drm-intel.orig/sound/core/sound.c	2010-05-13 10:06:04.000000000 +0800
+++ drm-intel/sound/core/sound.c	2010-05-13 10:11:19.000000000 +0800
@@ -269,8 +269,14 @@ int snd_register_device_for_dev(int type
 	minor = snd_find_free_minor();
 #else
 	minor = snd_kernel_minor(type, card, dev);
-	if (minor >= 0 && snd_minors[minor])
-		minor = -EBUSY;
+	if (minor >= 0) {
+		if (snd_minors[minor])
+			minor = SNDRV_MINOR_BACKUP1;
+		if (snd_minors[minor])
+			minor = SNDRV_MINOR_BACKUP2;
+		if (snd_minors[minor])
+			minor = -EBUSY;
+	}
 #endif
 	if (minor < 0) {
 		mutex_unlock(&sound_mutex);

Thanks,
Fengguang

From: Denis Vlasenko <vda.linux@googlemail.com>
Subject: Sound problems with snd_hda on x86_64
Date: Fri, 28 Jul 2006 12:16:25 +0200
Message-ID: <200607281216.25214.vda.linux__49650.396165862$1154081826$gmane$org@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 508CB177
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Jul 2006 12:16:32 +0200 (MEST)
Received: by ug-out-1314.google.com with SMTP id h2so635995ugf
	for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2006 03:16:31 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andi Kleen <ak@suse.de>, Takashi Iwai <tiwai@suse.de>, PeiSen Hou <pshou@realtek.com.tw>, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello,

I just built my very first 64-bit kernel for Athlon64
and it boots and works. Thank you Andi for all your work
on x86_64.

The only trouble so far that KDE's artsd and mplayer
have trouble playing sound.

Strace of artsd on 32 bits:

1762  open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = 9
1762  close(8)                          = 0
1762  ioctl(9, AGPIOC_ACQUIRE or APM_IOC_STANDBY <unfinished ...>
1762  <... ioctl resumed> , 0x77c58280) = 0
1762  fcntl64(9, F_GETFL)               = 0x802 (flags O_RDWR|O_NONBLOCK)
1762  ioctl(9, AGPIOC_INFO, 0x77c5827c) = 0
1762  ioctl(9, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0x77c58278) = 0
1762  mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 9, 0x80000) = 0x6f85c000
1762  mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 9, 0x81000) = 0x6f85b000

On 64 bits:

2203  open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = 9
2203  close(8)                          = 0
2203  ioctl(9, AGPIOC_ACQUIRE or APM_IOC_STANDBY <unfinished ...>
2203  <... ioctl resumed> , 0xffa9eda0) = 0
2203  fcntl64(9, F_GETFL)               = 0x802 (flags O_RDWR|O_NONBLOCK)
2203  ioctl(9, AGPIOC_INFO, 0xffa9ed9c) = 0
2203  ioctl(9, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xffa9ed98) = 0
2203  mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 9, 0x80000) = -1 ENXIO (No such device or address)
2203  write(2, "ALSA lib ../../../src/pcm/pcm_hw"..., 64) = 64
2203  write(2, "status mmap failed", 18) = 18
2203  write(2, ": No such device or address", 27) = 27
2203  write(2, "\n", 1)                 = 1

-ENXIO seems to be the thing which gives trouble.
I think it comes from here:

--- linux-2.6.17.6.org/sound/core/pcm_native.c	2006-07-15 21:00:43.000000000 +0200
+++ linux-2.6.17.6.src/sound/core/pcm_native.c	2006-07-27 22:27:24.000000000 +0200
@@ -34,7 +34,7 @@
 #include <sound/timer.h>
 #include <sound/minors.h>
 #include <asm/io.h>
-
+#define ret_ENXIO printk("return -ENXIO in %s:%s line %d\n", __FILE__, __FUNCTION__, __LINE__)
 /*
  *  Compatibility
  */
@@ -3220,17 +3220,17 @@ static int snd_pcm_mmap(struct file *fil
 	
 	pcm_file = file->private_data;
 	substream = pcm_file->substream;
-	snd_assert(substream != NULL, return -ENXIO);
+	snd_assert(substream != NULL, ret_ENXIO; return -ENXIO);
 
 	offset = area->vm_pgoff << PAGE_SHIFT;
 	switch (offset) {
 	case SNDRV_PCM_MMAP_OFFSET_STATUS:
 		if (substream->no_mmap_ctrl)
-			return -ENXIO;
+			{ret_ENXIO; return -ENXIO;} // vda: returns here
 		return snd_pcm_mmap_status(substream, file, area);
 	case SNDRV_PCM_MMAP_OFFSET_CONTROL:
 		if (substream->no_mmap_ctrl)
-			return -ENXIO;
+			{ret_ENXIO; return -ENXIO;}
 		return snd_pcm_mmap_control(substream, file, area);
 	default:
 		return snd_pcm_mmap_data(substream, file, area);

Which is, in turn, is caused by this code:

--- linux-2.6.17.6.org/sound/core/pcm_compat.c	2006-07-15 21:00:43.000000000 +0200
+++ linux-2.6.17.6.src/sound/core/pcm_compat.c	2006-07-28 00:35:10.000000000 +0200
@@ -478,6 +478,8 @@ static long snd_pcm_ioctl_compat(struct 
 	 * mmap of PCM status/control records because of the size
 	 * incompatibility.
 	 */
+printk("substream->no_mmap_ctrl = 1 in %s:%s line %d\n", __FILE__, __FUNCTION__, __LINE__);
+dump_stack();
 	substream->no_mmap_ctrl = 1;
 
 	switch (cmd) {

It's puzzling. Even a 486 processor, can do 64-bit operations (using cmpxchg8)
on memory-mapped areas, why does code disallows mmap for 64-bit CPUs but allows
for 32-bit ones?

I suspect that not all sound devices are mmap-able, and I think artsd
is not THAT buggy to try mmap on those and die, so why does it not detect
that snd_hda is not mmap-able on x86_64 kernel?
Is it artsd problem or snd_hda problem?

I did not investigate mplayer problem this deep. Visually, mplayer
plays movies faster than real time, unless given an option "-ao null".

The chip is integrated Realtek ALC883 on MSI K9N Neo mobo
(http://www.pixmania.co.uk/uk/uk/270290/art/msi/k9n-neo-f-socket-am2-amd.html).

# lsmod
Module                  Size  Used by
snd_pcm_oss            25824  0
snd_mixer_oss          18368  1 snd_pcm_oss
snd_hda_intel          19484  0
snd_hda_codec         164608  1 snd_hda_intel
snd_pcm                88588  3 snd_pcm_oss,snd_hda_intel,snd_hda_codec
snd_timer              26184  1 snd_pcm
snd                    63336  6 snd_pcm_oss,snd_mixer_oss,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
soundcore              11616  1 snd
snd_page_alloc         10640  2 snd_hda_intel,snd_pcm
...

printks from instrumentation shown above:

22:37:45.8 hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
22:44:35.0 substream->no_mmap_ctrl = 1 in sound/core/pcm_compat.c:snd_pcm_ioctl_compat line 481
22:44:35.0
22:44:35.0 Call Trace: <ffffffff880ba51b>{:snd_pcm:snd_pcm_ioctl_compat+91}
22:44:35.0        <ffffffff8809bc84>{:snd:snd_card_file_remove+199} <ffffffff8026391c>{kobject_put+25}
22:44:35.0        <ffffffff801884da>{mntput_no_expire+27} <ffffffff8016d750>{__fput+447}
22:44:35.0        <ffffffff801986ca>{compat_sys_ioctl+176} <ffffffff8011b12e>{ia32_sysret+0}
22:44:35.0 substream->no_mmap_ctrl = 1 in sound/core/pcm_compat.c:snd_pcm_ioctl_compat line 481
22:44:35.0
22:44:35.0 Call Trace: <ffffffff880ba51b>{:snd_pcm:snd_pcm_ioctl_compat+91}
22:44:35.0        <ffffffff8809bc84>{:snd:snd_card_file_remove+199} <ffffffff8017ed34>{sys_fcntl+759}
22:44:35.0        <ffffffff801986ca>{compat_sys_ioctl+176} <ffffffff8011b12e>{ia32_sysret+0}
22:44:35.0 substream->no_mmap_ctrl = 1 in sound/core/pcm_compat.c:snd_pcm_ioctl_compat line 481
22:44:35.0
22:44:35.0 Call Trace: <ffffffff880ba51b>{:snd_pcm:snd_pcm_ioctl_compat+91}
22:44:35.0        <ffffffff8809bc84>{:snd:snd_card_file_remove+199} <ffffffff8017ed34>{sys_fcntl+759}
22:44:35.0        <ffffffff801986ca>{compat_sys_ioctl+176} <ffffffff8011b12e>{ia32_sysret+0}
22:44:35.0 return -ENXIO in sound/core/pcm_native.c:snd_pcm_mmap line 3229

Takashi, do you want more info and/or digging into mplayer
problem?
--
vda

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

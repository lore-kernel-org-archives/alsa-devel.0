From: "John H." <mrmailer@myway.com>
Subject: Re: cannot submit datapipe for urb 0 on /dev/dsp access -extigy
Date: Fri,  2 Apr 2004 16:45:41 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040402214541.1DCA73993@mprdmxin.myway.com>
Reply-To: mrmailer@myway.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mprdmxin.myway.com (nn1.excitenetwork.com [207.159.120.55])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA28018
	for <alsa-devel@alsa-project.org>; Fri, 2 Apr 2004 23:46:21 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


and dmesg says



ALSA /tmp/alsa-driver-1.0.4rc2/usb/usbaudio.c:811: cannot submit datapipe for urb 0, err = -38

ALSA /tmp/alsa-driver-1.0.4rc2/usb/usbaudio.c:811: cannot submit datapipe for urb 0, err = -38

Debug: sleeping function called from invalid context at include/asm/semaphore.h:119

in_atomic():1, irqs_disabled():0

Call Trace:

 [<c011ce0b>] __might_sleep+0xab/0xd0

 [<d19c908a>] __ke_down_struct_sem+0x2a/0x50 [fglrx]

 [<d19d9054>] drm_getmagic+0x124/0x1c0 [fglrx]

 [<c0155922>] dentry_open+0x142/0x210

 [<d19d8f30>] drm_getmagic+0x0/0x1c0 [fglrx]

 [<d19cbd8d>] firegl_ioctl+0x15d/0x1e0 [fglrx]

 [<c0169313>] sys_ioctl+0xf3/0x2a0

 [<c010941b>] syscall_call+0x7/0xb

 

ALSA /tmp/alsa-driver-1.0.4rc2/usb/usbaudio.c:811: cannot submit datapipe for urb 0, err = -38

ALSA /tmp/alsa-driver-1.0.4rc2/usb/usbaudio.c:811: cannot submit datapipe for urb 0, err = -38

ALSA /tmp/alsa-driver-1.0.4rc2/usb/usbaudio.c:811: cannot submit datapipe for urb 0, err = -38









 --- On Fri 04/02, John H. < mrmailer@myway.com > wrote:

From: John H. [mailto: mrmailer@myway.com]

To: mrmailer@myway.com, clemens@ladisch.de, mrmailer@myway.com

     Cc: alsa-devel@alsa-project.org

Date: Fri,  2 Apr 2004 16:28:53 -0500

Subject: Re: [Alsa-devel] cannot submit datapipe for urb 0 on /dev/dsp access -extigy



oh, play had gotten stuck on playing a gaim sound.  it sticks until you kill it.<br><br>once killed, xmms says this<br><br><br>** WARNING **: alsa_free(): snd_pcm_start() failed: Broken pipe<br>ALSA lib pcm_hw.c:494:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed: Broken pipe<br><br><br><br> --- On Fri 04/02, John H. < mrmailer@myway.com > wrote:<br>From: John H. [mailto: mrmailer@myway.com]<br>To: clemens@ladisch.de, mrmailer@myway.com<br>     Cc: alsa-devel@alsa-project.org<br>Date: Fri,  2 Apr 2004 16:26:57 -0500 (EST)<br>Subject: Re: [Alsa-devel] cannot submit datapipe for urb 0 on /dev/dsp access -extigy<br><br><br>see, this is what is weird, it worked last week, now it doesn't work with exaudio or alsa! same errors!<br><br>line in works, but not pcm/oss.\<br><br>aplay file.wav does not work<br><br>after i ran aplay foo.wav i tried xmms, and it said<br>ALSA lib pcm_hw.c:1057:(snd_pc
 m_hw_open) open /dev/snd/pcmC0D0p failed: Device or resource busy<br> <br>** WARNING **: !
 alsa_setup(): Failed to open pcm device (default): Device or resource busy<br><br><br> ls -la /proc/asound/<br>total 1.0K<br>dr-xr-xr-x    5 root root 0 Apr  2 15:25 .<br>dr-xr-xr-x  118 root root 0 Apr  2 09:09 ..<br>dr-xr-xr-x    6 root root 0 Apr  2 15:25 card0<br>-r--r--r--    1 root root 0 Apr  2 15:25 cards<br>-r--r--r--    1 root root 0 Apr  2 15:25 devices<br>lrwxrwxrwx    1 root root 5 Apr  2 15:25 Extigy -> card0<br>-r--r--r--    1 root root 0 Apr  2 15:25 modules<br>dr-xr-xr-x    2 root root 0 Apr  2 15:25 oss<br>-r--r--r--    1 root root 0 Apr  2 15:25 pcm<br>dr-xr-xr-x    2 root root 0 Apr  2 15:25 seq<br>-r--r--r--    1 root root 0 Apr  2 15:25 timers<br>-r--r--r--    1 root root 0 Apr  2 15:25 version<br><br><br><br><br> --- On Thu 04/01, Clemens Ladisch < clemens@ladisch.de > wrote:<br>From: Clemens Ladisch [mailto: clemens@ladisch.de]<br>To: mrmailer@myway.com<br>     C
 c: alsa-devel@alsa-project.org<br>Date: Thu, 01 Apr 2004 15:38:40 +0200 (METDST)<br>Subje!
 ct: Re: [Alsa-devel] cannot submit datapipe for urb 0 on /dev/dsp acce
ss -extigy<br><br>John H. wrote:<br>> I get this error repeatedly<br>><br>> ALSA /tmp/alsa-driver-1.0.4rc2/usb/usbaudio.c:811:<br>> cannot submit datapipe for urb 0, err = -38<br>><br>> whenever i try to use /dev/dsp now, and i can only get sound from line in.<br>><br>> i have kernel 2.6.4 and drivers 1.0.4rc2<br><br>What is in /proc/asound/cards?<br><br>Is your host controller UHCI or OHCI?<br><br>Does it work with "aplay something.wav"?<br><br>Does it work with a 2.4.x kernel?<br><br><br>Regards,<br>Clemens<br><br><br><br><br>-------------------------------------------------------<br>This SF.Net email is sponsored by: IBM Linux Tutorials<br>Free Linux tutorial presented by Daniel Robbins, President and CEO of<br>GenToo technologies. Learn everything from fundamentals to system<br>administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click<br>__________________________________
 _____________<br>Alsa-devel mailing list<br>Alsa-devel@lists.sourceforge.net<br>https://l!
 ists.sourceforge.ne<br> t/lists/listinfo/alsa-devel<br><br><br>_______________________________________________<br>No banners. No pop-ups. No kidding.<br>Introducing My Way - http://www.myway.com<br><br><br>_______________________________________________<br>No banners. No pop-ups. No kidding.<br>Introducing My Way - http://www.myway.com<br>

_______________________________________________
No banners. No pop-ups. No kidding.
Introducing My Way - http://www.myway.com


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

From: "John H." <mrmailer@myway.com>
Subject: Re: cannot submit datapipe for urb 0 on /dev/dsp access -extigy
Date: Fri,  2 Apr 2004 16:26:57 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040402212657.75BE312D00@mprdmxin.myway.com>
Reply-To: mrmailer@myway.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mprdmxin.myway.com (nn2.excitenetwork.com [207.159.120.56])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA27650
	for <alsa-devel@alsa-project.org>; Fri, 2 Apr 2004 23:27:40 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: clemens@ladisch.de, mrmailer@myway.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


see, this is what is weird, it worked last week, now it doesn't work with exaudio or alsa! same errors!



line in works, but not pcm/oss.\



aplay file.wav does not work



after i ran aplay foo.wav i tried xmms, and it said

ALSA lib pcm_hw.c:1057:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed: Device or resource busy

 

** WARNING **: alsa_setup(): Failed to open pcm device (default): Device or resource busy





 ls -la /proc/asound/

total 1.0K

dr-xr-xr-x    5 root root 0 Apr  2 15:25 .

dr-xr-xr-x  118 root root 0 Apr  2 09:09 ..

dr-xr-xr-x    6 root root 0 Apr  2 15:25 card0

-r--r--r--    1 root root 0 Apr  2 15:25 cards

-r--r--r--    1 root root 0 Apr  2 15:25 devices

lrwxrwxrwx    1 root root 5 Apr  2 15:25 Extigy -> card0

-r--r--r--    1 root root 0 Apr  2 15:25 modules

dr-xr-xr-x    2 root root 0 Apr  2 15:25 oss

-r--r--r--    1 root root 0 Apr  2 15:25 pcm

dr-xr-xr-x    2 root root 0 Apr  2 15:25 seq

-r--r--r--    1 root root 0 Apr  2 15:25 timers

-r--r--r--    1 root root 0 Apr  2 15:25 version









 --- On Thu 04/01, Clemens Ladisch < clemens@ladisch.de > wrote:

From: Clemens Ladisch [mailto: clemens@ladisch.de]

To: mrmailer@myway.com

     Cc: alsa-devel@alsa-project.org

Date: Thu, 01 Apr 2004 15:38:40 +0200 (METDST)

Subject: Re: [Alsa-devel] cannot submit datapipe for urb 0 on /dev/dsp access -extigy



John H. wrote:<br>> I get this error repeatedly<br>><br>> ALSA /tmp/alsa-driver-1.0.4rc2/usb/usbaudio.c:811:<br>> cannot submit datapipe for urb 0, err = -38<br>><br>> whenever i try to use /dev/dsp now, and i can only get sound from line in.<br>><br>> i have kernel 2.6.4 and drivers 1.0.4rc2<br><br>What is in /proc/asound/cards?<br><br>Is your host controller UHCI or OHCI?<br><br>Does it work with "aplay something.wav"?<br><br>Does it work with a 2.4.x kernel?<br><br><br>Regards,<br>Clemens<br><br><br><br><br>-------------------------------------------------------<br>This SF.Net email is sponsored by: IBM Linux Tutorials<br>Free Linux tutorial presented by Daniel Robbins, President and CEO of<br>GenToo technologies. Learn everything from fundamentals to system<br>administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click<br>_______________________________________________<br>A
 lsa-devel mailing list<br>Alsa-devel@lists.sourceforge.net<br>https://lists.sourceforge.n!
 et/lists/listinfo/alsa-devel<br>

_______________________________________________
No banners. No pop-ups. No kidding.
Introducing My Way - http://www.myway.com


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

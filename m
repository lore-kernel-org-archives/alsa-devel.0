From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: usb quattro not recording
Date: Tue, 03 Dec 2002 02:24:42 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DEB975A.9060902@boosthardware.com>
References: <20021201105428.2afa833d.jean-marc.harang@laposte.net>	<Pine.HPX.4.33n.0212020920100.7780-100000@studcom.urz.uni-halle.de>	<s5hbs44bxyp.wl@alsa2.suse.de>	<3DEB23B8.6070507@mail.alamy.idv.tw> <s5h4r9wbsoy.wl@alsa2.suse.de> <3DEB879C.4070501@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Much to my surprise the quattro has stopped being able to record with 
cvs from Nov 27 2002 and also a fresh checkout today.

Neither pcm devices are able to capture.

Playback is fine however.

It might be telling that jack hangs here in capture only mode:

----
jackd -d alsa -d quattro1 -C
jackd 0.40.0
Copyright 2001-2002 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

loading driver ..
creating alsa driver ... quattro1|1024|2|48000|swmon
starting engine

----

$ cat /proc/asound/card2/pcm0c/
info  oss   sub0
$ cat /proc/asound/card2/pcm0c/info
card: 2
device: 0
subdevice: 0
stream: CAPTURE
id: USB Audio
name: USB Audio
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
$ cat /proc/asound/card2/pcm0c/oss
$ cat /proc/asound/card2/pcm0c/sub0/
cat: /proc/asound/card2/pcm0c/sub0/: Is a directory
$ cat /proc/asound/card2/pcm0c/sub0/
hw_params  info       prealloc   status     sw_params
$ cat /proc/asound/card2/pcm0c/sub0/hw_params
closed
$ cat /proc/asound/card2/pcm0c/sub0/info
card: 2
device: 0
subdevice: 0
stream: CAPTURE
id: USB Audio
name: USB Audio
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1
$ cat /proc/asound/card2/pcm0c/sub0/prealloc
64
$ cat /proc/asound/card2/pcm0c/sub0/status
closed
$ cat /proc/asound/card2/pcm0c/sub0/sw_params
closed

----

How embarrasing. I thought I was recording on Friday night and told my 
friend we wouldn't need his MD. Now I have 4 hours of pure silence :(

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en

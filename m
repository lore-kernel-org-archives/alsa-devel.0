From: David Hilvert <dhilvert@gmail.com>
Subject: Output levels issue on Plantronics .Audio 510 USB
	Headset
Date: Thu, 1 Nov 2007 16:36:04 -0500
Message-ID: <20071101163604.8cedd87c.dhilvert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E12C243F0
	for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2007 22:36:12 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id h2so575184ugf
	for <alsa-devel@alsa-project.org>; Thu, 01 Nov 2007 14:36:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

The Plantronics .Audio 510 USB headset (Vendor=047f ProdID=c001) seems to have
certain output levels issues with drivers in 2.6.23-rc2-mm2 (at least).  In
particular, setting 

amixer -c 1 sset PCM 3

results in no output, while

amixer -c 1 sset PCM 4

results in levels that are somewhat loud for applications tested.  Volume
appears to be roughly linear in the range above PCM=4, if loud for applications
tested.

The USB ID information (Vendor=047f ProdID=c001) doesn't seem to be noted as
exceptional by any driver code in the 2.6.23-rc2-mm2 kernel, and web searches
for 'plantronics' or 'audio 510' and linux or alsa seem to return little
pertinent information.  What would be most useful to try next?

Various outputs follow:

$ amixer -c 1
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 151
  Mono:
  Front Left: Playback 6 [4%] [-27.29dB] [on]
  Front Right: Playback 6 [4%] [-27.29dB] [on]
Simple mixer control 'Mic',0
  Capabilities: cvolume cswitch cswitch-joined
  Capture channels: Mono
  Limits: Capture 0 - 16
  Mono: Capture 14 [88%] [21.00dB] [on]
Simple mixer control 'Auto Gain Control',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

$ cat /proc/bus/usb/devices 

T:  Bus=05 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  6 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=047f ProdID=c001 Rev= 1.00
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=00 Driver=snd-usb-audio
I:* If#= 1 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
I:  If#= 1 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=01(O) Atr=09(Isoc) MxPS= 200 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 0 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
I:  If#= 2 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=00 Driver=snd-usb-audio
E:  Ad=82(I) Atr=05(Isoc) MxPS= 100 Ivl=1ms
I:* If#= 3 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=83(I) Atr=03(Int.) MxPS=   4 Ivl=32ms

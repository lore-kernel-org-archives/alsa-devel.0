From: John Frankish <j-frankish@slb.com>
Subject: No line out on latest Mac Mini
Date: Sat, 22 Oct 2011 12:14:02 +0000
Message-ID: <654DF80AD31A344E93DBCC6280BD6DEF2226DCB3@NL0230MBX08N1.DIR.slb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nl0105mta01.mail.slb.com (sx003.ddc-nl0105.slb.com
	[199.6.154.22]) by alsa0.perex.cz (Postfix) with ESMTP id D13BC10381A
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Oct 2011 14:14:08 +0200 (CEST)
Received: from nl0105mta01.mail.slb.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 9ACA95911EF
	for <alsa-devel@alsa-project.org>; Sat, 22 Oct 2011 12:14:05 +0000 (GMT)
Received: from NL0230MBX01N2.DIR.slb.com (nl0230mbx01n2.dir.slb.com
	[199.6.133.5]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by nl0105mta01.mail.slb.com (Postfix) with ESMTPS id 87C065905EA
	for <alsa-devel@alsa-project.org>; Sat, 22 Oct 2011 12:14:05 +0000 (GMT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I posted this to the alsa-user list a couple of weeks ago but did not get an answer

I've been trying to get analog line out to work to headphones or 
powered speakers with the latest Mac Mini, but so far the best I've 
managed to achieve is to get the internal speaker to work. Line out
works with the Mac OS.

I've also tried the HDA analyser mentioned here:

http://www.alsa-project.org/main/index.php/HDA_Analyzer

but no matter what I do, there is no way to get sound from the line out
jack to headphones or powered speakers.

I'm guessing I need one or more obscure options to load the module snd-hda-intel,
but nothing I've tried so far has worked. The kernel documentation does not
mention the mac mini 5,3 the Intel Corporation 6 Series/C200 Series Chipset nor the
combination of Cirrus Logic CS4206 and Intel CougarPoint HDMI - does anybody know
where I might find more details?

Details below:
----------
DMI: Apple Inc. Macmini5,3/Mac-7BA5B2794B2CDB12, BIOS
MM51.88Z.0075.B00.1106271442 06/27/2011
Alsa modules from linux-3.0.3
Alsa-1.0.23

$ lspci -knn
00:1b.0 Audio device [0403]: Intel Corporation 6 Series/C200 Series 
Chipset Family High Definition Audio Controller [8086:1c20] (rev 05)
        Subsystem: Intel Corporation Device [8086:7270]
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel

$ aplay -l
**** List of PLAYBACK Hardware Devices **** card 0: PCH [HDA Intel 
PCH], device 0: Cirrus Analog [Cirrus Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 1: Cirrus Digital [Cirrus Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$ head -n 1 /proc/asound/card0/codec*
==> /proc/asound/card0/codec#0 <==
Codec: Cirrus Logic CS4206
==> /proc/asound/card0/codec#3 <==
Codec: Intel CougarPoint HDMI

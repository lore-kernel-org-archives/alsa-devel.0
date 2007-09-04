From: "Pablo N. Hess" <phess@linuxnewmedia.com.br>
Subject: HDA Conexant: is mic boost possible?
Date: Tue, 04 Sep 2007 11:14:58 -0300
Message-ID: <46DD6862.6070400@linuxnewmedia.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxnewmedia.com.br (mail.linuxnewmedia.com.br
	[189.14.98.138])
	by alsa0.perex.cz (Postfix) with ESMTP id 142F9103954
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Sep 2007 16:19:12 +0200 (CEST)
Received: from endeavour.linuxnewmedia.com.br (c9534038.virtua.com.br
	[201.83.64.56])
	by mail.linuxnewmedia.com.br (Postfix) with ESMTP id E0FB23800C54
	for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2007 11:22:44 -0300 (BRT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by endeavour.linuxnewmedia.com.br (Postfix) with ESMTP id DA33EFF2E
	for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2007 11:18:53 -0300 (BRT)
Received: from endeavour.linuxnewmedia.com.br ([127.0.0.1])
	by localhost (endeavour [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 20785-01-2 for <alsa-devel@alsa-project.org>;
	Tue, 4 Sep 2007 11:18:50 -0300 (BRT)
Received: from [192.168.1.176] (unknown [192.168.1.176])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by endeavour.linuxnewmedia.com.br (Postfix) with ESMTP id 21FA5FF22
	for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2007 11:18:39 -0300 (BRT)
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
List-Id: alsa-devel@alsa-project.org

I have to make the sound chip of a Itautec W7635 (= FIC VA250D) work on 
a Gentoo(-based) distro (I'm now trying Sabayon).
It is a HDA-intel (Conexant codec).

Using my earphones as a stereo mic, recording with 'arecord -f cd' has 
always worked perfectly fine, from alsa-driver-1.0.14 on.

However, when using a regular mono mic (like the ones that come in 
common headsets), recording simply does *not* work.

Here's the quick info:

alsa-driver-1.0.14:
   playback: ok
   recording:
     stereo mic: ok
     mono mic: no input at all (very high volume already tried)

alsa-driver-1.0.15rc1:
   playback: ok (even better than with alsa-driver-1.0.14)
   recording:
     stereo mic: ok (seems better thatn with alsa-driver-1.0.14)
     mono mic: *very* very low volume, bad quality, lots of low-volume 
noise, too.


Now the paragraphed info:

Playback is perfectly ok since alsa-driver-1.0.14, just like recording 
with an earphone as a stereo mic.

With alsa-driver-1.0.14, definitely no mono-mic input works, no matter 
the settings at alsamixer.
With alsa-driver-1.0.15rc1, mono-mic input works very very bad 
(extremely low volume, terrible quality, lots of clicks and noise).

I guess that the mono mic needs a mic boost in alsa-driver-1.0.15rc1. 
However, with a 'grep -i "mic boost" .../pci/hda/*.c' 
(alsa-driver-1.0.15rc1 source code), it seems that only patch-realtek.c 
and patch-analog.c support this feature.

Is it even possible to add a mic boost feature to this codec?

The output of alsa-info.sh with alsa-driver-1.0.15rc1 is at:
http://pastebin.ca/681023

Thanks a lot for any info, and congratulations to all of you for your 
terrific work with ALSA.

Pablo Hess

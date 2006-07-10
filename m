From: Luca Abeni <lucabe72@email.it>
Subject: Problems with osprey 230 and snd-bt87x
Date: Mon, 10 Jul 2006 11:17:06 +0200
Message-ID: <1152523026.1005.28.camel@labeni.mm.mbigroup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ACA53242
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 11:47:01 +0200 (MEST)
Received: from smtp-out1.email.it (smtp-out1.email.it [80.247.70.36])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	A943F99E51 for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 11:14:19 +0200 (MEST)
Received: from labeni.mm.mbigroup.it (unknown [84.233.239.122])by
	smtp-out1.email.it (Email.it) with ESMTP id 3A13D1C80EDfor
	<alsa-devel@alsa-project.org>; Mon, 10 Jul 2006 11:14:08 +0200 (CEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I am trying to capture some audio from an osprey 230 card (using the
snd-bt87x module), but it does not seem to work well.
I tried a lot of linux kernel versions, and I am currently using
2.6.18-pre1 hoping that it includes the latest alsa drivers.

Anyway, after
modprobe snd-bt87x
a card is detected (as card 1), but there are problems:
1) alsamixer -c 1 shows 3 inputs: "TV Tuner", "Mic/Line", and "FM", but
the card does not have any tuner or radio device...

2) arecord -l says
 **** List of CAPTURE Hardware Devices ****
card 1: Bt878 [Brooktree Bt878], device 0: Bt87x Digital [Bt87x Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Bt878 [Brooktree Bt878], device 1: Bt87x Analog [Bt87x Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
but it seems that the audio device is hw:1,0 (the output of arecord -l
seems to indicate that it should be hw:1,1) - I have an audio source
connected to the analog input of the card, and capturing from hw:1,1
only gives silence. Capturing from hw:1,0 gives some _very distorted_
audio. Changing the mixer setting with alsamixer does not change
anything.

3) It seems that there is some problem with the captured audio rate: I
capture about 122 seconds of audio with
time arecord -v -Dhw:1,0 -c 2 -t wav -f S16_LE -r44100 test.wav
(I used the "time" command to measure how long arecord ran befoure I
stopped it), but the resulting test.wav is only 88 seconds long.
Changing the audio rate with "-r" does not seem to fix the problem.

I am pretty sure that the card is not broken, because the driver
distributed by the manufacturer (a patched version of some old
"btaudio") is able to correctly capture analog audio.

So, my question is: is the problem with osprey230 known? Or did I do
something wrong? If this is a problem in the alsa drivers, is someone
already working on it? I have the card, and I can provide more info or
do more tests


			Thanks,
				Luca
P.S.: I tried to submit a bug using
https://bugtrack.alsa-project.org/alsa-bug/login_page.php
but when I try to register I get
PROBLEMS SENDING MAIL TO: 
Mailer Error: SMTP Error: Could not connect to SMTP host.
-- 
_____________________________________________________________________________
Copy this in your signature, if you think it is important:
                               N O    W A R ! ! !



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

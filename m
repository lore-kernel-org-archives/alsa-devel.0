From: Simon Tremblay <bidou@videotron.qc.ca>
Subject: Configure and use dmix with a new ASoC driver
Date: Sat, 16 Aug 2008 06:27:02 +0000 (UTC)
Message-ID: <loom.20080816T061550-625@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 5CA7D2482C
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Aug 2008 08:27:13 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KUFFn-0002ne-8p
	for alsa-devel@alsa-project.org; Sat, 16 Aug 2008 06:27:11 +0000
Received: from modemcable024.51-130-66.mc.videotron.ca ([66.130.51.24])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 16 Aug 2008 06:27:11 +0000
Received: from bidou by modemcable024.51-130-66.mc.videotron.ca with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 16 Aug 2008 06:27:11 +0000
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

Hi, 

I don't know if there is something special I should do to be able to use dmix
with my new ASoC driver I made (TLV320AIC23b codec running on a AT91RM9200
 board).

The problem is when I try to use dmix with aplay, it doesn't work and I got
 this error message:

# aplay -v -D plug:dmix /media/usb0/tada.wav
aplay: main:545: audio open error: Operation not permitted
#

Listing of my /dev/snd:

# ls -al /dev/snd
drwxr-xr-x    2 root     root            0 Jan  1 00:01 .
drwxr-xr-x    7 root     root            0 Jan  1 00:01 ..
crw-rw----    1 root     audio    116,   0 Jan  1 00:01 controlC0
crw-rw----    1 root     audio    116,  16 Jan  1 00:01 pcmC0D0p


Notice I have a default /usr/share/alsa/alsa.conf file too. I'm running ALSA
1.0.15. Of course, it works well when I play a sound without the -D plug:dmix
parameter...

# aplay /media/usb0/tada.wav
at91-ssc:ssc_startup: SSC_SR=0x000004c3
armus_tlv320aic23b: pck1 started
asoc: aic23b <-> at91-ssc1 info:
asoc: rate mask 0x6fe
asoc: min ch 1 max ch 2
asoc: min rate 8000 max rate 96000
Playing WAVE '/media/usb0/tada.wav' : Signed 16 bit Little Endian, Rate 48000
Hz, Stereo
#

I tried to find some useful documentation about dmix but mainly it says that
when we have a recent version of ALSA, we don't need to configure it because
it's already done? 

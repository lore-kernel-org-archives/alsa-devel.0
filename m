From: Ctirad Fertr <c.fertr@gmail.com>
Subject: E-mu 1212M/1820M/1616M development
Date: Sun, 11 Nov 2007 22:02:33 +0100
Message-ID: <47376DE9.5000904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.vol.cz (smtp1.vol.cz [195.250.128.78])
	by alsa0.perex.cz (Postfix) with ESMTP id ED853246ED
	for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2007 22:02:39 +0100 (CET)
Received: from [10.16.3.3] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp1.vol.cz (Postfix) with ESMTP id 866B4860C3
	for <alsa-devel@alsa-project.org>; Sun, 11 Nov 2007 22:02:39 +0100 (CET)
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

Hello,

I just bought an 1616M PCMCIA in addition to my old 1212m v1 and want to 
help improve the current driver. I wrote one little patch for those 
cards in the past (and some bigger patches for my experiments which were 
never released) and now I have some time to continue.

I'm going to add missing switches into mixer, make some changes in mixer 
to match the real I/O setup of each particular card model and perhaps 
also write some graphics patchmix like app.

Unfortunatelly, I'm unable to fix the most important bugs (at least from 
my point of view) dua to lack of documentation and knowlenge of DSP 
programming. These are:

1. non working 24bit playback. It should be on device 0,2 This device 
exists, but cannot be openned for playback.It is the last thing needed 
for serious DAW.

2. Non working S/PDIF (and probably ADAT, too) on 1616(M) microdock 
ports. I think tese ports uses different set of registers than PCI 1010 
host card. Am I right?

3. Midi I/O works well on 1212m v1, but only when 48kHz is set. At 
44.1kHz signalling is corrupted (different UART timing? How to fix it?). 
On 1616m microdock MIDI I/O does not work at all.

I welcome any comments, advices and patches ;)

----
Ctirad

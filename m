From: mike start <mike.start@ntlworld.com>
Subject: ice1712 and jack
Date: Mon, 29 Dec 2008 23:22:54 +0000
Message-ID: <49595BCE.9050603@ntlworld.com>
Reply-To: mike.start@ntlworld.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mtaout02-winn.ispmail.ntl.com (mtaout02-winn.ispmail.ntl.com
	[81.103.221.48]) by alsa0.perex.cz (Postfix) with ESMTP id 1953024134
	for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2008 00:12:56 +0100 (CET)
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
	by mtaout02-winn.ispmail.ntl.com
	(InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP id
	<20081229231255.YZII4080.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>
	for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2008 23:12:55 +0000
Received: from [192.168.0.9] (really [82.24.254.70])
	by aamtaout03-winn.ispmail.ntl.com
	(InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP id
	<20081229231255.QINI2093.aamtaout03-winn.ispmail.ntl.com@[192.168.0.9]>
	for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2008 23:12:55 +0000
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

I've been having difficulty getting an ews88MT (ice1712 chipset) to work 
in full duplex using the jack audio server (jackd).  Capture only mode 
works fine, even down to 64 samples latency, Playback only mode works 
fine down to 64 samples latency.  Duplex mode causes 'xruns' at even 
2048 samples latency.  Looking at the interrupt handler, if I add some 
diagnostics to tell me the difference between the capture and playback 
DMA counters timing out I see what appears to be clock drift between the 
  playback and capture halves of the ice1712.  I also added some debug 
messages to show what sample rate the alsa driver was setting the 
hardware to and it agrees with the rate set in my jackd invocation 
(jackd -R -d alsa -n 2 -p 1024 - r 48000 -d hw:0,0)
Also adding diagnostics to jackd to show the time spent in poll waiting 
for the capture and playback interrupts shows that they start in sync 
and gradually drift until an 'xrun' occurs when they are '-p' samples 
apart.  According to the ice1712 data sheet the 'professional' 
multitrack part of this chip (the part my soundcard is using) runs its 
inputs and outputs from the same master clock so I'm puzzled as to why 
they are drifting.  Does anybody have any more information relating to 
the ews88mt?  - I think the drivers are working fine but the problems 
are being caused by the capture and playback not being quite in sync 
which renders it almost useless for professional recording.  Anyone have 
any suggestions?

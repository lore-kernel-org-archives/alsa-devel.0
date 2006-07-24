From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001151]: Audigy sampling rate seems off
Date: Tue, 25 Jul 2006 00:46:27 +0200
Message-ID: <8d54e83dc01e4bd0e59a705f2b87f4f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C8AA3166
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Jul 2006 00:46:27 +0200 (MEST)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1151> 
======================================================================
Reported By:                felix
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1151
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               Suse 9.1
Kernel Version:             2.6.5-7.147-default
======================================================================
Date Submitted:             06-02-2005 23:07 CEST
Last Modified:              07-25-2006 00:46 CEST
======================================================================
Summary:                    Audigy sampling rate seems off
Description: 
I'm doing an experiment that involves generating a tone, sending it out
the
sound card and into a (passive) circuit, and recording from the circuit
back
into line in at the same time.

When I play a sample: mono, 8kHz sample rate, containing a synthetic 1kHz
sin signal, the recording I get is of a signal 1000.12Hz. If I send 100Hz,
I get back 100.012Hz. I use 'snd' to do a 256K-point FFT across a 10
second sample just to be sure. I've also verified this using FFTW and
correlation-based programs of my own.

I've also verified that the reference 1kHz and 100Hz signals are exact.

As a sanity check, I tried the same experiment on the built-in sound card
on that same PC. The signals come back correct.

Note the seeming coincidence that the frequency of the signal coming back
is 1/8000 higher than the signal output.

I've never seen anything like it. Not that I've been looking before...
======================================================================

----------------------------------------------------------------------
 felix - 06-04-05 03:58 
----------------------------------------------------------------------
Two more exciting data, to see whether it is possible to isolate the
problem to playback or recording:

1. synthesize and aplay a 1kHz tone at 8kHz sampling rate,
   simultaneously record at 12kHz sampling rate
   => Recorded tone is shifted up by ~ 1/8k

2. synthesize and aplay a 1kHz tone at 12kHz sampling rate,
   simultaneously record at 8kHz sampling rate
   => recorded tone is EXACTLY 1000Hz

----------------------------------------------------------------------
 jcdutton - 07-25-06 00:46 
----------------------------------------------------------------------
Is this still a problem with the latest alsa driver?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-05 23:07 felix          New Issue                                    
06-02-05 23:07 felix          Distribution              => Suse 9.1        
06-02-05 23:07 felix          Kernel Version            => 2.6.5-7.147-default
06-03-05 00:29 sst4           Note Added: 0004879                          
06-03-05 10:59 perex          Note Added: 0004883                          
06-03-05 17:44 felix          Note Added: 0004884                          
06-03-05 17:45 felix          Note Edited: 0004884                         
06-04-05 03:42 felix          Note Added: 0004885                          
06-04-05 03:58 felix          Note Added: 0004886                          
07-18-06 14:45 jcdutton       Status                   new => assigned     
07-18-06 14:45 jcdutton       Assigned To               => jcdutton        
07-25-06 00:46 jcdutton       Note Added: 0011217                          
07-25-06 00:46 jcdutton       Status                   assigned => feedback
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

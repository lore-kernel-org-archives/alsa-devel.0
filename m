From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001151]: Audigy sampling rate seems off
Date: Thu, 2 Jun 2005 23:07:56 +0200
Message-ID: <178630e19238fc6fc8800261ef7c3a10@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3C5F91CF
	for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2005 23:07:56 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1151> 
======================================================================
Reported By:                felix
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1151
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Suse 9.1
Kernel Version:             2.6.5-7.147-default
======================================================================
Date Submitted:             06-02-2005 23:07 CEST
Last Modified:              06-02-2005 23:07 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-05 23:07 felix          New Issue                                    
06-02-05 23:07 felix          Distribution              => Suse 9.1        
06-02-05 23:07 felix          Kernel Version            => 2.6.5-7.147-default
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005

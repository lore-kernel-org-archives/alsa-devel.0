From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000765]: Very high latency with MIDI soft + dmix + ALSA PCM
Date: Sat, 19 Mar 2005 09:22:08 +0100
Message-ID: <4c602721e5316a4ed5137a5411e86131@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 575131EE
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 09:22:08 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=765> 
======================================================================
Reported By:                ccasteyde
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   765
Category:                   general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-31-2004 13:54 CET
Last Modified:              03-19-2005 09:22 CET
======================================================================
Summary:                    Very high latency with MIDI soft + dmix + ALSA PCM
Description: 
There is a high latency problem with the ALSA MIDI sequencer and the PCM
interface, and this is even more true when dmix is used.

My goal was to use Timidity or fluidsynth as soft wavetable to emulate
MIDI port 128:0 and mix their output with other PCM applications through
dmix. It's nearly impossible, since in this configuration sound is hashed
as if the synth software was unable to output data while dealing with each
MIDI tune. I think nearly 30% sound is lost during this process.

The funny thing is that forcing Timidity to use aRts as output, and
configuring aRts itself to use ALSA pcm dmixer makes everything works
nicely. I think this is due to the extra desynchronisation and buffering
due to the main aRts thread, which lets Timidity release ALSA resource
before sending the output to the DMA card.

I therefore suspect a locking problem/resource contention in ALSA
driver/ALSALib. If this proves true, and cannot be fixed with fine locking
rules, I think it is in ALSA lib the problem should be fixed rather than
in each sound software (the problem appears with both Timidity and
Fluidsynth and certainly all software that use both input and ouput ALSA
devices).
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 09:22 
----------------------------------------------------------------------
Submitter: Has there been any progress on this issue?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-31-04 13:54 ccasteyde      New Issue                                    
12-31-04 13:54 ccasteyde      File Added: asound.conf                      
03-19-05 09:22 jdthood        Note Added: 0004014                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

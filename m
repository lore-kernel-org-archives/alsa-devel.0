From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002147]: lack of full duplex operation for ati-ixp chipset.
Date: Tue, 23 May 2006 18:07:11 +0200
Message-ID: <0ae4b752324133a8d791836740a819a0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3687D161
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 18:07:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2147> 
======================================================================
Reported By:                Gene Heskett
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2147
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               FC5, uptodate
Kernel Version:             2.6.16-1.2111_FC5
======================================================================
Date Submitted:             05-23-2006 03:52 CEST
Last Modified:              05-23-2006 18:07 CEST
======================================================================
Summary:                    lack of full duplex operation for ati-ixp chipset.
Description: 
skype, ekiga, audacity, and generally any program that needs to both
transmit and receive, using isolated paths, fails in playback when
recording.  In skype, I sound great at the far end, but reception may or
may not work, with emphasis on the not.  What I hear in the phones, or in
the speakers, sounds like what you would get if you took a sentence of
spoken words, break it up into say 5ms pieces, and play them at maybe 10
of these little snippets per second, so that the resultant sound is broken
up to the point of no comprehension, and stretched in time by a
considerable amount.

In audacity, simultanious playback, or play one track while recording
another, likewise fails in that only very short snippets of the played
track are output to the phones or speakers.

Likewise, ekiga suffers from this same effect, I'm told I sound great on
teh other end, but I can't hear more than half a word occasionally.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-23-06 17:24 
----------------------------------------------------------------------
Surprising, you have no WAV files for playback, or you have no oggdec or
sox program on your system.  Apparently you're trying something very
special.

I asked a simple test like below:

0. prepare a WAV file for playback.  not necessarily so long.
1. set up your system a loopback from line-out jack directly to line-in.
2. select the capture source to "Line" (or "Mic" according to your h/w
setting)
3. run "aplay somefile.wav" on a terminal
4. run "arecord -vv -fcd foo.wav" on another terminal at the same time.
   VU meter appears, and adjust the "Capture Volume" for the preferred
level
5. check the recorded WAV file.

Alternatively, you can record via internal loopback without jack
connection by choosing "Mix" as the capture source.  Then the playback
audio is directly routed to the ADC.  In this case, the setup 1 and 2 can
be omitted.

----------------------------------------------------------------------
 Gene Heskett - 05-23-06 18:07 
----------------------------------------------------------------------
The only .wav files are the short, maybe 1 second max length, sound effects
for many programs.  It is an FC5 install about 6 weeks old.

1: no line out or line in on this laptop, only headphone and microphone
jacks are actually present.

2: In kmix, the mics red led button seems to be mutually exclusive with
almost any other source.  Mic works fine. Either in my phones or on the
other end.

3. I'll have to see if I can re-rip something to a .wav.  And it will be
an intermittent effort after today, for quite a few days as I'll be
working on an antenna (big broadcast one 40+ feet long, several thousand
pounds) for the next 2-3 weeks as much as I can push these 71 year old
bones to do.

4: isn't a problem, and I'm not really concerned that 5 will fail, its the
playback at stage 3 that won't work.  I have done similar tests using
audacity
and its always the playback that fails, unless playback is the ONLY thing
audacity is doing ATM.

I'd just like to make skype or zfone to work, but nothing seems to make
the incoming audio usable when there is an outgoing stream.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-23-06 03:52 Gene Heskett   New Issue                                    
05-23-06 03:52 Gene Heskett   Distribution              => FC5, uptodate   
05-23-06 03:52 Gene Heskett   Kernel Version            => 2.6.16-1.2111_FC5
05-23-06 15:01 tiwai          Note Added: 0009934                          
05-23-06 16:46 Gene Heskett   Note Added: 0009938                          
05-23-06 17:24 tiwai          Note Added: 0009941                          
05-23-06 18:07 Gene Heskett   Note Added: 0009943                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

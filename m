From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002147]: lack of full duplex operation for ati-ixp chipset.
Date: Tue, 23 May 2006 19:14:08 +0200
Message-ID: <bde9e7a94db6645e83f968d676431b1f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 85D1817B
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 19:14:08 +0200 (MEST)
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
Last Modified:              05-23-2006 19:14 CEST
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

----------------------------------------------------------------------
 tiwai - 05-23-06 19:14 
----------------------------------------------------------------------
Grr, you make the things too complex.  Let's sort out the thing straight.

The duplex problem and the inproper recording are different things. 
First, check whether both non-duplex playback and recording work
properly.

For checking playback, you can use speaker-test program in alsa-utils
package, too.  Run "speaker-test -c2 -tw", for example.

As I mentioned, you can test recording of the played stream by setting
"Capture Source" to "Mix".  It needs no extra hardware setup, so no hard
work after running a full marathon.

If the full-duplex works by this way, skype and other programs should work
as well -- as long as you set up the mixer correctly.

Anyway, don't use audacity or whatever apps might be using OSS emulation
for tests.  They can't be used as references.  Use basic tools included in
ALSA packages for primary tests.

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
05-23-06 19:14 tiwai          Note Added: 0009947                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

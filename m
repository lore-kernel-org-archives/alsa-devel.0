From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001887]: Can't record anything from MIC with Acer 1641 (ALC260)
Date: Fri, 3 Mar 2006 01:44:17 +0100
Message-ID: <e7f3b618b9806a405c4b6695ba546374@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3D68716C
	for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2006 01:44:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1887> 
======================================================================
Reported By:                grattemedi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1887
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 10.2
Kernel Version:             2.6.15.4
======================================================================
Date Submitted:             03-01-2006 22:35 CET
Last Modified:              03-03-2006 01:44 CET
======================================================================
Summary:                    Can't record anything from MIC with Acer 1641
(ALC260)
Description: 
With the new hda drivers in CVS, the speakers and jack output works very
good.
But I can't record anything from the external mic or from the mic input.
I followed jwoithe advises : To record from the internal mic or the
external mic jack, you need to:

 * select the "mic" as the input source (displayed in "Playback" view)
 * in the "Mic Jack Mode" control, select "Mic bias 80pc"
 * in "Capture" view, unmute "Capture" channel (NOT "Capture 1") and
   turn its volume up.
Even after doing that, I can't record sound.
Nevertheless, when I unmute the "mic" channel in the alsamixer "playback",
i can hear sound from the mic but i cannot record it.
======================================================================

----------------------------------------------------------------------
 jwoithe - 03-03-06 00:02 
----------------------------------------------------------------------
Er-ku: unmuting both "capture" and "capture 1" will not case capture to
consist of a sum of these two.  As I've explained in another post,
"capture 1" only comes into play if your software allows you to select a
pcm other than pcm0.  The switches in alsamixer are simply mutes - they do
not "select" the capture channel for capture as such.  The selecting of
one or the other is done by the recording software, and a lot of recording
software doesn't let you specify something other than the default - which
will always be "capture" on these chipsets.

grattemedi: the output from amixer is indeed interesting, although I'll
have to check the output on my laptop to ensure nothing funny is going on.
 I agree with you in that the amixer output does make it look like the
capture channels are still muted.

The "m" key in alsamixer will not do anything, as you have noticed.  If
however you highlight the "Capture" channel and press the space bar, you
should see the series of dashes (below the level bar) change to "CAPTURE".
 If you haven't tried this, could you please do so and let us know the
results?

The hexdump is also interesting and not at all what I would have expected.
 Rather than 0x7f7f all over the place I would have expected numbers just
above or just below 0.  0x7f is of course the midpoint of an 8 bit range,
so if you were recording in 8 bit mode to an unsigned format this would
probably be expected.

Hmm, the header of the wav file you've hexdumped does indeed indicate that
you were capturing in 8 bit mode (at 8kHz too).  At least that explains
the data.  It is also consistent with the capture channel still being
muted.  It might also explain the lack of data - I've never tested the
ALC260 in mono unsigned 8 bit
mode at 8 kHz and I don't know how successful this would be.

In light of this, you may with to try the following command line when
doing the tests noted above:

  rec -c 2 -f s -r 44100 -s w test.wav

This should result in a stereo recording made at 44100 Hz with signed 16
bit samples - a format which is known to work with this codec.  That is,
so long as the above command line doesn't contain a silly typo. :)

Er-ku: when you did your recording tests, were you using "rec" similarly
to grattemedi?  If so, odds are that you captured in 8 bit mode at 8 kHz
and this could partly explain the poor recording quality you noted.

----------------------------------------------------------------------
 grattemedi - 03-03-06 01:44 
----------------------------------------------------------------------
I'm so sorry to have disturb you for such a thing.Finally it was the space
with the capture highlighted that resolved the problem. Eventough, the
command
 "amixer set Capture unmute" does nothing, but the "toggle" as the same
effect than space in alsamixer. I'm sorry, i didn't see this option in
alsamixer.

The record in 44100 Hz works very good and quality is perfect, but rec
with no option like you said cause a bad quality sound as it's in 8kHz.

Thank you very much for your patience.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-01-06 22:35 grattemedi     New Issue                                    
03-01-06 22:35 grattemedi     Distribution              => Slackware 10.2  
03-01-06 22:35 grattemedi     Kernel Version            => 2.6.15.4        
03-01-06 22:36 grattemedi     Issue Monitored: grattemedi                    
03-01-06 22:37 grattemedi     Issue End Monitor: grattemedi                    
03-02-06 00:53 jwoithe        Note Added: 0008289                          
03-02-06 01:19 grattemedi     Note Added: 0008290                          
03-02-06 01:38 jwoithe        Note Added: 0008291                          
03-02-06 08:30 er-ku          Note Added: 0008294                          
03-02-06 11:25 cartman        Issue Monitored: cartman                     
03-02-06 17:10 grattemedi     Note Added: 0008321                          
03-02-06 17:11 grattemedi     File Added: test.wav                         
03-02-06 17:13 grattemedi     Note Edited: 0008321                         
03-02-06 17:13 grattemedi     Note Edited: 0008321                         
03-02-06 18:21 grattemedi     Note Added: 0008325                          
03-03-06 00:02 jwoithe        Note Added: 0008328                          
03-03-06 01:44 grattemedi     Note Added: 0008330                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

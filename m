From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000669]: Creative SB Live! 24-bit External (USB) works only at a minimal level.
Date: Wed, 24 Nov 2004 00:51:20 +0100
Message-ID: <9b30764fc4cfc729ab34f68e4ea1045b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 126D22BD
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 00:51:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=669> 
======================================================================
Reported By:                Henni
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   669
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2004.3
Kernel Version:             2.6.9-cko3
======================================================================
Date Submitted:             11-23-2004 19:23 CET
Last Modified:              11-24-2004 00:51 CET
======================================================================
Summary:                    Creative SB Live! 24-bit External (USB) works only
at a minimal level.
Description: 
The Creative SB Live! 24-bit External is a "card" similar to the Audigy 2
NX (probably its litte brother).

With the snd-usb-audio the ''only'' thing working is the stereo output. I
read that the Audigy 2 NX works far better with the snd-usb-audio.
Probably there is a way to get the SB Live! 24-bit on a similar lvl?

PS: I added some informations about it as an attachment.

======================================================================

----------------------------------------------------------------------
 pzad - 11-23-04 21:09 
----------------------------------------------------------------------
Hmm, did you tryed alsamixer ??? because there is capture volume too.

----------------------------------------------------------------------
 Henni - 11-24-04 00:51 
----------------------------------------------------------------------
Yes. I tried alsamixer. It shows only PCM Output and PCM Capture (I got
"PCM capture" by using the "Show only Capture" option of alsamixer).

I 'got' working the 4 and 6 channels Mode with mplayer by using the
following option:

  mplayer $FILE -channels 4 (or 6) -ao alsa:device=default 

(I have to use alsa:device=default because mplayer tries to use surround41
or surround51 if you choose alsa and channels > 2 and this results in an
error).

But DigitalOut doesn't work as it should.

If I choose mplayer $FILE -channels 4 the digital out works (testet with
an Pioneer Home Cinema System with Optical In). With -channels 6 I get an
underrun and with -ac hwac3 (for AC3 Passthrough) it doesn't work (there
is no definition for the optical out).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-04 19:23 Henni          New Issue                                    
11-23-04 19:23 Henni          File Added: output.txt                       
11-23-04 19:23 Henni          Distribution              => Gentoo 2004.3   
11-23-04 19:23 Henni          Kernel Version            => 2.6.9-cko3      
11-23-04 19:58 Henni          Issue Monitored: Henni                       
11-23-04 21:09 pzad           Note Added: 0002527                          
11-24-04 00:51 Henni          Note Added: 0002540                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

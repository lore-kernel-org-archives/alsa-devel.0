From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000929]: Left/Right reversed when using the raw iec958 on Audigy2
Date: Mon, 30 May 2005 13:41:32 +0200
Message-ID: <cfd7395b48dc3d3fdc41ef59c9ce11bc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 98C6B1C7
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2005 13:41:32 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=929> 
======================================================================
Reported By:                TheOrwithVagrant
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   929
Category:                   hw specific configuration
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-21-2005 14:56 CET
Last Modified:              05-30-2005 13:41 CEST
======================================================================
Summary:                    Left/Right reversed when using the raw iec958 on
Audigy2
Description: 
When using an spdif-attatched amplifier, the iec958/spdif raw device to
play a sound (or video file), the left and right channels end up
reversed.

Example:

This produces "correct" left and right mappings

extract_ac3 AC3TEST.VOB |ac3dec

The following, however, reverses left & right:

extract_ac3 AC3TEST.VOB |ac3dec -R

Likewise, when playing a dvd with mplayer, things are correct if i merely
use -ao alsa, but end up with left/right reversed if i use -ao
alsa:device=iec958.

It appears to be an error in Audigy2.conf - changing the line

value [ 255 255 0 0 0 0 0 0  0 255 0 0 0 0 0 0 255 0 0 0 0 0 0 0 ]

to

value [ 255 255 0 0 0 0 0 0  255 0 0 0 0 0 0 0 0 255 0 0 0 0 0 0 ]

as in Audigy.conf, makes the channels appear from the right speaker even
when using the raw spdif device.
======================================================================

----------------------------------------------------------------------
 jcdutton - 03-19-05 11:46 
----------------------------------------------------------------------
A proper fix for this is using DSP code. I recently posted an email to
alsa-user with a patch for people to try, who are having problems with AC3
out on the raw iec58 device. So, depending on their feedback, it will be
fixed soon.

----------------------------------------------------------------------
 perex - 05-30-05 13:41 
----------------------------------------------------------------------
Reporter - is this bug fixed in 1.0.9?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-21-05 14:56 TheOrwithVagrantNew Issue                                    
02-21-05 15:04 pzad           Note Added: 0003679                          
02-21-05 15:14 TheOrwithVagrantNote Added: 0003680                          
02-22-05 03:59 rlrevell       Note Added: 0003684                          
03-19-05 09:21 jdthood        Note Added: 0004013                          
03-19-05 09:58 jdthood        Note Added: 0004028                          
03-19-05 11:36 TheOrwithVagrantNote Added: 0004032                          
03-19-05 11:46 jcdutton       Note Added: 0004033                          
05-30-05 13:41 perex          Note Added: 0004813                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005

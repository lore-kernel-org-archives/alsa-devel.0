From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000929]: Left/Right reversed when using the raw iec958 on Audigy2
Date: Sat, 19 Mar 2005 09:21:04 +0100
Message-ID: <f5806de59f968f7ea814254526e3bddf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BF23D1EE
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 09:21:04 +0100 (MET)
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
Last Modified:              03-19-2005 09:21 CET
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
 rlrevell - 02-22-05 03:59 
----------------------------------------------------------------------
FWIW, there is an open bug report for the same issue with the Audigy 2 EX.

----------------------------------------------------------------------
 jdthood - 03-19-05 09:21 
----------------------------------------------------------------------
> It appears to be an error in Audigy2.conf - changing the line
>
> value [ 255 255 0 0 0 0 0 0 0 255 0 0 0 0 0 0 255 0 0 0 0 0 0 0 ]
> 
> to
>
> value [ 255 255 0 0 0 0 0 0 255 0 0 0 0 0 0 0 0 255 0 0 0 0 0 0 ]


Looking at 1.0.8 I see that this change has been made.  I guess this
report can be closed, then.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-21-05 14:56 TheOrwithVagrantNew Issue                                    
02-21-05 15:04 pzad           Note Added: 0003679                          
02-21-05 15:14 TheOrwithVagrantNote Added: 0003680                          
02-22-05 03:59 rlrevell       Note Added: 0003684                          
03-19-05 09:21 jdthood        Note Added: 0004013                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

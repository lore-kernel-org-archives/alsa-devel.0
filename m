From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001205]: Mark M-Audio Revolution 7.1 (and probably other ICE1724 cards) as the one with no capture in card matrix
Date: Tue, 21 Jun 2005 23:53:21 +0200
Message-ID: <9880c5f6ca2f14886409103a7d210e57@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3D53E1F6
	for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2005 23:53:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1205> 
======================================================================
Reported By:                sst4
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1205
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-20-2005 00:30 CEST
Last Modified:              06-21-2005 23:53 CEST
======================================================================
Summary:                    Mark M-Audio Revolution 7.1 (and probably other
ICE1724 cards) as the one with no capture in card matrix
Description: 
Takashi said the following regarding M-Audio Revolution 7.1 card:

in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1096 :

"
No, there is no capture control at all on this board, indeed. At least,
the hardware spec I got tells nothing about the capture controls. No gain
control, no input selection.
";

in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1164 :

"
Again, revo has no capture control. At least, the hardware spec I got
tells so.
";

in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1187 :

"
The input selection of line-in and mic is unknown thing - i.e. we have no
technical information about this feature at all. 
".

The quoted words above were said in response to my questions regarding
enabling capture.

>From the same quoted words I understand that at the moment there is no
known
way to enable capture.

Because of this I think it would be fair to mark the card as the one with
unsupported capture. Probably other ICE1724-based cards have the same
problem
too.

It would be a pity if other people buy the card and wouldn't be able to
use its
capture.

I have uploaded current snapshot of ALSA card matrix, it says:
"
 (4) Capture of sound not supported.
",
so I think this marker should be added to the card's description.

Thanks,
  Sergei.


======================================================================

----------------------------------------------------------------------
 tiwai - 06-21-05 12:44 
----------------------------------------------------------------------
Please read texts carefully.  The capture works partially.  But no
"control" for capture exists.

----------------------------------------------------------------------
 sst4 - 06-21-05 23:53 
----------------------------------------------------------------------
Takashi - "The capture works partially" words of yours are not true.

That is, out of the box capture does NOT work, and to be fair it does not
work for almost any card.

However, if I look into, say, asound.state file of CT4610 and the like
cards,
(
snd-ens1371 driver, recent example:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1023 , attached
https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=654&type=bug

file
),

I see pieces like these:


	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
.

So, I understand that in order to enable capture I have to give TRUE
values to flags and non-zero values to volumes.

And changing the flags/volumes makes capture work.

In the M-Audio asound.state file I see no words like "Line Playback
Switch",
"Line Playback Volume", so I do not know what to change in order to get
capture
working.

I asked the question about controls of M-Audion Revolution 7.1. time and
again,
and equivalent question about changing values in asound.state file too,
but you
gave me no answer.

So, since apparently nobody knows the answer, please marked the card as
the
one with unsupported capture, or tell me, please, whow to enable capture.

In particular, what control numbers in asound.state file of M-Audio
Revolution
to change and how to make capture work.

Thanks,
  Sergei.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-20-05 00:30 sst4           New Issue                                    
06-20-05 00:30 sst4           File Added: alsa_card_matrix.html                 
  
06-21-05 12:44 tiwai          Note Added: 0005107                          
06-21-05 23:53 sst4           Note Added: 0005114                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

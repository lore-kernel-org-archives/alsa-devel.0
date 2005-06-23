From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001205]: Mark M-Audio Revolution 7.1 (and probably other ICE1724 cards) as the one with no capture in card matrix
Date: Thu, 23 Jun 2005 10:47:16 +0200
Message-ID: <82fd52fcf12b74a8bf87de5622436d46@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 08A171D5
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2005 10:47:16 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1205> 
======================================================================
Reported By:                sst4
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1205
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             06-20-2005 00:30 CEST
Last Modified:              06-23-2005 10:47 CEST
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
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001096 no capture with M-Audio Revolution 7.1
======================================================================

----------------------------------------------------------------------
 sst4 - 06-22-05 23:16 
----------------------------------------------------------------------
Takashi, regarding these words of yours:
"
Both inputs from mic-in and line-in are recorded simply via "arecord -fcd
foo.wav".
"
- I didn't try recording.

As I wrote in my report, I wanted to hear sound from my TV card in the
headphones.

The same TV card works fine with other sound cards; I wrote about my way
(of testing)/expectations on May the 24th 2005 in

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1096 :

"
I am trying to answer the "How did you test the capture?" question:

I have a Pinnacle TV capture card is connected to Line input of the
M-Audio cound card.

I also have a microphone connected to Mic input of the M-Audio cound
card.

Both the TV card and the microphone worked fine with SB Live 5.1 - out of
the box.

As I incidentally discovered
(https://bugtrack.alsa-project.org/alsa-bug/view.php [^]?id=1106)
the card is able of capturing sound at least under some circumstances.

In layman terms I would like to be able to hear sound from my TV card and
from my microphone
the way it used to be with SB Live 5.1.

Do I have, by any chance, to change settings of routing switches in
'alsamixer' or using 'amixer' ?

If yes, what should the settings be ?

Thanks,
  Sergei.
".

At this stage functionality of 'arecord' is secondary - I need first to
hear
sound in the headphones.

So, could you please try to reproduce my environment by checking sound in
the headphones (rather, on "Line out" in generic terms).

Thanks,
  Sergei.

----------------------------------------------------------------------
 tiwai - 06-23-05 10:47 
----------------------------------------------------------------------
This is a misunderstanding.  Let's close.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-20-05 00:30 sst4           New Issue                                    
06-20-05 00:30 sst4           File Added: alsa_card_matrix.html                 
  
06-21-05 12:44 tiwai          Note Added: 0005107                          
06-21-05 23:53 sst4           Note Added: 0005114                          
06-22-05 01:47 rlrevell       Relationship added       duplicate of 0001096
06-22-05 11:16 tiwai          Note Added: 0005122                          
06-22-05 23:16 sst4           Note Added: 0005154                          
06-23-05 10:47 tiwai          Status                   new => resolved     
06-23-05 10:47 tiwai          Resolution               open => not an issue
06-23-05 10:47 tiwai          Assigned To               => tiwai           
06-23-05 10:47 tiwai          Note Added: 0005165                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

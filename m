From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000902]: Some channels not working
Date: Thu, 3 Mar 2005 20:07:15 +0100
Message-ID: <569890a40044e8c6b57023d415a220ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 00F621F2
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2005 20:07:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=902> 
======================================================================
Reported By:                slammer
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   902
Category:                   PCI - intel8x0
Reproducibility:            have not tried
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware
Kernel Version:             2.6.11-rc2
======================================================================
Date Submitted:             02-12-2005 00:02 CET
Last Modified:              03-03-2005 20:07 CET
======================================================================
Summary:                    Some channels not working
Description: 
I wanted to get my Creative Inspire 5300 5.1 analog surround speaker set
working  with my souncard working on linux.
I use speaker-test for testing the speakers under linux. I have to add
that they're working fine in Windows (tested each speaker using nvMixer).
I have two independent sockets for LFE/Center and Rear channels (they're
not shared with Mic and Line in as in some other products e.g. Epox
8RDA+).
I've noticed that the surround51 pcm defined in
/usr/share/alsa/NFORCE.conf does some routing on the stream - namely swaps
LFE/Center with rear channels and that seems right, because hw:0,0 tested
by speaker-test plays them incorrectly. So when doing my test, creating
own pcms and else I had it on my mind.

However what this bug report is all about is that I can't get any sound
playing from the first channel through anything connected to the socket
originally (according to the MoBo manual) used for LFE/Center neither
using the surround51 nor hw:0,0 pcm. I also tried to make my own pcm but
the diagnosis is the 
same.

Here are the facts:
My speakers connected just the way they work in Windows.

$speaker-test -c6 -Dsurround51
Playback device is surround51
Stream parameters are 48000Hz, S16_LE, 6 channels
Sine wave rate is 440.0000Hz
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 3 to 5461
Period size range from 3 to 5461
Periods = 4
Buffer time size 2525
To choose buffer_size = 5460
To choose period_size = 1365
was set period_size = 1365
was set buffer_size = 5460
 0 - Front Left            # I hear the beep correctly from correct
speaker
 4 - Center                # I hear the beep correctly from correct
speaker
 1 - Front Right           # I hear the beep correctly from correct
speaker
 3 - Rear Right            # No sound ;(((
 2 - Rear Left             # I hear the beep correctly from correct
speaker
 5 - LFE                   # I hear the beep correctly from correct
speaker (yes it's quiet, but I''m sure it comes from the Subwoofer only)

When I create my own pcm that reroutes the 3rd channel to some other - it
plays from the position where routed, but nothing ever gets played from
that muted channel when routed there - hence my diagnosis.
When I use hw:0,0 the situation's the same except the LFE/Center and Rear
sockets are swapped, as stated before.

Moreover if I turn the switches "Mic as Center" and "Line-in as surround"
"on" to use it the Epox way, and plug my jacks where stated, the case is
similar but even worse, since it won't play ANY of the first channels
(i.e. Rear Right and LFE from surround51 pcm) at both sockets. Second
channels (Center and Rear Left) work just fine.

Or maybe it has something to do with settings for capture, because I
haven't used it and played with it at all? Let me know if they can affect
it and if so, I think there should be some notice somewhere (on the
module's istalation manual), because I couldn't find any.

Additionally when tried to play with the "Swap surround slot" option there
was a thought of another may-be-issue that came to me. Namely when i turn
the option "on" and physically do the swap, the "Duplicate Front" option
duplicates front channels still to the Unswapped plug i.e. I hear the
channels through the Center/LFE channels. I think that the "Duplicate
front"  switch should be affected by the "Swap surround" switch. Don't You
think so?

I'm in a dead end right now and quite desperate. I also am interested in
making Linux work on more hardware!

======================================================================

----------------------------------------------------------------------
 slammer - 02-28-05 21:51 
----------------------------------------------------------------------
Opps... My friend switched from Slackware to Suse and the problem's gone.
He can hear all the channels. Hmmm :/ Does anyone have the idea where to
investigate on this?

----------------------------------------------------------------------
 slammer - 03-03-05 20:07 
----------------------------------------------------------------------
Hmm... that Suse is using 1.07rc1. Gotta check it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-12-05 00:02 slammer        New Issue                                    
02-12-05 00:02 slammer        Distribution              => Slackware       
02-12-05 00:02 slammer        Kernel Version            => 2.6.11-rc2      
02-12-05 00:43 slammer        Issue Monitored: slammer                     
02-25-05 12:44 slammer        Note Added: 0003733                          
02-28-05 21:51 slammer        Note Added: 0003750                          
03-03-05 20:07 slammer        Note Added: 0003791                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000370]: CMedia 8768 Support
Date: Tue, 4 Jan 2005 05:12:50 +0100
Message-ID: <3842ffa1b337ac9f7d6c2fb624cc2f47@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 60D582CD
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2005 05:12:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=370> 
======================================================================
Reported By:                drbobguy
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   370
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-07-2004 04:59 CEST
Last Modified:              01-04-2005 05:12 CET
======================================================================
Summary:                    CMedia 8768 Support
Description: 
I've recently built a new computer with an on-board CMedia 8768 chip.  This
chip is not listed as one of the supported CMedia chips (8738, etc.),
although I suspect that is because it is so new.  Just wanted to let you
guys know it apparently doesn't work with the standard cmipci driver (at
least I think I'm doing everthing correctly -- I have a decent amount of
Linux experience but I'm no guru).  Here is what I see though:

The card is recognized in /proc/asound as a CMedia 8738M6.  However, if I
use a mixer like amixer or gnome-alsamixer none of the mixer settings I
change will take effect (and I am running these as root).

Any advice or comments would be appreciated.  I'd be happy to help if you
think there is a possible fix.
======================================================================

----------------------------------------------------------------------
 cltien - 12-25-04 17:13 
----------------------------------------------------------------------
I tested this board (Soltek EQ3801) and found that the on-board codec
cannot be accessed in DOS. It cannot betested by our DOS diagonal program
, but a add-on card can.

I guess that the BIOS doesn't initialize the on-board codec correctly.
Does ayone has this kind of problem with another mother board?

ChenLi Tien

----------------------------------------------------------------------
 robg - 01-04-05 05:12 
----------------------------------------------------------------------
>From a thread on sfftech:
http://forums.sudhian.com/messageview.aspx?catid=102&threadid=70188&enterthread=y

The thread brought up cltien's note here about the codec not working. The
response from Soltek:

Actually some days ago, one customer reported to us that onboard audio of
EQ3801 does not work under "Fedora Core 3 Linux". So now our BIOS engineer
and C-Media support are working on this issue. If there is any progress, I
will let you know.

Best regards,
LydiAtSoltek

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-07-04 04:59 drbobguy       New Issue                                    
07-07-04 04:59 drbobguy       Distribution              => Gentoo          
07-07-04 04:59 drbobguy       Kernel Version            => 2.6.7           
07-07-04 05:03 drbobguy       Note Added: 0001390                          
07-27-04 05:26 robg           Note Added: 0001475                          
07-30-04 16:56 tiwai          Note Added: 0001493                          
07-31-04 02:46 drbobguy       File Added: CMI8768.pdf                      
07-31-04 02:46 drbobguy       Note Added: 0001508                          
07-31-04 06:10 robg           Note Added: 0001509                          
08-22-04 22:13 masanetz       Issue Monitored: masanetz                    
09-06-04 18:02 patrick        Issue Monitored: patrick                     
10-08-04 05:17 robg           Note Added: 0002043                          
10-08-04 05:18 robg           File Added: CMI8768 register spec v1.0.pdf        
           
10-08-04 05:19 robg           File Added: Programming Guide to CMI8738 PCI Audio
Chip_v16_0311.pdf                    
10-08-04 12:49 tiwai          Note Added: 0002050                          
10-08-04 15:26 tiwai          Note Added: 0002053                          
10-08-04 15:36 tiwai          Note Added: 0002054                          
10-09-04 09:05 patrick        File Added: asound.state                     
10-09-04 09:08 patrick        File Added: cmipci                           
10-09-04 09:29 patrick        Note Added: 0002061                          
10-09-04 09:30 patrick        Note Edited: 0002061                         
10-10-04 04:48 robg           Note Added: 0002064                          
10-10-04 04:57 robg           Note Added: 0002065                          
10-13-04 16:37 tiwai          Note Added: 0002126                          
10-13-04 16:37 tiwai          Note Added: 0002127                          
10-14-04 01:24 patrick        Note Added: 0002136                          
10-14-04 12:02 tiwai          Note Added: 0002139                          
10-14-04 12:03 tiwai          File Added: cmipci-address.diff                   

10-14-04 16:05 patrick        Note Added: 0002151                          
10-14-04 16:19 tiwai          Note Added: 0002152                          
10-14-04 23:57 patrick        Note Added: 0002161                          
10-16-04 00:33 cltien         Note Added: 0002177                          
10-16-04 07:32 robg           Note Added: 0002184                          
10-17-04 05:47 ehrenkranz     Issue Monitored: ehrenkranz                    
10-18-04 11:32 tiwai          Note Added: 0002194                          
10-18-04 23:00 cltien         Note Added: 0002199                          
10-19-04 05:35 robg           Note Added: 0002202                          
11-22-04 12:11 Los_Andros     Note Added: 0002495                          
11-22-04 12:12 Los_Andros     Note Edited: 0002495                         
12-25-04 17:13 cltien         Note Added: 0002933                          
01-04-05 05:12 robg           Note Added: 0003078                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

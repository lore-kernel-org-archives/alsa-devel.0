From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000154]: Master volume only controls front output (emu10k1)
Date: Thu, 17 Feb 2005 23:28:09 +0100
Message-ID: <cc5e0a512f54d3935f710e53274e85de@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B9B45251
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2005 23:28:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=154> 
======================================================================
Reported By:                wzzrd
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   154
Category:                   mixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             03-23-2004 17:31 CET
Last Modified:              02-17-2005 23:28 CET
======================================================================
Summary:                    Master volume only controls front output (emu10k1)
Description: 
Setting the alsamixer Master Volume slider only controls the front two
speakers. The rear speakers have to be controlled with the Wave Surround
setting. I'm not sure whether this is an alsamixer bug or a alsa-driver
bug. If I'm wrong putting it here, sorry.

It would be very convenient to be able to control all four speakers with
the Master Volume setting and to have a Front and Rear slider to control
the front and rear speakers individually.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000176 Master volume does not alters center, L...
has duplicate       0000786 Master can't handle all channel
related to          0000172 Master volume control only controls fro...
======================================================================

----------------------------------------------------------------------
 rlrevell - 02-17-05 22:59 
----------------------------------------------------------------------
Please check the recent postings for alsa-user and alsa-devel lists before
asking this question.  If you read them you would know that yes, it's
being worked on,  and no, it's not fixed yet.

If you want to pay me to work on this, please mail me privately. 
Otherwise be patient.

----------------------------------------------------------------------
 adamk75 - 02-17-05 23:28 
----------------------------------------------------------------------
I've been waiting since early last year.  I thought I was being patient
:-)

Anyway, I was only asking because the thread back and forth on alsa-devel
and alsa-user about the problem stopped almost a week ago.  Since the
volume levels of alsa-devel and alsa-user are way too high for me, I
figured I'd check up here.

Anyway, the driver has been broken for so long, I can certainly wait a
little longer.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-23-04 17:31 wzzrd          New Issue                                    
03-23-04 18:42 perex          View Status              @0@ => public       
03-23-04 18:42 perex          Description Updated                          
03-23-04 18:42 perex          Additional Information Updated                    
03-23-04 18:43 perex          Status                   new => assigned     
03-23-04 18:43 perex          Assigned To               => perex           
03-26-04 20:21 djtm           Note Added: 0000708                          
04-19-04 02:47 tarball        Issue Monitored: tarball                     
04-19-04 21:23 perex          Relationship added       has duplicate 0000176
05-24-04 22:51 delmonico      Note Added: 0001199                          
10-22-04 16:44 perex          Relationship added       related to 0000172  
10-23-04 01:09 djtm           Note Added: 0002253                          
10-23-04 01:09 djtm           File Added: alsavol.sh                       
10-23-04 01:10 djtm           Note Edited: 0002253                         
11-25-04 12:46 rpolach        Issue Monitored: rpolach                     
01-04-05 21:01 Miwer          Note Added: 0003081                          
01-04-05 21:11 rlrevell       Note Added: 0003082                          
01-04-05 21:29 pzad           Note Added: 0003083                          
01-04-05 21:38 rlrevell       Note Added: 0003084                          
01-04-05 22:30 pzad           Note Added: 0003085                          
01-04-05 22:38 rlrevell       Note Added: 0003086                          
01-07-05 18:23 tiwai          Relationship added       has duplicate 0000786
01-09-05 20:28 voroskoi       Issue Monitored: voroskoi                    
01-27-05 00:58 adamk75        Issue Monitored: adamk75                     
01-27-05 01:00 adamk75        Note Added: 0003418                          
02-01-05 22:57 adamk75        Note Added: 0003475                          
02-03-05 20:20 rlrevell       Note Added: 0003493                          
02-17-05 22:01 adamk75        Note Added: 0003642                          
02-17-05 22:59 rlrevell       Note Added: 0003646                          
02-17-05 23:28 adamk75        Note Added: 0003647                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

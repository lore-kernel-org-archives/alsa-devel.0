From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001183]: Details about known bug
	"Capture doesn't work"
Date: Sun, 23 Jul 2006 11:39:49 +0200
Message-ID: <a0555546099a460f93f90e0df79afcb2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0E426187
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Jul 2006 11:39:49 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1183> 
======================================================================
Reported By:                Jochen
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1183
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             06-11-2005 20:34 CEST
Last Modified:              07-23-2006 11:39 CEST
======================================================================
Summary:                    Details about known bug "Capture doesn't work"
Description: 
I'm experiencing the problem with es1968 not supporting capture described
in various places. This bug keeps me from using skype: the second it tries
to read from the OSS compatibility device it receives and EINVAL

using the old OSS maestro driver works thou.

apparently this is the known bug "capture doesn't work"

I'd like to ask for a little more information on this bug, and whether
it's possible to contribute here.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000895 Es1968 driver seems not to support &quo...
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-22-06 00:35 
----------------------------------------------------------------------
Was this fixed in later ALSA versions?

----------------------------------------------------------------------
 Raymond - 07-07-06 06:36 
----------------------------------------------------------------------
Post output of

cat /proc/asound/cards

cat /proc/asound/pcm

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-05 20:34 Jochen         New Issue                                    
06-13-05 13:07 tiwai          Note Added: 0005007                          
06-13-05 15:53 Jochen         Note Added: 0005011                          
06-15-05 14:42 tiwai          Note Added: 0005028                          
09-26-05 10:04 LawrenceG      Issue Monitored: LawrenceG                    
09-26-05 10:20 LawrenceG      Note Added: 0006390                          
09-26-05 10:43 LawrenceG      Note Added: 0006391                          
03-22-06 00:35 rlrevell       Note Added: 0008763                          
03-22-06 00:37 rlrevell       Relationship added       related to 0000895  
07-07-06 06:36 Raymond        Note Added: 0010894                          
07-23-06 11:39 Adrian Bunk    Status                   assigned => closed  
07-23-06 11:39 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

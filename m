From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001584]: Load rises to 100% when dmix is used with ICE1724 (SN25P)
Date: Sat, 17 Dec 2005 23:37:39 +0100
Message-ID: <095c06df88725ff502dcb01a7131f6b5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3CBF819D
	for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2005 23:37:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1584> 
======================================================================
Reported By:                mr511
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1584
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             11-20-2005 20:33 CET
Last Modified:              12-17-2005 23:37 CET
======================================================================
Summary:                    Load rises to 100% when dmix is used with ICE1724
(SN25P)
Description: 
ALSA applications using the dmix plugin run at 100% load. Verified with
aplay, alsaplayer, xine, aoss+mpg123 and several others.

Approximately 1/3 of the load appears to be in user space, 2/3 in system
space.

Re-installing alsa-lib 1.0.8 makes the problem go away.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-17-05 20:16 
----------------------------------------------------------------------
Please try the latest ALSA CVS version and remove your .asoundrc and see if
the problem is still present.

----------------------------------------------------------------------
 mr511 - 12-17-05 23:37 
----------------------------------------------------------------------
Sorry, alsa-lib from CVS doesn't change anything except that asym/dmix is
now the default for my card. The kernel part doesn't compile yet.

But I found out something else: It's a 64/32 bit problem. I use a 64-bit
kernel but 32-bit userland because the same system is supposed to run on
either kind of processor. When I use a 64-bit client, however, the load
stays low.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-20-05 20:33 mr511          New Issue                                    
11-21-05 14:37 mr511          Note Added: 0006771                          
11-21-05 21:43 mr511          Note Added: 0006777                          
12-17-05 20:16 rlrevell       Note Added: 0007067                          
12-17-05 23:37 mr511          Note Added: 0007068                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

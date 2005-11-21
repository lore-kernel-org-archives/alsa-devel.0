From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001584]: Load rises to 100% when dmix is used with ICE1724 (SN25P)
Date: Mon, 21 Nov 2005 14:37:50 +0100
Message-ID: <489ade51ed02cd136d9961c51782b230@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7ACF616F
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2005 14:37:50 +0100 (MET)
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
Last Modified:              11-21-2005 14:37 CET
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
 mr511 - 11-21-05 14:37 
----------------------------------------------------------------------
One more note: when using alsaplayer, the following system calls are
repeated again and again:

read(5, "", 16)                         = 0
poll([{fd=5, events=POLLIN|POLLERR|POLLNVAL, revents=POLLIN}], 1, -1) = 1
ioctl(4, 0xc0844123, 0x825f298)         = 0
ioctl(4, 0xc0844123, 0x825f298)         = 0
ioctl(4, 0xc0844123, 0x825f298)         = 0
ioctl(4, 0xc0844123, 0x825f298)         = 0

The ioctl appears to be SNDRV_PCM_IOCTL_SYNC_PTR.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-20-05 20:33 mr511          New Issue                                    
11-21-05 14:37 mr511          Note Added: 0006771                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click

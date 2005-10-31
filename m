From: bugtrack@alsa-project.org
Subject: =?iso-8859-1?Q?[ALSA_-_liboss_0001518]:_dmix_plugin_doesn=B4t_work_with_O?=
 =?iso-8859-1?Q?SS_kernel_emulation?=
Date: Mon, 31 Oct 2005 05:18:36 +0100
Message-ID: <2c5de0e92aa0735b4087d773bd8617ea@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7358F159
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2005 05:18:36 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1518> 
======================================================================
Reported By:                kyromaster
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1518
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-31-2005 01:22 CET
Last Modified:              10-31-2005 05:18 CET
======================================================================
Summary:                    dmix plugin doesn´t work with OSS kernel emulation
Description: 
I hope this isn´t misplaced here, but IMHO this is a bug in the
architecture. Many people have those crappy AC97 codecs without hardware
mixing and want to use OSS apps beside their ALSA ones (like teamspeak
together with games). dmix works but not with the kernel emulation, and
"aoss" is not easy enough for newbies and also doesn´t work with all
apps.
So will dmix support be added to the kernel OSS emulation layer?+
======================================================================

----------------------------------------------------------------------
 rlrevell - 10-31-05 05:18 
----------------------------------------------------------------------
It's not possible because dmix runs in userspace.  The solution is for the
distros to run all OSS apps with "aoss" so newbies don't have to deal with
it at all.  If aoss does not work with some apps it's either a bug in aoss
or a bug in those apps and should be reported here.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-31-05 01:22 kyromaster     New Issue                                    
10-31-05 05:18 rlrevell       Note Added: 0006582                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information

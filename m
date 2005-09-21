From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000306]: compiles, but no sound comes out
Date: Wed, 21 Sep 2005 19:34:49 +0200
Message-ID: <efcb210d5c3017c88bfaee2a9a62f887@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F2DF4170
	for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2005 19:34:49 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=306> 
======================================================================
Reported By:                Quietti
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   306
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             self-compiled 2.6.6 vanilla.
======================================================================
Date Submitted:             05-25-2004 20:35 CEST
Last Modified:              09-21-2005 19:34 CEST
======================================================================
Summary:                    compiles, but no sound comes out
Description: 
This is a plain vanilla kernel 2.6.6, which uses ALSA 1.0.4.

The kernel compiles fine, the snd_powermac module loads without any error,
but no sound comes up.

Running alsamixer gives me a mixer screen where none of the sliders can be
moved.
======================================================================

----------------------------------------------------------------------
 Quietti - 09-21-05 13:02 
----------------------------------------------------------------------
rlrevell, this is the second time you suggest checking out CVS and, on both
occasions, there was no change in the PPC directory that concern any of
the defective drivers. The first time had no single change in the
directory at all, while this time only has the addition of the toonie
driver for the Mac Mini and even that is old news.

----------------------------------------------------------------------
 rlrevell - 09-21-05 19:34 
----------------------------------------------------------------------
You need to open separate bug reports for those issues.

Bug #306 is "no sound" which you reported on 8-31 was fixed in 2.6.13.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 20:35 Quietti        New Issue                                    
05-25-04 20:35 Quietti        File Added: asound.state                     
05-25-04 20:35 Quietti        Distribution              => Debian          
05-25-04 20:35 Quietti        Kernel Version            => self-compiled 2.6.6
vanilla.
05-25-04 20:38 Quietti        Issue Monitored: Quietti                     
05-28-04 21:18 tiwai          Note Added: 0001274                          
05-28-04 21:37 Quietti        Note Added: 0001275                          
07-25-04 20:16 Quietti        Note Added: 0001473                          
09-08-04 06:32 Quietti        Note Added: 0001726                          
10-20-04 00:38 Quietti        Note Added: 0002209                          
01-06-05 18:14 Quietti        Note Added: 0003093                          
01-06-05 18:27 rlrevell       Note Added: 0003094                          
01-06-05 19:43 Quietti        Note Added: 0003095                          
01-07-05 00:00 Quietti        Note Added: 0003096                          
01-07-05 00:19 Quietti        Note Added: 0003097                          
01-07-05 00:30 Quietti        Note Added: 0003098                          
01-14-05 00:53 Quietti        Note Added: 0003206                          
02-04-05 09:22 Quietti        Note Added: 0003496                          
02-04-05 13:04 tiwai          Note Added: 0003499                          
04-02-05 13:33 Quietti        Note Added: 0004297                          
08-06-05 20:24 Quietti        Note Added: 0005682                          
08-06-05 20:31 rlrevell       Note Added: 0005683                          
08-06-05 20:32 rlrevell       Note Added: 0005684                          
08-06-05 20:53 rlrevell       Note Added: 0005685                          
08-06-05 21:17 rlrevell       Note Added: 0005686                          
08-06-05 23:54 rlrevell       Note Added: 0005687                          
08-06-05 23:55 rlrevell       Note Deleted: 0005683                        
08-06-05 23:55 rlrevell       Note Deleted: 0005684                        
08-07-05 10:03 pochini        Note Added: 0005689                          
08-07-05 10:31 Quietti        Note Added: 0005690                          
08-07-05 10:46 rlrevell       Note Added: 0005691                          
08-07-05 11:36 Quietti        Note Added: 0005692                          
08-07-05 11:44 Quietti        Note Added: 0005693                          
08-07-05 20:27 rlrevell       Note Added: 0005697                          
08-08-05 14:53 Quietti        Note Added: 0005708                          
08-08-05 19:42 rlrevell       Note Added: 0005711                          
08-11-05 13:09 Johannes Berg  Note Added: 0005755                          
08-11-05 13:09 Johannes Berg  Issue Monitored: Johannes Berg                    
08-31-05 11:44 Quietti        Note Added: 0005986                          
09-17-05 20:13 Quietti        Note Added: 0006259                          
09-17-05 20:21 rlrevell       Note Added: 0006260                          
09-20-05 12:23 Quietti        Note Added: 0006313                          
09-21-05 03:59 rlrevell       Note Added: 0006320                          
09-21-05 04:00 rlrevell       Note Added: 0006321                          
09-21-05 10:52 Quietti        Note Added: 0006322                          
09-21-05 13:02 Quietti        Note Added: 0006323                          
09-21-05 19:34 rlrevell       Note Added: 0006324                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

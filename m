From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001261]: poor recording with emu10k1
Date: Thu, 29 Sep 2005 12:06:11 +0200
Message-ID: <40b9cbafce925c2d016979739438a4c5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3FA57ED
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 12:06:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1261> 
======================================================================
Reported By:                mal
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1261
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             all 2.6 versions
======================================================================
Date Submitted:             07-16-2005 09:28 CEST
Last Modified:              09-29-2005 12:06 CEST
======================================================================
Summary:                    poor recording with emu10k1
Description: 
Sound recording does not work right with emu10k1 on linux 2.6

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=144940

This problem has ben an issue for a while. People can not use sound on
linux because of it.

======================================================================

----------------------------------------------------------------------
 mal - 09-29-05 11:11 
----------------------------------------------------------------------
The reported problem still exists in kernel-2.6.12-1.1378_FC3

----------------------------------------------------------------------
 pzad - 09-29-05 12:06 
----------------------------------------------------------------------
Check what alsa version is in /proc/asound/version

If there is 1.0.10rc1 - then it should work. If there is 1.0.9 then this
is old buggy alsa and you should update to latest alsa.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-05 09:28 mal            New Issue                                    
07-16-05 09:28 mal            Kernel Version            => all 2.6 versions
07-16-05 09:31 mal            Note Added: 0005485                          
07-16-05 09:49 rlrevell       Note Added: 0005486                          
07-16-05 10:32 mal            Note Added: 0005487                          
07-16-05 10:34 mal            Note Added: 0005488                          
07-16-05 10:38 mal            Note Added: 0005489                          
07-16-05 10:41 mal            File Added: tsts.wav                         
07-16-05 10:51 mal            File Added: t44100.wav                       
07-16-05 10:52 mal            Note Added: 0005490                          
07-16-05 10:53 mal            File Added: t44100_stereo.wav                    
07-16-05 11:00 mal            Note Added: 0005491                          
07-16-05 11:07 mal            File Added: t_cd.wav                         
07-16-05 11:08 mal            Note Added: 0005492                          
07-16-05 11:09 mal            Note Edited: 0005492                         
07-16-05 12:12 rlrevell       Note Added: 0005493                          
07-16-05 12:32 mal            File Added: cc.wav                           
07-16-05 12:33 mal            Note Added: 0005494                          
09-26-05 20:14 vladak         Note Added: 0006397                          
09-26-05 21:13 rlrevell       Note Added: 0006398                          
09-26-05 21:19 rlrevell       Note Added: 0006399                          
09-29-05 11:02 vladak         Note Added: 0006413                          
09-29-05 11:11 mal            Note Added: 0006414                          
09-29-05 12:06 pzad           Note Added: 0006415                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

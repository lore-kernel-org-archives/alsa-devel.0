From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001301]: Kernel OSS emulation stops working after a few seconds when used with VoIP softphones
Date: Mon, 31 Oct 2005 17:44:23 +0100
Message-ID: <a060917466f950892ede48b4861a142b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 366C2164
	for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2005 17:44:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1301> 
======================================================================
Reported By:                tek01
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1301
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             vanilla 2.6.11.12, vanilla 2.6.10 and Debians
2.6.8-2
======================================================================
Date Submitted:             08-02-2005 17:16 CEST
Last Modified:              10-31-2005 17:44 CET
======================================================================
Summary:                    Kernel OSS emulation stops working after a few
seconds when used with VoIP softphones
Description: 
Kernel OSS emulation fails a few seconds after a call is established when
used with kphone(Debian) or iaxcomm(self made) softphones. Examining the
process using strace reveals, that the file descriptor of the sound device
is no longer listed in the readset or writeset when the select() syscall
returns. Audio Playback using XMMS is working fine using the OSS API
 
Also the native OSS driver is working fine with both VoIP phones on the
same system and kernel.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001300 modprobe goes into D-state when inserti...
======================================================================

----------------------------------------------------------------------
 perex - 08-18-05 13:18 
----------------------------------------------------------------------
Use the latest ALSA from CVS (you can compile ALSA as external module) and
the latest kernel (with the patch from
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1300).

----------------------------------------------------------------------
 rlrevell - 10-31-05 17:44 
----------------------------------------------------------------------
Is this problem still present in the latest ALSA release?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-05 17:16 tek01          New Issue                                    
08-02-05 17:16 tek01          Distribution              => Debian Sarge    
08-02-05 17:16 tek01          Kernel Version            => vanilla 2.6.11.12,
vanilla 2.6.10 and Debians 2.6.8-2
08-02-05 18:27 Adrian Bunk    Issue Monitored: Adrian Bunk                    
08-03-05 10:10 perex          Relationship added       related to 0001300  
08-03-05 10:47 perex          Note Added: 0005614                          
08-05-05 11:20 tek01          Note Added: 0005664                          
08-18-05 13:18 perex          Note Added: 0005847                          
10-31-05 17:44 rlrevell       Note Added: 0006587                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information

From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001300]: modprobe goes into D-state when inserting snd-ad1816a
Date: Thu, 18 Aug 2005 13:16:53 +0200
Message-ID: <f4e14d6e4316872412cc57b3d01f47f5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D15B0151
	for <alsa-devel@alsa-project.org>; Thu, 18 Aug 2005 13:16:53 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1300> 
======================================================================
Reported By:                tek01
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1300
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian Sarge
Kernel Version:             2.6.12.3 and 2.6.13-rc4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-02-2005 16:56 CEST
Last Modified:              08-18-2005 13:16 CEST
======================================================================
Summary:                    modprobe goes into D-state when inserting
snd-ad1816a
Description: 
Under Linux 2.6.12.3 and Linux 2.6.13-rc4 inserting the snd-ad1816a module
causes the modprobe process to go into D-state forever. 

Linux 2.6.11.12 has been tested and is working fine.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001301 Kernel OSS emulation stops working afte...
related to          0001302 Clicking noise when using kphone with t...
======================================================================

----------------------------------------------------------------------
 tek01 - 08-16-05 12:56 
----------------------------------------------------------------------
You are absolutly right. The snd-mpu401 module gets loaded earlier during
system startup. After unloading the snd-mpu401 module the snd-ad1816a
module loads fine. 
I'll check if #1301 and #1302 are still valid with 2.6.13-rc6.

----------------------------------------------------------------------
 perex - 08-18-05 13:16 
----------------------------------------------------------------------
Okay, so the bug is resolved. I need only push the patch to mainstream
Linux kernel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-05 16:56 tek01          New Issue                                    
08-02-05 16:56 tek01          Distribution              => Debian Sarge    
08-02-05 16:56 tek01          Kernel Version            => 2.6.12.3 and
2.6.13-rc4
08-02-05 18:27 Adrian Bunk    Issue Monitored: Adrian Bunk                    
08-02-05 22:26 perex          Note Added: 0005609                          
08-03-05 10:10 perex          Relationship added       related to 0001301  
08-03-05 10:11 perex          Relationship added       related to 0001302  
08-09-05 12:57 perex          Assigned To               => perex           
08-09-05 12:57 perex          Status                   new => feedback     
08-13-05 22:51 tek01          Note Added: 0005811                          
08-15-05 14:32 perex          File Added: pnp-card.c.patch                    
08-15-05 14:33 perex          Note Added: 0005818                          
08-15-05 20:34 tek01          Note Added: 0005821                          
08-16-05 01:25 perex          Note Added: 0005825                          
08-16-05 12:56 tek01          Note Added: 0005828                          
08-18-05 13:16 perex          Status                   feedback => resolved
08-18-05 13:16 perex          Resolution               open => fixed       
08-18-05 13:16 perex          Note Added: 0005846                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001025]: kernel panic when trying to load module snd-au8830
Date: Thu, 22 Dec 2005 13:01:26 +0100
Message-ID: <fd78feaf01a10b620551a298e0dd8ad5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E93951BF
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 13:01:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1025> 
======================================================================
Reported By:                Osiris
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1025
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             03-30-2005 22:50 CEST
Last Modified:              12-22-2005 13:01 CET
======================================================================
Summary:                    kernel panic when trying to load module snd-au8830
Description: 
kernel panic occurs on boot when system tries to load kernel module for
Aureal Vortex 2. The same thing happens when driver is compiled into
kernel, not module

======================================================================

----------------------------------------------------------------------
 ponchick - 12-21-05 04:18 
----------------------------------------------------------------------
I try diff11.diff on alsa-driver-1.0.10 with minor changes in it. It works
for me. I use it for 2 weeks now and it works fine. I use mixer/equalizer
but don't even touch gameport, mpu and oss emulation. 
My configuration:
P4 631 (em64t)
Aureal Vortex 2
Gentoo Linux 2005.1 
Kernel 2.6.14-gentoo-r2 and 2.6.13-gentoo-r5 (vanilla sources + some
gentoo patches)
alsa-drivers 1.0.10 (not kernel one!)

----------------------------------------------------------------------
 Raymond - 12-22-05 13:01 
----------------------------------------------------------------------
There is no need to change long eq_levels[32] to u16 eq_levels[64] in
au88x0_eqdata.c

vortex_EqHw_SetLevels() only setup 24 registeres.(i.e the 2x10 EQ peaks
and 4 other registers 0x2b3cc,0x2b3d8,0x2b3e4,0x2b3f0.)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-05 22:50 Osiris         New Issue                                    
03-30-05 22:50 Osiris         Distribution              => Debian          
03-30-05 22:50 Osiris         Kernel Version            => 2.6.11.6        
03-31-05 11:34 mjander        Note Added: 0004278                          
04-03-05 21:16 Osiris         Note Added: 0004320                          
04-04-05 10:19 alien999999999 Issue Monitored: alien999999999                   

04-04-05 11:00 alien999999999 File Added: alsa-changes.tar.bz2                  
 
04-04-05 11:00 alien999999999 Note Added: 0004325                          
08-24-05 11:04 Raymond        Note Added: 0005927                          
11-25-05 08:22 Raymond        Note Added: 0006848                          
12-21-05 04:05 ponchick       Issue Monitored: ponchick                    
12-21-05 04:18 ponchick       Note Added: 0007107                          
12-21-05 04:19 ponchick       File Added: diff11.diff.bz2                    
12-22-05 13:01 Raymond        Note Added: 0007123                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

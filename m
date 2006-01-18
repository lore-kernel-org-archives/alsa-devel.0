From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001025]: kernel panic when trying to load module snd-au8830
Date: Wed, 18 Jan 2006 16:07:39 +0100
Message-ID: <09646c826a322a083f4b673d76c5c6f5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B1AB216A
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2006 16:07:39 +0100 (MET)
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
Last Modified:              01-18-2006 16:07 CET
======================================================================
Summary:                    kernel panic when trying to load module snd-au8830
Description: 
kernel panic occurs on boot when system tries to load kernel module for
Aureal Vortex 2. The same thing happens when driver is compiled into
kernel, not module

======================================================================

----------------------------------------------------------------------
 Raymond - 01-05-06 08:28 
----------------------------------------------------------------------
Refer to those MMIO trace logs on your web site.

Not all MMIO are read/write in 32bits (e.g. hardware mixer input volume
seem to be read/write in 8-bits instead of 32bits)

One set of WT frequency register(0x20a) seem to be write in 16-bits and
0x20a is aligned to word boundary and not double word boudnary.

----------------------------------------------------------------------
 Raymond - 01-18-06 16:07 
----------------------------------------------------------------------
Do your au8830 has the swap of front and rear channels problem ?

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726

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
01-02-06 09:57 Raymond        Note Deleted: 0007123                        
01-05-06 08:28 Raymond        Note Added: 0007463                          
01-18-06 16:07 Raymond        Note Added: 0007712                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642

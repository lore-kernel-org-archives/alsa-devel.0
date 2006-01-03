From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001076]: Can't use mmap with device
Date: Tue, 3 Jan 2006 12:39:34 +0100
Message-ID: <d6a38e88946a167221b91b71e52870a2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 393D2162
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2006 12:39:34 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0000373.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1076> 
======================================================================
Reported By:                nachoexr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1076
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Linux 4.05 Hoary
Kernel Version:             2.6.11.7
======================================================================
Date Submitted:             04-25-2005 00:08 CEST
Last Modified:              04-25-2005 00:08 CEST
======================================================================
Summary:                    Can't use mmap with device
Description: 
Detected with the Quake 3 (Q3 1.32b linux-i386 Nov 14 2002) that can't
initialize audio with this error:

------- sound initialization -------
Could not mmap dma buffer PROT_WRITE|PROT_READ
trying mmap PROT_WRITE (with associated better compatibility / less
performance code)
/dev/dsp: Input/output error
Could not mmap /dev/dsp
------------------------------------

after many tests the audio works except in applications using mmap. 
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000373 Sound in Quake 3 does not work
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-05 00:08 nachoexr       New Issue                                    
04-25-05 00:08 nachoexr       Distribution              => Ubuntu Linux 4.05
Hoary
04-25-05 00:08 nachoexr       Kernel Version            => 2.6.11.7        
05-01-05 20:27 JHM2           Issue Monitored: JHM2                        
01-03-06 12:39 perex          Relationship added       related to 0000373  
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

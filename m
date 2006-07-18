From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000319]: Cannot control main volume
	independently for left and right channels
Date: Tue, 18 Jul 2006 14:48:14 +0200
Message-ID: <7074ddf7221adf05de525d567ac7b1da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 99F3E12C
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:48:14 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=319> 
======================================================================
Reported By:                walrus121
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   319
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 1
Kernel Version:             2.4.26-1.ll.rhfc1.ccrma (from Planet CCRMA)
======================================================================
Date Submitted:             05-31-2004 17:46 CEST
Last Modified:              07-18-2006 14:48 CEST
======================================================================
Summary:                    Cannot control main volume independently for left
and right channels
Description: 
I have tried with numerous volume control programs, and I get the same
result.  If I try to adjust one channel, the values of the two channels
are averaged in some strange way and are rebalanced to the center.  I know
that this must be a driver-specific issue because I can control the two
channels independently for my Sound Blaster AWE 64 Value card, also in my
computer, and because it doesn't seem to matter which mixer I use.
======================================================================

----------------------------------------------------------------------
 rlrevell - 11-17-04 19:22 
----------------------------------------------------------------------
Can you verify the bug with the latest ALSA version. 1.0.7?

----------------------------------------------------------------------
 jdthood - 03-23-05 15:28 
----------------------------------------------------------------------
Submitter: Can you verify the bug still exists in the latest ALSA release?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-31-04 17:46 walrus121      New Issue                                    
05-31-04 17:46 walrus121      File Added: modules.conf                     
05-31-04 17:46 walrus121      Distribution              => Fedora Core 1   
05-31-04 17:46 walrus121      Kernel Version            =>
2.4.26-1.ll.rhfc1.ccrma (from Planet CCRMA)
11-17-04 19:22 rlrevell       Note Added: 0002441                          
03-23-05 15:28 jdthood        Note Added: 0004160                          
07-18-06 14:48 jcdutton       Status                   new => assigned     
07-18-06 14:48 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

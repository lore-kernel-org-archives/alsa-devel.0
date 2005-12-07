From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001557]: Sounds play only for a very short time (VT8251, 64-bit)
Date: Wed, 7 Dec 2005 11:24:15 +0100
Message-ID: <75ff0c8f80de68c62b18b7605f4030c2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 927C5155
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2005 11:24:15 +0100 (MET)
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


The following issue has been set as DUPLICATE OF issue 0001622.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1557> 
======================================================================
Reported By:                Dakkus
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1557
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10 "Breezy Badger" (64-bit)
Kernel Version:             2.6.12-9-amd64-generic
======================================================================
Date Submitted:             11-14-2005 13:10 CET
Last Modified:              12-07-2005 11:24 CET
======================================================================
Summary:                    Sounds play only for a very short time (VT8251,
64-bit)
Description: 
When playing for example an mp3 file, only a short burst of sound is heard.
The songs play with correct speed and sound otherwise correct, but sound
is played only for about one second. If I choose any random part of the
song (for example with xmms), I hear the same ~1s from that part of the
song, but then everything's quiet again.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001622 ASUS A8V-MX onboard sound does not work
======================================================================

----------------------------------------------------------------------
 m_yates - 12-06-05 15:15 
----------------------------------------------------------------------
I have the same motherboard and the same problem.  I have reproduced it in
Ubuntu 5.10 i386, Ubuntu 5.10 amd64, Debian Etch (i386 and amd64), and
Knoppix (version 4).  Upgrading to Alsa 1.0.10 didn't help, nor did
upgrading the kernel to 2.6.15-rc2.

I also accidently filed a duplicate bug
report:https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1622 

I filed that one before I discovered this post.

----------------------------------------------------------------------
 thijser - 12-06-05 23:10 
----------------------------------------------------------------------
Exactly the same here ...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-14-05 13:10 Dakkus         New Issue                                    
11-14-05 13:10 Dakkus         Distribution              => Ubuntu 5.10 "Breezy
Badger" (64-bit)
11-14-05 13:10 Dakkus         Kernel Version            =>
2.6.12-9-amd64-generic
12-05-05 19:01 m_yates        Issue Monitored: m_yates                     
12-06-05 15:15 m_yates        Note Added: 0006923                          
12-06-05 22:35 thijser        Issue Monitored: thijser                     
12-06-05 23:10 thijser        Note Added: 0006939                          
12-07-05 11:24 perex          Relationship added       duplicate of 0001622
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

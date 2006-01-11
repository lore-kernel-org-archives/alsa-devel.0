From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001740]: No sound on ACER laptop with ALC260
Date: Wed, 11 Jan 2006 22:40:20 +0100
Message-ID: <358e0c09e9bec48e1bded9538ebfaae3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A99AD160
	for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2006 22:40:20 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1740> 
======================================================================
Reported By:                Nicolas_Raoul
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1740
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora, Ubuntu, SUSE
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-11-2006 22:40 CET
Last Modified:              01-11-2006 22:40 CET
======================================================================
Summary:                    No sound on ACER laptop with ALC260
Description: 
Hello all,

I have no sound on my ACER Aspire 1640 laptop, Intel HDA, ALC260, all
unmuted, latest everything, tried on:
- SUSE
- Kubuntu
- Ubuntu 2005.10
- Ubuntu 2006.04-flight1
- Fedora
So far, I have never seen any unsilent ALC260 on ACER (please confirm or
infirm). This has lead me to suspect there may be a problem within ALSA.

Yesterday I started modifying the ALSA source code to try and fix it.
Especially, I edited patch_realtek.c. One hour ago, I finally managed to
get some sound out of the headphones :-)

If you have some informations or questions, my contact ids are on
http://nrw.free.fr . Documentation from ACER would be particulary
helpful.

Have a good day,
Nicolas Raoul.

PS: This issue looks somehow similar to those ones:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001517
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001618
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0001736.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 22:40 Nicolas_Raoul  New Issue                                    
01-11-06 22:40 Nicolas_Raoul  Distribution              => Fedora, Ubuntu, SUSE
01-11-06 22:40 Nicolas_Raoul  Kernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

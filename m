From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000677]: Audigy2 ZS detection misses my card
Date: Wed, 24 Nov 2004 19:50:38 +0100
Message-ID: <41e9cf285aa12f58f7895588ca519a24@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3A61E27F
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 19:50:39 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=677> 
======================================================================
Reported By:                m_wright
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   677
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9-ck2
======================================================================
Date Submitted:             11-24-2004 19:50 CET
Last Modified:              11-24-2004 19:50 CET
======================================================================
Summary:                    Audigy2 ZS detection misses my card
Description: 
Audigy 2 ZS detection in emu10k1_main.c misses my Aud 2 ZS Plat Pro. My
card has an ID of 0x2001 and code assumes only 0x2002. Attached patch that
I used to correct.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 19:50 m_wright       New Issue                                    
11-24-04 19:50 m_wright       File Added: audigy.patch                     
11-24-04 19:50 m_wright       Distribution              => Gentoo          
11-24-04 19:50 m_wright       Kernel Version            => 2.6.9-ck2       
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

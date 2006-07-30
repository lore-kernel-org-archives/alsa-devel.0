From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002316]: ALC883 incorrectly detected
	as ALC882
Date: Sun, 30 Jul 2006 03:06:56 +0200
Message-ID: <e553dbd274593eb81b5dd0d15ac7ded7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1CDF8179
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 03:06:57 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2316> 
======================================================================
Reported By:                kip
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2316
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.15-26-686 #1 SMP
======================================================================
Date Submitted:             07-30-2006 03:06 CEST
Last Modified:              07-30-2006 03:06 CEST
======================================================================
Summary:                    ALC883 incorrectly detected as ALC882
Description: 
I am on an ASUS A7J laptop with the Intel HD Audio Controller. It uses the
ALC883 chipset. I know this because of lspci and from the laptop's
hardware specs. The machine has a beautiful four speaker setup that
produces awesome sound under XP.

On both Debian 3.1 and Ubuntu 6.06, whether it be from the latest code in
the HG repository, Realtek's custom patches, 1.0.12rc1, or the build that
ships with Ubuntu (1.0.10), they all have the same effect.

The card is detected as the ALC882 and this is reported in alsamixer or in
the kernel messages when I modprobe snd-hda-intel. There is no rear
channel listed in the alsamixer, except front and the other usual ones
like pcm, line, cd, etc.

When I run speaker-test -c4, sound comes from the front two speakers, but,
as expected, just silence from the back.

This is probably all connected to the wrong chipset being detected.

I have tried playing with the model parameters to snd-hda-intel. They do
nothing.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-30-06 03:06 kip            New Issue                                    
07-30-06 03:06 kip            Distribution              => Ubuntu          
07-30-06 03:06 kip            Kernel Version            => 2.6.15-26-686 #1 SMP
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001149]: CPU overload error and arts exits
Date: Wed, 1 Jun 2005 16:35:18 +0200
Message-ID: <ec3505dd2371c47545af9705993310b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2C943FA
	for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2005 16:35:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1149> 
======================================================================
Reported By:                anandrajan
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1149
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE 9.3 Pro x86-64 version
Kernel Version:             2.6.11
======================================================================
Date Submitted:             06-01-2005 16:35 CEST
Last Modified:              06-01-2005 16:35 CEST
======================================================================
Summary:                    CPU overload error and arts exits
Description: 
Hardware: A7V Deluxe with onboard Realtek ALC 850 sound and Marvel gigabit
ethernet, AMD Athlon 64 3000+, 1GB DDR 400, two IDE disks, NEC DVD RW,
Plextor CD-RW, ELSA GLoria III nVidia Quadro2 Pro videocard, Soundblaster
Live PCI soundcard

Software: SuSE 9.3 Pro x86-64 version, KDE 3.4, alsa 1.0.8 drivers

Originally I had configured both the onboard Realtek and the Soundblaster
cards. Then I removed the Realtek from the configuration. Unfortunately
and even when full duplex is not checked in KDE 3.4, I get a CPU overload
error and then arts exits. If I monitor what's happening, I see the CPU
usage in arts increasing until it maxes out the CPU after which I get this
error. The arts page claims that this is a driver issue.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-01-05 16:35 anandrajan     New Issue                                    
06-01-05 16:35 anandrajan     Distribution              => SuSE 9.3 Pro x86-64
version
06-01-05 16:35 anandrajan     Kernel Version            => 2.6.11          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005

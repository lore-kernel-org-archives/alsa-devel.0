From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000375]: SB Live (Value and 5.1), OSS playback fine, ALSA playback distorted
Date: Fri, 24 Sep 2004 13:35:48 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113548.5E012101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3BD2228E
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:36:02 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000375
======================================================================
Reported By:                azrael7157
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     375
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.4.20-gentoo-r8
======================================================================
Date Submitted:             07-10-2004 17:36 CEST
Last Modified:              09-24-2004 13:35 CEST
======================================================================
Summary:                    SB Live (Value and 5.1), OSS playback fine, ALSA playback distorted
Description: 
    I'm using a SB Live!. Normally I use the SB Live! Value (CT4780) but it
came with a Dell computer, so I bought a SB Live! 5.1 Digital (SB0220) to
make sure it wasn't one of those crippled soundcards. The issue occurs
with both versions of the SB Live!
    I'm using ALSA 1.0.5 - Gentoo doesn't have alsa-driver 1.0.5a
available yet.
    I have a rather unusual problem - when I try to use ALSA e.g. aplay,
to play back a wav file e.g. one of the KDE wavs, it produces an odd
output. The output is distorted, plays back really slowly, and samples
keep on getting repeated. Once, it took over 5 minutes to play back
/usr/kde/3.1/share/sound/KDE_Startup.wav.
     On a whim, I tried using XMMS through the OSS output - to my suprise
it worked perfectly. In fact, I'm listening to MP3's as I fill out this
bug report.
     I don't know whether this is a driver issue or a mixer one - the
mixer settings are horrendous. However, I managed to get onboard sound to
work (via82xx, now disabled) through ALSA and OSS emulation perfectly fine
on the same PC, so it seems like a SB Live! specific issue.
    I've attached my asound.state in case it is a mixer issue.

======================================================================

----------------------------------------------------------------------
 azrael7157 - 07-10-2004 18:39 CEST 
----------------------------------------------------------------------
Midi playback via pmidi (using hardware or Timidity) doesn't work either.
Haven't tried an OSS midi player yet.

----------------------------------------------------------------------
 azrael7157 - 07-13-2004 18:33 CEST 
----------------------------------------------------------------------
I've been looking into this further myself, this bug can be closed now. Not
actually an ALSA issue, turns out it's a motherboard issue. I tried it in
a different computer, and it worked first time. I tried disabling ACPI,
sound started working again through aplay.
It might be worth noting in the SB Live installation pages that users of
Via chipsets on Athlon motherboards (especially the Abit AT7-MAX2) need to
disable ACPI e.g. with lilo, add append="acpi=off".

----------------------------------------------------------------------
 tiwai - 07-15-2004 11:24 CEST 
----------------------------------------------------------------------
Ok, closed now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-10-04 17:36 azrael7157     New Bug                                      
07-10-04 17:36 azrael7157     File Added: asound.state                     
07-10-04 17:36 azrael7157     Distribution              => Gentoo          
07-10-04 17:36 azrael7157     Kernel Version            => 2.4.20-gentoo-r8
07-10-04 17:37 azrael7157     Bug Monitored: azrael7157                    
07-10-04 18:39 azrael7157     Bugnote Added: 0001403                       
07-13-04 18:33 azrael7157     Bugnote Added: 0001414                       
07-15-04 11:24 tiwai          Bugnote Added: 0001427                       
07-15-04 11:24 tiwai          Resolution               open => not a bug   
07-15-04 11:24 tiwai          Status                   assigned => resolved
09-24-04 13:35 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php

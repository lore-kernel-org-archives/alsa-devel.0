From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001056]: Realtek ALC 880 on board sound chip not detected.
Date: Sun, 17 Apr 2005 01:03:02 +0200
Message-ID: <8a08b304b99d5c7c6d3be06b2d7c68fa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E7DD9267
	for <alsa-devel@alsa-project.org>; Sun, 17 Apr 2005 01:03:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1056> 
======================================================================
Reported By:                David Kinzer
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1056
Category:                   alisp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-15-2005 15:51 CEST
Last Modified:              04-17-2005 01:03 CEST
======================================================================
Summary:                    Realtek ALC 880 on board sound chip not detected.
Description: 
Description of problem:
New HP m7060n Media Center PC. (Private ASUS motherboard with integrated
sound.)
Install FC3 core (workstation config) from scratch.
Sound chip is not detected.
Core is "up2date"

>From Specs sheet:
      Integrated Intel High Definition (TM) audio (Azalia) 

          o Realtek ALC 880 chipset
          o THX certification support
          o 8-channels for Full Dolby 5.1/6.1/7.1 surround sound support
with Dolby Pro Logic IIx
          o Dolby 5.1



======================================================================

----------------------------------------------------------------------
 pzad - 04-16-05 08:58 
----------------------------------------------------------------------
You need alsa driver 1.0.9rc2. (look in file /proc/asound/version)
In default fedora kernel is alsa 1.0.6 (this doesn't suppport azalia)

On fedora is compilation of alsa-driver simple. Just download alsa-driver,
run configure, make, make instal and restart alsa (/etc/init.d/alsasound
restart) or restart computer.

----------------------------------------------------------------------
 David Kinzer - 04-17-05 01:03 
----------------------------------------------------------------------
Ah, I had installed libs instead of the driver.  Thanks.  Things are
getting better now, speaker-test works, though no other applications make
sounds.  Alsamixer is unmuted and properly controls the sound levels
during the speaker-test.  

Seems like this is no longer an alsa issue, thanks very much for your
help.  Any additional hints on getting sound from other applications (like
cd player, or games, or gnome volume slider, etc.) would be appreciated.

/usr/sbin/system-config-soundcard still reports "No Soundcards were
detected."

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-15-05 15:51 David Kinzer   New Issue                                    
04-15-05 15:52 David Kinzer   Note Added: 0004501                          
04-15-05 15:57 pzad           Note Added: 0004502                          
04-16-05 04:41 David Kinzer   Note Added: 0004504                          
04-16-05 08:58 pzad           Note Added: 0004505                          
04-17-05 01:03 David Kinzer   Note Added: 0004509                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

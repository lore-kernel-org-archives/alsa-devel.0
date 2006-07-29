From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002315]: alsaconf chooses disabled
	soundcard
Date: Sat, 29 Jul 2006 20:24:01 +0200
Message-ID: <60ca7769e5a4299b224ba8d6ecccae9e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ACBD115E
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Jul 2006 20:24:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2315> 
======================================================================
Reported By:                michaelfm
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2315
Category:                   alsaconf
Reproducibility:            have not tried
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-29-2006 20:24 CEST
Last Modified:              07-29-2006 20:24 CEST
======================================================================
Summary:                    alsaconf chooses disabled soundcard
Description: 
I use Zenwalk 2.8.  During installation alsaconf set up my soundcard.  I
was initially puzzled because alsaconf detected my integrated soundcard
(CMI9761) which is disabled in the BIOS and not normally an option.  I
chose my preferred card (Creative Labs SB0400 Audigy2 Value) and continued
the set up.  After setup I logged into XFCE.  When I ran alsamixer it
showed I was using the C-Media card and I could not hear my music playing.
 I ran alsaconf again in a terminal on the desktop.  I chose emu10k1 again
and tried alsamixer again but alsamixer still showed that I was using the
C-Media card.  At this point I restarted without running anything.  After
reboot and logon alsamixer showed I was using the Sound Blaster.  At this
point I was able to produce sound with alsamixer.

I checked /proc and I see the C-Media card listed.  I can't say if this is
the same as what I had before the 2.6.17.6 kernel because I never had a
reason to look there.  

The problems are that alsaconf set up the wrong soundcard and the settings
only take effect after reboot.

Michael
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-06 20:24 michaelfm      New Issue                                    
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

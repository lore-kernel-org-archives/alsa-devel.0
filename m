From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002180]: SPDIF output does not work
	atiixp shuttle ST62K
Date: Tue, 6 Jun 2006 12:57:51 +0200
Message-ID: <1ae1a63ca199849f7589a77f3be69bfe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4D933117
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jun 2006 12:57:51 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2180> 
======================================================================
Reported By:                Andy Lyon
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2180
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.15
======================================================================
Date Submitted:             06-02-2006 14:45 CEST
Last Modified:              06-06-2006 12:57 CEST
======================================================================
Summary:                    SPDIF output does not work atiixp shuttle ST62K
Description: 
Drivers loaded fine, spdif output listed aplay -l, no output produced at
all, no red light either.

any suggestions? info I could provide that might help?
======================================================================

----------------------------------------------------------------------
 Andy Lyon - 06-06-06 12:57 
----------------------------------------------------------------------
Hi,

Fixed (sort of!)

Over the weekend I rebuilt my system and reinstalled the os from scratch,
I now have spdif working by passing spdif_aclink=0 to snd-atiixp, there
are still some issues and I have some questions if anybody could help..

volume control does not work when output is plug:spdif, in fact I can mute
every single channel playback/capture using alsamixer and it does not
affect the spdif output at all, it keeps playing! likewise the line in /
mic in etc do not output to spdif, but i can capture from them and
playback to spdif using a named pipe and aplay/arecord. I am looking into
using softvol to control volume.

I take it that the iec958 is not "connected" to the ac97 chip, is there
anywhere i can get documentation or datasheets explaining what the two
different modes (direct and via ac97) actually are and how they differ?
I'm interested in how the chipset works..

if i fast forward or seek a mp3 in xmms when i resume playback the rest of
the track plays very quickly with no sound output.

I can live with these issues, im just pleased that spdif works at all, I
had tried using the spdif_aclink option before but it did not work, I now
think that I had another issue with kernel modules or init scripts that
was preventing the latest alsa from loading properly.

:)

andy

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-06 14:45 Andy Lyon      New Issue                                    
06-02-06 14:45 Andy Lyon      Distribution              => Gentoo          
06-02-06 14:45 Andy Lyon      Kernel Version            => 2.6.15          
06-06-06 12:57 Andy Lyon      Note Added: 0010075                          
======================================================================

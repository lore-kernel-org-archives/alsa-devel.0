From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000088]: rounding errors in increasing/decreasing volume?
Date: Sat, 19 Mar 2005 09:23:41 +0100
Message-ID: <e0808949667f2f1aed5339dd392653c9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F331E1EE
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 09:23:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=88> 
======================================================================
Reported By:                cbm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   88
Category:                   OTHERS
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Gentoo GNU Linux
Kernel Version:             2.4.24
======================================================================
Date Submitted:             02-26-2004 08:33 CET
Last Modified:              03-19-2005 09:23 CET
======================================================================
Summary:                    rounding errors in increasing/decreasing volume?
Description: 
See this gnome bug report:

http://bugs.gnome.org/show_bug.cgi?id=124741

Someone commented that its caused in the drivers?  I assume they meant
ALSA.  If its not at your end, I'll poke the gnome folk some more ;-)
======================================================================

----------------------------------------------------------------------
 cbm - 02-26-04 11:35 
----------------------------------------------------------------------
As I pointed out later in the gnome bug report, it still happens in 1.0.2. 
If you only accept bug reports on 1.0.3, I'll wait until that is in
Gentoo's portage.

I believe gnome 2.4 uses OSS so its probably OSS emulation but I don't
really know.

Here is a partial list of my loaded modules if thats worth anything.

emu10k1-gp              1416   0  (unused)
snd-via82xx            13696   0
snd-mpu401-uart         3456   0  [snd-via82xx]
snd-seq-midi            4000   0  (unused)
snd-emu10k1-synth       4764   0  (unused)
snd-emux-synth         29116   0  [snd-emu10k1-synth]
snd-seq-midi-emul       4960   0  [snd-emux-synth]
snd-seq-virmidi         3272   0  [snd-emux-synth]
snd-emu10k1            73988   7  [snd-emu10k1-synth]
snd-hwdep               5220   0  [snd-emux-synth snd-emu10k1]
snd-util-mem            1280   0  [snd-emux-synth snd-emu10k1]
snd-ac97-codec         47980   0  [snd-via82xx snd-emu10k1]
snd-rawmidi            13632   0  [snd-mpu401-uart snd-seq-midi
snd-seq-virmidi snd-emu10k1]
snd-pcm-oss            37924   1
snd-pcm                60360   1  [snd-via82xx snd-emu10k1 snd-pcm-oss]
snd-page-alloc          6548   0  [snd-via82xx snd-emu10k1 snd-pcm]
snd-mixer-oss          13456   2  [snd-pcm-oss]
snd-seq-oss            28928   0  (unused)
snd-seq-midi-event      3328   0  [snd-seq-midi snd-seq-virmidi
snd-seq-oss]
snd-seq                35952   2  [snd-seq-midi snd-emux-synth
snd-seq-midi-emul snd-seq-virmidi snd-seq- oss snd-seq-midi-event]
snd-timer              14308   0  [snd-pcm snd-seq]
snd-seq-device          4032   0  [snd-seq-midi snd-emu10k1-synth
snd-emux-synth snd-emu10k1 snd-rawmidi snd-seq-oss]
snd                    33252   3  [snd-via82xx snd-mpu401-uart
snd-seq-midi snd-emux-synth snd-seq-virmid i snd-emu10k1 snd-hwdep
snd-util-mem snd-ac97-codec snd-rawmidi snd-pcm-oss snd-pcm snd-mixer-oss
snd-seq -oss snd-seq-midi-event snd-seq snd-timer snd-seq-device]
soundcore               3780  14  [snd]

----------------------------------------------------------------------
 jdthood - 03-19-05 09:23 
----------------------------------------------------------------------
Submitter: Do you still think that there is a bug in ALSA?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-26-04 08:33 cbm            New Issue                                    
02-26-04 11:12 tiwai          Note Added: 0000334                          
02-26-04 11:35 cbm            Note Added: 0000337                          
03-19-05 09:23 jdthood        Note Added: 0004015                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

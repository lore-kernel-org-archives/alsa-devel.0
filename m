From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001389]: snd-ens1371 / es1938 Creative
	Ectiva silent playout + new line-in capture failure
Date: Tue, 13 Jun 2006 05:06:01 +0200
Message-ID: <ffaf53d8e30aecd8b25e5bee041f6d99@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2F7BC152
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jun 2006 05:06:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1389> 
======================================================================
Reported By:                wood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1389
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Modified Redhat 9.0
Kernel Version:             2.4.24 self compiled
======================================================================
Date Submitted:             09-01-2005 20:32 CEST
Last Modified:              06-13-2006 05:06 CEST
======================================================================
Summary:                    snd-ens1371 / es1938 Creative Ectiva silent playout
+ new line-in capture failure
Description: 
Soundcard: Creative Soundblaster PCI (Ectiva) Model:CT4730
Chip Label: Creative EV1938

Platform: Stable 2.4.24 Linux kernel on VIA MiniITX ME6000/M10000
          w/ multiple soundcards. ALSA compiled from source
          works with VIA motherboard Audio
          and some other Creative PCI soundcards. Need a stable ALSA
driver
          for this soundcard.

Problem:
The snd-ens1371 module loads correctly as 3rd sound device (First audio
device is VIA 8235 from motherboard, 2nd is PCSP).

Alsamixer -c 2 shows a reasonable set of
controls. Playout either with OSS emulation (play) or ALSA player
(aplay) plays WAV files but only silence for both 1.0.9 and 1.0.10rc1
releases.  
On ALSA 1.0.9 codebase,the Master Volume does not always show in
alsamixer. 
In 1.0.10rc1 it does always show.
ALSO:
  On ALSA 1.0.9 code, the Line-In capture works under both OSS Emulation
and with ALSA arecord.
On the latest development release ALSA 1.0.10rc1, the Line-In
capture no longer works. So a new problem has been introduced from .9 to
.10.


Other info:
Native OSS driver es1371 works fine with this card. But I want to switch
to ALSA.

Earlier model Creative PCI128, Model CT4750 loads snd-ens1371 and
works fine with both tested ALSA releases using same platform
configuration.

Audigy 2 Value also works fine using snd-emu10k1 with same configuration
(I included this card info to rule out basic config problems).

======================================================================

----------------------------------------------------------------------
 Raymond - 06-13-06 05:06 
----------------------------------------------------------------------
If you snd-ens1371 is configured as card 2

Please post the output of

cat /proc/asound/card2/codec97#0/ac97#0-0

cat /proc/asound/card2/codec97#0/ac97#0-0+regs

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-01-05 20:32 wood           New Issue                                    
09-01-05 20:32 wood           Distribution              => Modified Redhat 9.0
09-01-05 20:32 wood           Kernel Version            => 2.4.24 self compiled
06-13-06 05:06 Raymond        Note Added: 0010186                          
======================================================================

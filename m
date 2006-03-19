From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001943]: No sound since ~2.6.3
Date: Sun, 19 Mar 2006 16:15:44 +0100
Message-ID: <9e626807b2bd99bb648f71bed0e7da54@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AF0301DC
	for <alsa-devel@alsa-project.org>; Sun, 19 Mar 2006 16:15:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1943> 
======================================================================
Reported By:                hazelsct
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1943
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian etch
Kernel Version:             2.6.8 through 2.6.15-rc5
======================================================================
Date Submitted:             03-19-2006 16:15 CET
Last Modified:              03-19-2006 16:15 CET
======================================================================
Summary:                    No sound since ~2.6.3
Description: 
 Greetings,

Running Debian woody/sarge/etch, the last time sound worked on my Fujitsu
Lifebook P2120 was with 2.6.3 (or maybe 2.6.5, but not with 2.6.8 or
anything since).  Esd doesn't work, nor do system beeps, and GNOME volume
control says no volume control elements are found.  I can get ALSA working
with 2.6.8 on all of my other machines, and with 2.6.15 on all that I have
tried.  alsamixer runs and shows levels which I can change, but still no
sound.

An identical ALSA setup worked with sarge under 2.6.3 but not 2.6.8. Tried
running alsaconf again to no avail.  Under 2.6.3, at least when doing
hardware mute and then un-mute (Fn-F3), un-mute beeps; on newer kernels,
there's no beep.

Now under Debian etch (testing), even 2.6.3 no longer works properly:
sounds played through esd simply repeat the first second or so over and
over again. I keep upgrading the kernel (most recently to 2.6.16-rc5 in
experimental) hoping that this time it will finally work, but it hasn't in
that long...

Debian etch has alsa 1.0.10-3, and lsmod shows the following sound modules
installed:
snd_ali5451 20172 1
snd_ac97_codec 82784 1 snd_ali5451
snd_ac97_bus 2048 1 snd_ac97_codec
soundcore 8672 1 snd
snd_page_alloc 9800 1 snd_pcm

lspci shows:
0000:00:04.0 Multimedia audio controller: ALi Corporation M5451 PCI
AC-Link Controller Audio Device (rev 01)

What other information would help to diagnose/fix this problem?

Thanks,
Adam
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-06 16:15 hazelsct       New Issue                                    
03-19-06 16:15 hazelsct       Distribution              => Debian etch     
03-19-06 16:15 hazelsct       Kernel Version            => 2.6.8 through
2.6.15-rc5
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

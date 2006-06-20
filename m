From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001943]: No sound since ~2.6.3
Date: Tue, 20 Jun 2006 19:58:54 +0200
Message-ID: <200f5adb221bf7fa77e238f28c9b7e52@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 62CD813E
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jun 2006 19:58:54 +0200 (MEST)
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
Last Modified:              06-20-2006 19:58 CEST
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

----------------------------------------------------------------------
 hazelsct - 06-20-06 19:49 
----------------------------------------------------------------------
Now how to close this bug?

----------------------------------------------------------------------
 rlrevell - 06-20-06 19:58 
----------------------------------------------------------------------
Please tell us what you did to solve it and I will close the bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-19-06 16:15 hazelsct       New Issue                                    
03-19-06 16:15 hazelsct       Distribution              => Debian etch     
03-19-06 16:15 hazelsct       Kernel Version            => 2.6.8 through
2.6.15-rc5
06-20-06 00:29 hazelsct       Note Added: 0010322                          
06-20-06 00:33 rlrevell       Note Added: 0010323                          
06-20-06 19:41 tiwai          Note Added: 0010343                          
06-20-06 19:47 hazelsct       Note Added: 0010346                          
06-20-06 19:49 hazelsct       Note Added: 0010348                          
06-20-06 19:58 rlrevell       Note Added: 0010353                          
======================================================================

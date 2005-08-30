From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000502]: Mp3+ crackles when on alsa, not when on oss emulation
Date: Tue, 30 Aug 2005 23:08:26 +0200
Message-ID: <cec20379f782be0e42cbb688fb89d6c4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2C8EF1F1
	for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2005 23:08:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=502> 
======================================================================
Reported By:                hhg
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   502
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake 9.2
Kernel Version:             2.6.8
======================================================================
Date Submitted:             09-15-2004 00:44 CEST
Last Modified:              08-30-2005 23:08 CEST
======================================================================
Summary:                    Mp3+ crackles when on alsa, not when on oss
emulation
Description: 
this shell-cut-and-paste wil ilustrate my problem:

At first when I plug my mp3+ in, it crackles. It is not scraping or
static, it is a distinct pop in the sound about 2-3 times/sec not
rythmical. The card shows up in alsamixer -c1, and everything about
controling it works. Then, without plugging my card in or out, I do this:

[root@localhost hhg]# rmmod snd_usb_audio
[root@localhost hhg]# modprobe audio
[root@localhost hhg]# alsamixer -c1
 
alsamixer: function snd_ctl_open failed for hw:1: No such file or
directory

I also have a boult-in intel-8x0-card working fine with alsa. But now the
mp3+card works great. Using oss-emulated mixer the card can also be
controled. I have to use oss-output, though, as the card no longer is
registrered by alsa.

even if I do

[root@localhost hhg]# modprobe snd-usb-audio

alsamixer -c1 fails and the card stil works as an oss-card.
======================================================================

----------------------------------------------------------------------
 jdthood - 08-30-05 22:37 
----------------------------------------------------------------------
AIUI the user is just showing that OSS works properly whereas ALSA does
not.

----------------------------------------------------------------------
 rlrevell - 08-30-05 23:08 
----------------------------------------------------------------------
OK. My guess is that this is an upstream USB bug fixed in newer kernels.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-04 00:44 hhg            New Issue                                    
09-15-04 00:44 hhg            Distribution              => Mandrake 9.2    
09-15-04 00:44 hhg            Kernel Version            => 2.6.8           
09-15-04 13:09 hhg            Note Added: 0001760                          
08-30-05 12:22 jdthood        Note Added: 0005974                          
08-30-05 20:12 rlrevell       Note Added: 0005980                          
08-30-05 22:37 jdthood        Note Added: 0005982                          
08-30-05 23:08 rlrevell       Note Added: 0005983                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

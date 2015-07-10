From: Dominique Dumont <dod.debian@free.fr>
Subject: [Alsa-user] HBR audio not working with radeon/caicos
	below 60Hz
Date: Fri, 10 Jul 2015 21:10:35 +0200
Message-ID: <1752260.mNcYGhEzEj@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
 by alsa0.perex.cz (Postfix) with ESMTP id A77EE260493
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 21:10:38 +0200 (CEST)
Received: from gandalf.localnet (unknown
 [IPv6:2a01:e34:edf7:4710:226:18ff:fed3:ffc9])
 by smtp2-g21.free.fr (Postfix) with ESMTPS id D83B04B01D5
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 21:10:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello

Unfortunately, I cannot get HBR audio (DTS-HD and dolby TrueHD) on my system 
with all refresh rates. Only 59 and 60 Hz refresh rates are working more or 
less 
properly: there's a dropout every now and then. Refresh rates below that are 
silent: no error is reported by kodi or by the kernel but my yamaha amp does 
not detect the audio stream.

My yamaha amplifier is connected by HDMI to a radeon Caicos card. See [1] for 
the output of alsa-info.sh. DTS, dolby digital and DD-plus are working fine.

This is a known issue [2] for kodi people. A bug [3] was reported on 
freedesktop.org to no avail.

Can this issue be solved by alsa people or is this more an xorg bug ?

Feel free to get back to me if you need more info.

All the best

--
https://github.com/dod38fr/config-model/ -o- http://search.cpan.org/~ddumont/
    http://ddumont.wordpress.com/        -o-   irc: dod at irc.debian.org

[1] http://www.alsa-project.org/db/?f=4c59e10da7600d45ccff18ea0f655e2e97ce9ae6
[2] http://forum.kodi.tv/showthread.php?tid=174854
[3] https://bugs.freedesktop.org/show_bug.cgi?id=75064

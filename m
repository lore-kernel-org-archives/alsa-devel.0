From: Uli <psycho@foex-gaming.com>
Subject: ALSA works, OSS doesnt
Date: Sat, 05 Aug 2006 21:49:07 +0200
Message-ID: <44D4F633.3060302@foex-gaming.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from irc.kuja.in (irc.kuja.in [217.160.180.121])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1FB47173
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 21:49:12 +0200 (MEST)
Received: from [192.168.2.102] (p57A6715C.dip.t-dialin.net [87.166.113.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by irc.kuja.in (Postfix) with ESMTP id D9064256203
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 21:50:39 +0200 (CEST)
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,
since i updated my gentoo box from kernel 2.6.16 to 2.6.17 all apps
using OSS for sound didnt work. Skype pitched the sound, Firefox had
gaps and so on.
I did some git-bisect to find out what broke my sound and got compile
errors...
Here is what i got to:
- ------------------------------------------------------
21a3479a0b606d36fe24093f70a1c27328cec286 is first bad commit
diff-tree 21a3479a0b606d36fe24093f70a1c27328cec286 (from
153abaa4ff0500070a282dd0868367d69388d527)
Author: Jaroslav Kysela <perex@suse.cz>
Date:   Fri Jan 13 09:12:11 2006 +0100

    [ALSA] PCM midlevel & PCM OSS - make procfs & OSS plugin code optional

    Modules: ALSA Core,PCM Midlevel,ALSA<-OSS emulation,USB generic driver

    1) The verbose procfs code for the PCM midlevel and usb audio
       can be removed now (more patches will follow).
       CONFIG_SND_VERBOSE_PROCFS
    2) The PCM OSS plugin system can be also compiled optionaly.
       CONFIG_SND_PCM_OSS_PLUGINS

    Signed-off-by: Jaroslav Kysela <perex@suse.cz>

:040000 040000 de2951ee7fcc2dd79e4b05f9929689e4c236eb66
6b0d7ac583b44b7a86dbd223b4e5b797333ea2eb M	include
:040000 040000 e8a248df599daeb773720babe3b9bd0740e3a813
7c182a880af29f6b19a3ae7479ff1d9ec35f5aa4 M	sound
- ---------------------------------------------
0534ab4279bd25e2d0a888af07466446dac05d74 is first bad commit
diff-tree 0534ab4279bd25e2d0a888af07466446dac05d74 (from
9d83911ac082c6d63c1c08f235349113d8c1d0a3)
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Jan 13 12:09:12 2006 +0100

    [ALSA] Clean up pcm-oss plugins

    Modules: ALSA<-OSS emulation

    Clean up pcm-oss plugin codes.
    Removed dead codes, and simplified route/rate plugins.

    Signed-off-by: Takashi Iwai <tiwai@suse.de>

:040000 040000 a7cf54730a307149c77418ca229bb5604e69ec5e
8f891f51f762d0468b6c59e839b11358be3b0d3a M	sound
- -----------------------------------------------
I'm totaly sure one of this comitts broke the sound because i had some
compile error and copying the whole directory and continued in one with
git bisect bad and in the other with good. So i got two 'solutions' but
i hope at least this can help fix the bug.
If i can do any more for fixing this, just ask.
If this bug is already fixed: I'm sorry, just ignore this mail.

Uli Schlachter
- --
Who is this LAN and why makes he so many partys?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE1PYJABixOSrV998RAj9LAJ9PrpC6OLfW8SoGj7+rl0LF9qLFLwCfSokN
SvDX3vPKYejAak5igLkamTQ=
=pIvA
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

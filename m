From: Christian Kujau <evil@g-house.de>
Subject: ALSA Oops (triggered by xmms)
Date: Fri, 15 Apr 2005 01:22:26 +0200
Message-ID: <425EFB32.2010000@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261646AbVDNXWn@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

howdy,

yesterday i hit an Oops when i tried to play an mp3 with xmms. nothing
unusual. the thing is - i've not changed the kernel (2.6.11-gentoo-r5) for
a while, but changed some (multimedia related) libs on my system. xmms
just segfaults and it all seems to be a proper userspace bug (even xmms
told me so). i really suspect xmms or the changed libs.
but i still believe in the old proverb my grandma used to say: "no
userspace app should make the kernel oops." but yesterday it did:

http://nerdbynature.de/bits/prinz/2.6.11-gentoo-r5/

this is 100% reproducable whenever i use the ALSA sounddriver in xmms.
when i use "mpg321 -o alsa ..." everything is ok.

maybe some guru can shed some light on what's going on in xmms-oops.txt
and tell me who's to bug here :->

thank you,
Christian.
- --
BOFH excuse #289:

Interference between the keyboard and the chair.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXvsy+A7rjkF8z0wRAi5qAKCHXt/BSXHJdiMvYbf6SWnEIuFwkwCgmpmA
jRpOB7REfh99kMVaMdyIniw=
=rSNT
-----END PGP SIGNATURE-----

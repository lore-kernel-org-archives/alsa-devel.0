From: Valdis.Kletnieks@vt.edu
Subject: Re: HDA: no sound [was: mmotm 2010-10-20-15-01
	uploaded]
Date: Thu, 21 Oct 2010 11:22:49 -0400
Message-ID: <13987.1287674569@localhost>
References: <201010202233.o9KMXNoL008303@imap1.linux-foundation.org>
	<4CBFEE94.7020103@gmail.com> <s5hlj5sc7do.wl%tiwai@suse.de>
	<4CBFF25C.2080908@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4232708713515313802=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu
	[128.173.14.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FB9110381F
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 17:22:50 +0200 (CEST)
In-Reply-To: Your message of "Thu, 21 Oct 2010 09:57:16 +0200."
	<4CBFF25C.2080908@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: alsa-devel@alsa-project.org, mm-commits@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

--===============4232708713515313802==
Content-Type: multipart/signed; boundary="==_Exmh_1287674569_10867P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1287674569_10867P
Content-Type: text/plain; charset=us-ascii

On Thu, 21 Oct 2010 09:57:16 +0200, Jiri Slaby said:
> On 10/21/2010 09:49 AM, Takashi Iwai wrote:
> > At Thu, 21 Oct 2010 09:41:08 +0200,
> > Jiri Slaby wrote:
> >> alsa-info:
> >> http://www.alsa-project.org/db/?f=a7a09703bcc8c43386c87a984e513ce35fc91ca4
> > 
> > I see the Front volume is set to zero.  Try to raise it.
> 
> I set all the values to ~ 70 and then tried with pure alsa. It basically
> works.
> 
> BUT, when I run pulse and it suspends the device (or whatever), all the
> levels get down to 0 back again. When I raise it and run mplayer, it
> gets to 0 immediately. If I raise it gets to 0 when mplayer finishes and
> pulse writes 'protocol-native.c: Connection died.'. It never raises
> automatically. And if I raise it during playback, nothing plays at all.

Seeing the same thing on a Dell Latitude E6500, so Jiri isn't hallucinating.

Didn't we have some flustercluck a while back that gave pulseaudio
similar indigestion?  Oh, here it is, it was an fsnotify botch, of all things.

commit 2069601b3f0ea38170d4b509b89f3ca0a373bdc1
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Aug 12 14:23:04 2010 -0700

    Revert "fsnotify: store struct file not struct path"
    
    This reverts commit 3bcf3860a4ff9bbc522820b4b765e65e4deceb3e (and the
    accompanying commit c1e5c954020e "vfs/fsnotify: fsnotify_close can delay
    the final work in fput" that was a horribly ugly hack to make it work at
    all).


Did we manage to revert the revert, or re-break this code? I haven't looked at
this at all in detail.

--==_Exmh_1287674569_10867P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFMwFrJcC3lWbTT17ARAod6AKDdnOPUFFu7YO13PEH3QG6sI6SptQCdElzQ
pUkLCMhqAACJywfXHKKx3wk=
=i9Xc
-----END PGP SIGNATURE-----

--==_Exmh_1287674569_10867P--

--===============4232708713515313802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4232708713515313802==--

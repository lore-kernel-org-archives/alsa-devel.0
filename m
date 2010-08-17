From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Temporary ASoC tree for next
Date: Tue, 17 Aug 2010 10:59:50 +1000
Message-ID: <20100817105950.11fdbb77.sfr@canb.auug.org.au>
References: <20100816163457.GF3276@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__17_Aug_2010_10_59_50_+1000_HpULTVfnyPoPyVXZ"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100816163457.GF3276@rakim.wolfsonmicro.main>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-next@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Signature=_Tue__17_Aug_2010_10_59_50_+1000_HpULTVfnyPoPyVXZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, 16 Aug 2010 17:34:57 +0100 Mark Brown <broonie@opensource.wolfsonmi=
cro.com> wrote:
>
> Liam has recently done some work on ASoC to enhance the ability to work
> with multiple external devices which we're expecting to get in for .37.
> Since this work required some architecture modifications and we've had a
> bit of trouble getting testers we're expecting a higher than average
> degree of cross-tree issues this cycle so in order to avoid affecting
> all other ALSA work we'd like to have a separate ASoC-specific tree in
> -next for this release cycle if possible:
>=20
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git fo=
r-next
>=20
> Please also include Liam as a contact for the tree.

Added from today - called sound-asoc.  I will merge it before the main
sound tree so we see the conflicts in this tree and (hopefully) not in
the main sound tree.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Tue__17_Aug_2010_10_59_50_+1000_HpULTVfnyPoPyVXZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMad8GAAoJEDMEi1NhKgbsKroH/1tOJrCx5iq/or8as/WWYUva
XfMPFBb080HduDbpv3dJEOihrZv0JnU/w86jAPtGh9i9BGQUlQI7GgOklHlXuor2
w2RZFWAA9Bh4EdY6s+KN3JmxYvVkUtNjc1vmHJ8xtCqyixezeWacQwbAq9F7EJjI
H1fLq331XvtcV7O1wm3BdYyBVjKCttCkM1PRRkE4BtLQc/pcULSeeAOsVkneY/Il
WAj42AOs+RK4qCdN8nNxq8b76R7/t/kq3f5pOOXTJszPSkgmppDaAAeB7pcQlm9/
NKqhYkCJ5fdhRwCG37gkE2YLPsjgUilp9LKCBejIycl3cPQ0Zil7u/laEI9lcOA=
=y38v
-----END PGP SIGNATURE-----

--Signature=_Tue__17_Aug_2010_10_59_50_+1000_HpULTVfnyPoPyVXZ--

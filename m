From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.4
Date: Thu, 26 Jan 2012 15:57:39 +0000
Message-ID: <20120126155739.GA19703@opensource.wolfsonmicro.com>
References: <20120124201157.GB1135@opensource.wolfsonmicro.com>
	<s5h39b4n8lw.wl%tiwai@suse.de>
	<20120124204615.GE1135@opensource.wolfsonmicro.com>
	<s5hvco0xhx9.wl%tiwai@suse.de>
	<20120125113508.GC3687@opensource.wolfsonmicro.com>
	<s5hmx9av59g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8895660406219231954=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 16C562438B
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 16:57:42 +0100 (CET)
In-Reply-To: <s5hmx9av59g.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8895660406219231954==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 26, 2012 at 04:43:23PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > That's the tagging - older (and by older I mean "currently released")
> > versions of git can only pull from branches so that's just saying it
> > can't find the tag object.

> It seems that the problem is rather in the server side.
> I updated the git to version 1.7.9.rc2, but it still gives the same
> error at pull.  Meanwhile, I could pull a signed tag from a local
> tree.  Or I'm overlooking something obvious.

I've deleted the tag since.  If you try pulling from

   git://git.kernel.org/pub/scm/kernel/git/broonie/regmap.git topic/patch

it should DTRT (I hope).

> BTW, the pull of a signed tag gives always a merge commit even if it
> can be fast-forwarded.  The --ff option doesn't work, too.
> This is the intended behavior, AFAIK.

> OTOH, we don't want to see too many merge commits in a straight
> development line while the development phase.  So, pulling signed tags
> from you while development might be not always ideal, if we want to
> keep the sound git trees better in sync.

I'm not sure it's much of an issue, but I guess it's not a big deal.
I'd prefer to use the signed tags for the fixes if that's OK, but I'll
omit them for development branches.  Or hold back on pushing to you so
often or something (we're integration testing via -next after all).

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPIXfiAAoJEBus8iNuMP3d04kP/AsEemGNH4E4pITqhFrfD/J7
PVdJwA8D55Y6qcMzB04jFQ9Ora6xs0+3rPcLgSyFF3/75WO3ZlfQwLw7VKDm9SQg
iz7EmYxvtnnH+GNCzDNF2RUfxE1djnZtU7qT8kP7hoNIlYJ+QU2fzc+Io4+bqAPY
XOdoQDcDGo3G2klVtgn1YkJqkVMsntvsH/VXHK5cNB2D2iLgPGY5PUtpVyl45Dn1
0ScWjpE9n+ZiA1Wvf94MV9pbTDrZjn/2xTK0O/qWAD5NgCioRYxHoMX1sPKfWXB/
TTs7Jed7TSEr+hR7/YiZQ0wxOmSRxzKVzfcbblE1jB80opGi8k46UD05MIbSd01G
mLD9lgg67MeAr8uxG6shTEJFDXimr1no4DWLge9cnsL6H+U6Qs8xwkCxJCdwCmQQ
4NYS0m43EO10J9x6zKzyE6bvKVknvik8husACokaprPW3mWlo8cXbJo/mMHI9vBG
DEyW3aAyCFPEUWulhsVhDhFPNnfJ+vwEpXsE+yEDwDJFVwXlfZ7zU1OR1aGwhDEk
V8p+aSYt1Kuc+paFA28DyNHw35lk7mZ5JhIFKDeHLm3aSVcrFV/y67MstLhfpl69
rh/zEx6pJ0Rzo3sWW/uZU4HLPFAkncGnuhmpKRskD4/5AhoJNzkTatAUtBaNQoAk
jOP8Ys1Mh/GEeX76580r
=R0nH
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

--===============8895660406219231954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8895660406219231954==--

From: Mark Brown <broonie@kernel.org>
Subject: Re: Missing return check of of_property_read_*()
Date: Wed, 9 Sep 2015 16:33:49 +0100
Message-ID: <20150909153349.GA20922@sirena.org.uk>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk>
 <s5hh9n3d4bk.wl-tiwai@suse.de> <55F04AA1.3030607@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1922459663585172936=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C6B0C260662
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 17:34:01 +0200 (CEST)
In-Reply-To: <55F04AA1.3030607@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1922459663585172936==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 09, 2015 at 05:05:05PM +0200, Lars-Peter Clausen wrote:
> On 09/09/2015 05:01 PM, Takashi Iwai wrote:

> > There is nothing special in config or compiler option, just use the
> > normal x86-64 build with CONFIG_COMPILE_TEST.  I'm using gcc-5.1.1 for
> > now.

> I think you'll get them for any config with CONFIG_OF disabled. I've been
> seeing those warnings for a while now when compile-testing for x86 and I'm
> still on gcc 4.9.

Oh, right - that'll be the issue, nobody build tests those
configurations as standard, all the builders are all*config or
configurations that don't include ASoC.  I'd assume the Intel people are
seeing these in their testing but otherwise everyone is going to be
using DT and not seeing warnings.

> But even if you don't get the warning the code is still broken, the compiler
> just does not know.

Sure, I'm not questioning that there's an issue but rather why nobody
else had seen the warnings.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8FFcAAoJECTWi3JdVIfQKaUH/3CjbDrZMFmiSLjGo6+TNP2w
twJXq9z5X/TV6zBgo/GnHZpFQc+GE8O1OiQXQUrcwgWAmNGbFTrpm7SZxo6Hsk9+
/KvyJLQOmSzh+r92V8t6wzH+6j1IU4ay9tyCAI3a4P5XDq9C/SvkgW6QIlwXcBnZ
K4ioltUtb8dyW8amJJCN32Znx1knl5LIsyaY86drTttQbI3iDU/QSLSwZP3YmFiV
TNHZsTUpNOueL9/vaVLYnyhCthLZ44zrItModsC2TnRBg9GWT7rO+R5shHxiU8q4
Uetc0OvbDmXeoiP6x9hBBgZZuMjQTYru1eEAbNJGXGkFE3XAmhFwg8gu5OXU9hs=
=vspu
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

--===============1922459663585172936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1922459663585172936==--

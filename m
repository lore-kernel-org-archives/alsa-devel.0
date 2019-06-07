From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 146/146] ASoC: soc-core: remove legacy
 style dai_link
Date: Fri, 7 Jun 2019 12:18:54 +0100
Message-ID: <20190607111854.GF2456@sirena.org.uk>
References: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
 <87lfyfe4r3.wl-kuninori.morimoto.gx@renesas.com>
 <3BD9CEE4EBD5E74B98FE2D277EB60E0B3900FE91@IRSMSX104.ger.corp.intel.com>
 <c0d5fa8a-ae0d-6d3c-b4a5-7010640683b8@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2825456607391510002=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 513AFF80709
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 13:18:59 +0200 (CEST)
In-Reply-To: <c0d5fa8a-ae0d-6d3c-b4a5-7010640683b8@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "Rojewski, Cezary" <cezary.rojewski@intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2825456607391510002==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I5PYSK0R2Sa5XBHe"
Content-Disposition: inline


--I5PYSK0R2Sa5XBHe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2019 at 02:08:50PM -0500, Pierre-Louis Bossart wrote:
> Please don't top-post.
>=20
> On 6/6/19 1:25 PM, Rojewski, Cezary wrote:
> > Hmm, guess reviewing 001 proved redundant after all. Unless I got it wr=
ong, you are removing code implemented in that very patch (the 001).

> > Any chance for eliminating ping-pong effect and doing the "right" chang=
es from the get-go? Especially the renames are confusing here (s/cleanup_pl=
atform/cleanup_legacy/) if you intend to remove them soon after.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Using a ping-pong analogy for a 146-patch series is pushing it. It's first
> make then break to avoid bisect issues. And the names match what is used =
in
> the existing code. maybe the naming isn't to your liking but it's what has
> been used for a while.

> Note that the last patch is going to break all the non-upstream machine
> drivers so you will have quite a bit of work to do on your own when you
> rebase.

Right, avoiding build breaks is important here - it helps future
bisectability if we don't have commits (and especially long serieses of
commits) that just randomly fail to build.  That's *way* more useful
than dropping the initial patch would've been.

> > If there is no other way around it and solution is accepted, a note, pe=
rhaps in 001 would be helpful for future readers.

There's no guarantee that a patch series will be applied at once, if
there's a problem part way through the series the earlier bits might get
applied to save future review.

--I5PYSK0R2Sa5XBHe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz6SB0ACgkQJNaLcl1U
h9A/kAf/YElb9Yj5Sf0ThOQKW0/byzPpMRLDjxf5MCnX0ixINTG1Gji/JRzX5M9g
iBkz3cnypcIOtZNcXfxjYy+LJewpNFXRLPdl62sNaNJyC7wyh9fnBBGtuiSLep3J
zAX20LvO4nVJKTZoqMqkDZiP6TsS3FpkYLbZynrj9ahGJRIQ0s+h9jtnLv2sQQ+U
hZlNFhDGBdfWZ2ZaS/6XnrlQVCeDYXC57kI5CfLDNvfZybKYHZTOqFOVPxAmhK1Q
tdUEBZVuo0yQ0FbrhzVHm7b+pGCoec0hquRiECOgzcSobvLz/R+mQ75HmovxfUUz
bNpl61jA7HW91adAIZ1cSuJMpjLDVQ==
=3adO
-----END PGP SIGNATURE-----

--I5PYSK0R2Sa5XBHe--

--===============2825456607391510002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2825456607391510002==--

From: Mark Brown <broonie@kernel.org>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Mon, 11 Aug 2014 19:26:21 +0100
Message-ID: <20140811182621.GI17528@sirena.org.uk>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <20140811153342.GE17528@sirena.org.uk>
 <CAKON4OyxjSL4ziaJGdGXhVXGVoL9M4qq9qdtYYuGz_hnCA3muA@mail.gmail.com>
 <20140811171133.GG17528@sirena.org.uk>
 <CAKON4OyyPhH9=kRRxkmFJGcvzWTBdZ2_d449FCAzE+6jy5XFKg@mail.gmail.com>
 <20140811181922.GH17528@sirena.org.uk>
 <CAKON4OwYLc_2KSC7oGB=KU1SYHS_1udkCz9td0OsSx8iC1-wjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4341051962706028761=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D31FC261684
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 20:26:26 +0200 (CEST)
In-Reply-To: <CAKON4OwYLc_2KSC7oGB=KU1SYHS_1udkCz9td0OsSx8iC1-wjw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============4341051962706028761==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B+rOXCo5y3P4mzNn"
Content-Disposition: inline


--B+rOXCo5y3P4mzNn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 11, 2014 at 02:24:31PM -0400, jonsmirl@gmail.com wrote:
> On Mon, Aug 11, 2014 at 2:19 PM, Mark Brown <broonie@kernel.org> wrote:

> > That really doesn't solve the problem - consider reparenting for
> > example.

> Maybe it is time to get rid of setsysclk and use the clk
> infrastructure? With the clk stuff the order is known by walking the
> clk dependency chain.

> In my case both sgtl5000 and Allwinner I2S are using clk. But there is
> no mechanism for telling ASOC to use this chain to figure out the
> ordering.

The clock API is not available on all architectures and it *still*
doesn't solve the parenting problems I've repeatedly mentioned.

--B+rOXCo5y3P4mzNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6QrKAAoJELSic+t+oim9AlMP/jMNwDSADiNb+R2r0m+umdYD
wmvBNFu6geiS6ZpjzEUBMTIZ1pVP0nQcFuNlZV7eAcXIN/42ezHPEGocB7Lm8A3q
114JJmaousu5wV71DmuO5xShc1l0adbu/JX/DETYGsSyc+p+dYOBRwkb35bm0oiy
M7b7v2fE/+t76dUxxtrJFOnb8vWooZWbvAJVyuStWjbZ/raw2Ps3XaPVUjW+f1zH
KJ2EI2YxRyQiLxBYevnqqjytB4s0NfDJNxmsBirr9MWYfvJtyJ15WiHO85MJVbQp
y45uy2K8FE7qKt23Lz+kfDynEruZ1HtUEMZ2hvrnzeyK6pvImHnm/2GgCwBXepCi
6oDveFb8ruAUlY+QHXBwh4hISC+tRBmRTGQYR0bpLsPyvJwaBRteMd8GrwCz/TMM
uXveB/3RZnxe8t1AYsWgy4Dz7kay10rNFrWopFRx1PurJrS4sny2n/ra9uu41p6E
EOQjz5oQOyoSRFLj1K117AWdgRpnw8q6VAUfnd1GSOX0esCY/3Hl7Jrey/9sCZMu
xR8+SFA0SfBEi/aNkmd4cmkvJgR6t3hKsfdlBfdIxdskiZwtvfyQkAIgSVt+o20N
wlF1gMwss+c876RSIsVYN/xUf6AT90T73b74EqMwEkKg5RIdrZfMxN0MiEkEcObG
NW3G2ISoP4nCqDS2oV53
=mqvt
-----END PGP SIGNATURE-----

--B+rOXCo5y3P4mzNn--

--===============4341051962706028761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4341051962706028761==--

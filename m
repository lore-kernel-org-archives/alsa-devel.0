From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/6] ASoC: sun4i-i2s: Add slot width
	override
Date: Mon, 12 Mar 2018 11:20:30 -0700
Message-ID: <20180312182030.GN2186@sirena.org.uk>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-2-codekipper@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6837123339736015011=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 835A8266E63
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 19:20:37 +0100 (CET)
In-Reply-To: <20180312155753.9478-2-codekipper@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: codekipper@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, be17068@iperbole.bo.it, linux-sunxi@googlegroups.com, maxime.ripard@free-electrons.com, wens@csie.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6837123339736015011==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VnOTrGv5LmZxna7m"
Content-Disposition: inline


--VnOTrGv5LmZxna7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 12, 2018 at 04:57:48PM +0100, codekipper@gmail.com wrote:

> Some codecs require a different amount of a bit clocks per frame
> than what is calculated by using the sample width. Use a slot
> width override property to provide this mechanism.

If this is a CODEC requirement we should really be working this out from
the CODEC rather than adding a DT property on the I2S controller, or at
the very least putting this in the machine drivers.  The generic drivers
already have support for mclk-fs and there's an operation set_bclk_ratio()=
=20
for them to use though we don't have a DT binding for that yet.

--VnOTrGv5LmZxna7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqmxO4ACgkQJNaLcl1U
h9CVtQf/Vxp7jVhu8gdF97IjSkSeLrpYv7gpjDD1Lx4CwA4nX0ZHIQrGbRH1vVQj
isw+xD96BY3zQAw6lBMsVhK94R/dWoAHafA35gjxE3Vfgi3YGncCw5SMV3u812K6
71vRpptZnUaCIRIPl44ulKrjboHC7/4QAk6FwtJPs/yFin3dKz9yMpYULryiFqR0
uXxVCVYbTRwFlCG38AEALoP6K3kRYt2OriNxENykHWp+iBiAtoSIIYfEKSjkW2t4
BRkSRZG/fEQ5Us6NpdebeLwbP3xp7N2iX50pMy2olUgL+MItMa2pIQz5ngl9w9IQ
ItZSuQWb5BubZ1lJwkcUZo4Z2ZEPVg==
=jGrF
-----END PGP SIGNATURE-----

--VnOTrGv5LmZxna7m--

--===============6837123339736015011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6837123339736015011==--

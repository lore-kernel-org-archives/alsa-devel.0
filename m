From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_esai: Check the return value
 from clk_prepare_enable()
Date: Tue, 11 Feb 2014 12:54:47 +0000
Message-ID: <20140211125447.GP13533@sirena.org.uk>
References: <1392055288-20148-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5009236322100814903=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C977264F19
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 13:54:52 +0100 (CET)
In-Reply-To: <1392055288-20148-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============5009236322100814903==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bvgsfYmVhxWy/2TA"
Content-Disposition: inline


--bvgsfYmVhxWy/2TA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2014 at 04:01:28PM -0200, Fabio Estevam wrote:
> clk_prepare_enable() may fail, so let's check its return value and propagate it
> in the case of error.

Applied, thanks.

--bvgsfYmVhxWy/2TA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+h2UAAoJELSic+t+oim9UvgP/2YZ2UTQ2zwg9RmFfeBYIAtD
LEIa4B4EGZt6cU1cvI9WtzEC27VTmKuOazrZixk/5vj0yxBxB0JxGzKdNDFMuWUG
BYLIEroUqMQQjMbOwvfQVHA6oAMJIiXeG8g+e00Wh2o2IF53GkzQnJnxSxmU7NYp
nRz2iPW3sh/ARpCQntG78N12mRk57l/xIsGqMzaFKRBEqdjIZKa8O2T7D6vZ3uc1
f1p0qeNEaoC9lR1SjSr9idQlnK30OhR4Uz7QRzVUjbWbJSsYlK5fOJ/WIjHd0U4n
EEvOlG9i9djOL6gzj737xmDT00LiC8ZucPO8jnSRAc2tCAVG7q5uNiBefMugl13B
cs9r8asRzGtZYp3Wa54/udPNEDvzcp2jYs47L8Wcg8/Kvy5p3Kz+BfxYsp36fRmy
46PtMhOI8+2mD6jgh8R9BZVO9EtSDGx83sLZbSWeXoEdpcY22AOKl/gs+Ewh92D9
z1fJ/CKcw/x+d8pHJaHn5rCM2vGfBDlmJM8X56CKat+CklVwGX6MBNIr9bUsO9y4
pM2ryZ0jFS3DzbHr0cXNSN4f6uUywD2PySg29Xz39TfifYryHx7XNUfsZzht68Ak
cyvXkW8vl1+QbDl72uJJlnFuNtkUg0u3USeI/zZm5A4+aQpn10JyqT6DPcUBi72S
ZJCbECmunbiB++2S7Bok
=r6Eq
-----END PGP SIGNATURE-----

--bvgsfYmVhxWy/2TA--

--===============5009236322100814903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5009236322100814903==--

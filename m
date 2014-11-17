From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pxa: prepare/unprepare clocks in
	pxa-ssp
Date: Mon, 17 Nov 2014 11:01:17 +0000
Message-ID: <20141117110117.GW2722@sirena.org.uk>
References: <1416081106-28324-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0762591215015349223=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57857261615
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 12:02:28 +0100 (CET)
In-Reply-To: <1416081106-28324-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============0762591215015349223==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WjpOG6URjntW8FAF"
Content-Disposition: inline


--WjpOG6URjntW8FAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 15, 2014 at 10:51:46PM +0300, Dmitry Eremin-Solenikov wrote:
> Change clk_enable/disable() calls to clk_prepare_enable() and
> clk_disable_unrepapre().

Applied, thanks.

--WjpOG6URjntW8FAF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUadV8AAoJECTWi3JdVIfQZbMH/RpkDPyQvWPUEyR3R8HJ1Kau
f07wa3VA0H7h4CoehU5kSnqQ2fef86A7ax79mYvGdaNIFeiuPdW9Ym/Si+8v/x10
KqDl13Wf9WlyD3jBaGYMOR2HRae1H8NdDMA3XaX/lQbHo/F7nFcy2r0aa+K65Xv0
KE0Mjg5MakY6yq6eiSdCSF9WrnB/owhcifnGvInJuWd9vdKYXFD/SKWIxiHa+keU
0k2EdFctUgo0qKglBU3eo/R8FRpdgF8xWFHpBBs18AlJY1ldmvk8TZL+ppqP1UZd
G/vQyfOzhbFMIj5kIOI9d6mvW1TMQG3KcNIlx3JKmZRqdqVoNNTSYTe9ibvB5WQ=
=r/GK
-----END PGP SIGNATURE-----

--WjpOG6URjntW8FAF--

--===============0762591215015349223==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0762591215015349223==--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
 cleanup
Date: Wed, 29 Mar 2017 12:47:52 +0100
Message-ID: <20170329114752.bpfzkkvbvan3ayn5@sirena.org.uk>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
 <20170328092103.GQ6986@localhost.localdomain>
 <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
 <20170328115306.GR6986@localhost.localdomain>
 <20170328152457.2j5zaxdbdavpuspa@sirena.org.uk>
 <CAEnQRZCiaCfzQRDo-3UupH8fv9BttZBVVXo63FdnrdqG49F1GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0109458536559378399=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B9E2266EFF
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:48:04 +0200 (CEST)
In-Reply-To: <CAEnQRZCiaCfzQRDo-3UupH8fv9BttZBVVXo63FdnrdqG49F1GQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, fabio.estevam@nxp.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org


--===============0109458536559378399==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vspbhsb2mi47wgbn"
Content-Disposition: inline


--vspbhsb2mi47wgbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 29, 2017 at 02:38:23PM +0300, Daniel Baluta wrote:

> If I read the code correctly, both machine and codec driver are doing:

> * codec_clk = clk_get(...)

> I guess that the codec driver is the first to be loaded and it will call:

> * __clk_create_clk

> which will do the allocation. Then when machine driver is loaded, it
> will only take a reference to the allocated clock.

> I might be very wrong on this. Can you clarify what does moving allocation
> of the clock into codec driver implies? Machine driver only needs a reference
> to codec_clk to just get the clock's rate.

Oh, so the CODEC is already requesting the clock.  Then what I'm saying
is work out a way to use the handle to the clock that the CODEC driver
created.  In effect the machine driver is telling the CODEC driver to do
things with the input clock.

--vspbhsb2mi47wgbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljbnucACgkQJNaLcl1U
h9DZ6Qf/VAZ2sbMrBxYzJO/3l4uqg/RdBeUQQm5/uC4DM6Uj72lVsDAUJS77YYyH
yhBBXX3B95rDnksxd0rJIC6sVlay6XG7wFG85D+Fuz+ZgzOtcQYKS5zEN6+RW17i
O2FXmmylr+1+ewxqgdtRqS3ix82wY96+Z1Q+YJlrR7RzcAJQjHss/yILbbOULe4v
ox5tI7G5F09NgKkNRslL6RhywqA8l5iT43HWSKwOJMxdKU7xYlPeS+BomZ+ME08e
7Og7Loz/cjumAAJEnr1FKHE2/WG1ku6uOHlcyfYPA/RfPnjBoxLDyJrd+H3DW0ln
C/FcExTx1UZPsmTj2gkLSMqp4gxcBw==
=9xKi
-----END PGP SIGNATURE-----

--vspbhsb2mi47wgbn--

--===============0109458536559378399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0109458536559378399==--

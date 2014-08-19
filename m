From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/13] ASoC: Componentization: Unified
	probe/remove path
Date: Tue, 19 Aug 2014 11:01:32 -0500
Message-ID: <20140819160132.GH24407@sirena.org.uk>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3439120844770943399=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19F86261600
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 18:01:43 +0200 (CEST)
In-Reply-To: <1408456290-13945-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3439120844770943399==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 19, 2014 at 03:51:17PM +0200, Lars-Peter Clausen wrote:
> This patch-set starts with consolidating the probe and remove paths of
> snd_soc_codec and snd_soc_platform drivers. Once that has been done it uses the
> new generic paths to also add probe and remove support to snd_soc_component

Applied all, thanks.

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT83TTAAoJELSic+t+oim9B8EP/3x0wDE0vaLUpm4liWKtRcj+
dWzFGahwPJ0R6bCtXJknshV6jPIC2kgkH39ec8LW+xzxCBVqBWsRiQoUUuTIJ3L0
58yqkPAQRblGxH8PLJcHWUDp6DZI0LcqXfdriKx4vivLwcNUayQtjhYcvKkTOt5W
BbGcIrTpt3njyZ1HczTrtu4fye5EYKcA3biAA3LmHLhWKb1cxQ9IlyjuS3235Nui
ee/gt9rz94jom28qC+0JOzcFy65Cbpse0rNmyzj+UeJPYjCoW9QqUQGpmEkrxRBy
l/hZmhZOe21KIESFSj89qJAyRKrf/Mv/8Gw+/C35mBo1GkxKeBakZKpcNUn7Bp1m
ix/cQz3RrkvT2VbwLV5x7pcfyZQS6ytY4o//ZBCmsdM3iOixY+/IFxFdgDhbCrYX
tgVV6zhQWFe3SKuWMxw4NPPYrjA8fbJIsyT11CB2FBFtiaCEmS/UV8Q3X3Yt7QSZ
nuY8aOhOenmTqDkQlDIY8IJJMb2PyigSf8bBUFPyQ+iUMyC4l6w90gxThloQ5q/a
MUHV4L2g3VDpuAzXh6gSQ17kvA0FQnCa065nVgHBYL/7XYzzyGjEdIrizPStkiI+
KSRJJLFOahUCcWtQLMJEL9ppZbb/6/s+eqEKkwiXMPQa9tLcfoJECbPW7EnsiujP
u8/RxLoNJ4CK3/TsF5T9
=wttQ
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--

--===============3439120844770943399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3439120844770943399==--

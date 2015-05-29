From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: codec register dump in debugfs
Date: Fri, 29 May 2015 10:04:40 +0100
Message-ID: <20150529090440.GH21577@sirena.org.uk>
References: <55681268.1050508@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5273990724783995700=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AAA7F260492
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 11:04:50 +0200 (CEST)
In-Reply-To: <55681268.1050508@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5273990724783995700==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JjcuUTh8vXoLXC5Z"
Content-Disposition: inline


--JjcuUTh8vXoLXC5Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 09:16:56AM +0200, Sergej Sawazki wrote:

> I'm writing a ASoC machine driver. The board has two wm8741 codecs.
> I would like to see the codec register dumps in debugfs.

Use the regmap debugfs interface for devices that use regmap.  The ASoC
level one will be removed once all drivers are converted to regmap.

--JjcuUTh8vXoLXC5Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJVaCunAAoJECTWi3JdVIfQMSUH+K8+ivqvfnxMp1ZLPU2upzAt
TIPJBnNSRMO4AHgunbiXuNw0T6flKZauf0vdl0tiGSASFj4mkZf5s7z6uz09+NlK
BOH+JxOpSHMsS68WDlgXDvQ+7a6pogyNC96xwFKUrD3jj0/Y7Kd9qxfleUVrO6n4
SeDzu50WtgAXkTy6u8IZ1qu5sx6dHBuDtHRMvElmwVCesMqXhQ3RBRnl8+IbpE8h
5wmV+yppG7wB3L59V/r8TDgoCZae6DL5nqPeyi+JIh8ZtmQtIPPPzDAN1AtPEyu5
k5RdVYuUOrWwKK+ri/3Dz51Vt8croIz7ynrzNOhOw9U6IyHvFyeADULClr9xbg==
=iTBP
-----END PGP SIGNATURE-----

--JjcuUTh8vXoLXC5Z--

--===============5273990724783995700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5273990724783995700==--

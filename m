From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs35l32: prevent unexpected parse
 result of device tree
Date: Tue, 15 Mar 2016 14:30:35 +0000
Message-ID: <20160315143035.GO2566@sirena.org.uk>
References: <1458043574-6078-1-git-send-email-o-takashi@sakamocchi.jp>
 <1458043574-6078-2-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8013576428143831180=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (unknown [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BE07265475
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 15:31:03 +0100 (CET)
In-Reply-To: <1458043574-6078-2-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8013576428143831180==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0lsrIB+s628ok5gC"
Content-Disposition: inline


--0lsrIB+s628ok5gC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 15, 2016 at 09:06:14PM +0900, Takashi Sakamoto wrote:
> When device tree blob has no node properties requested by callers,
> of_property_read_u32() returns minus value, then given argument is
> not changed.

This is probably fixed by a recent patch, please check with current code.

Please don't send cover latters for single patches, if they're needed
they indicate that you need to improve the commit log for the change.

--0lsrIB+s628ok5gC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6ByKAAoJECTWi3JdVIfQSgYH/00O/RInmlVAVYWzOSDBnWsF
uBAKPMjPWQo+zorK70GxBoidRawZjs2o2ffzZom9lQSEtMm5AFkwm+IFFeXG4KRJ
nVsja1CotnsqRPwJCblJLN2DtbeNbuyCcw0cA2AOJFOTO/AdWi71RT1tDSbYB/PU
BeaUecz+vYaeHzORN1QX3nF07PwOfRC/7eOG0xxybzpHEbb3Afi8HbyD04afFx/a
2gqsD91u7tzXVAoUTBJrTjpmNZ412Ew+Ou0Cu3UzrRWSFMXBpSYLV3UW6TLrowcd
/6/mRzhpUw/x5V/J5XK8K/2RLQS1c5oB4nBUK6n1adJhMNdE0RJkW8qPlh1pAAg=
=naZG
-----END PGP SIGNATURE-----

--0lsrIB+s628ok5gC--

--===============8013576428143831180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8013576428143831180==--

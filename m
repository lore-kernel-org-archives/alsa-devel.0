From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Add support for DAI and
	machine kcontrols.
Date: Mon, 6 Feb 2012 13:27:46 +0000
Message-ID: <20120206132746.GH3070@opensource.wolfsonmicro.com>
References: <1328290989-14399-1-git-send-email-lrg@ti.com>
	<20120203204640.GD23505@opensource.wolfsonmicro.com>
	<1328524623.6799.9.camel@odin>
	<20120206110939.GC3070@opensource.wolfsonmicro.com>
	<1328531118.6799.13.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5415282300374779826=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B644E103AD4
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 14:27:48 +0100 (CET)
In-Reply-To: <1328531118.6799.13.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5415282300374779826==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2012 at 12:25:18PM +0000, Liam Girdwood wrote:

> sound/soc/mid-x86/mfld_machine.c:238:	ret_val = snd_soc_add_codec_controls(codec, mfld_snd_controls,

This looks bogus - looks like the missing fanout mux support which we
should really fix properly.

> sound/soc/omap/ams-delta.c:575:	ret = snd_soc_add_codec_controls(codec, ams_delta_audio_controls,

This one is more fun and probably reasonable for now, though it is about
the only example of a properly working baseband in mainline.

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPL9VLAAoJEBus8iNuMP3dOl8P/17rMZugnRW92Q/D2V65dFnu
mxhKWPB5/AvzM/ngfr6bwpicO1N8bb4VimGgVZgU4rSmwvexg9NaerhZxl/MRQSm
NLbhar2lcxAQiOA8eRwPponhmVa6Ax3merC4FkRCSuEmcAsTGuVabAjCLUODHWTd
atBOctW//m9/mf8ZEGZbenu2k+2RVnEWI6OD3xm27XMOaU4BmRHtYwiiw+DQ0AFS
o/36LtiN6416gtAW/eLafYhncwoQ2erG2UwEcwAZbtte24iGKV2lN1lxbGdl7wc1
RklSSGYw6nR2C44okc5ht38Ln0oSM2ptNmRWx1VPyOZd0WPa9DVKBXfeEV6PoKNv
S2uXu3F1ke2W5M7EkzoTlZrvNIwezOJysqUsvZ7Tp+JoS8U+FMF1M9AzBfPfzz5F
3iq1GFmcv+Pw2Hc9MhA/NoBN2Oy0hLRiS5AtUgbF877z7UiImVLA+jBQRPdeUzms
yK+hmCbwFFbSoCCir8r3tNAj7CLPoLLfSVgyGHdxxBCdxGS71QEjyrDhclzlq5Ho
yHnjVxxyVlOJIhZgVAfZeV+DS/mKoFCjAwofF1xQdMJhi5R8XIVXVJRywL/yX9Xb
q65vJNJ1z1AuNBCuy/bsuukYIGSKV26two9zQQrPJt6/FTLvYjfvQbzrVRW6H8yn
f+NtTqxLGa99cJ3qSr81
=BlWL
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--

--===============5415282300374779826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5415282300374779826==--

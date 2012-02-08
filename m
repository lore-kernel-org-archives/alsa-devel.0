From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: Integrate control based jack
 reporting with core jack reporting
Date: Wed, 8 Feb 2012 11:46:42 +0000
Message-ID: <20120208114642.GG3120@opensource.wolfsonmicro.com>
References: <1328644128-32630-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1328644128-32630-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F323405.8080902@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2608722730924907013=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D847B103DCD
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 12:46:44 +0100 (CET)
In-Reply-To: <4F323405.8080902@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============2608722730924907013==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Content-Disposition: inline


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2012 at 09:36:21AM +0100, David Henningsson wrote:
> On 02/07/2012 08:48 PM, Mark Brown wrote:

> I'd like these to match the names currently used in HDA, like this:

> 	{ SW_MICROPHONE_INSERT, "Mic" },

It seems odd to abbreviate this and nothing else but I'm not that
fussed either way.

> 	{ SW_LINEOUT_INSERT, "Line-Out" },
> 	{ SW_VIDEOOUT_INSERT, "Video-Out" },

For these it's really not normal English to hyphenate them, it looks
strange to do so.

> 	{ SW_LINEIN_INSERT, "Line" },

It seems odd and a bit undescriptive to not specify the description here
when it is specified for the outputs?

> Actually, it matters less if we settle on the standard you set
> above, or what the HDA currently does, as long as the names are the
> same.

Except for Mic where I don't mind either way I'd rather bring the HDA
names into (but note that the idea is to remove the HDA specific jack
controls - I think these names are used in other places though?).

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMmCbAAoJEBus8iNuMP3dAI4P/1+GpFzoubsp2i89mkxQ2PCr
vyOfgRz5BfIiOvVIQcR5pqw1BxJOJJRAJ2dzH7nt2/Aqy7D+3n35qFCx2KZ0EIEZ
NPW2whKY1iXeL1IVzHlwpsUBGegDtqxxbBhvhEcXZ0x/JtMgTxBj8ZHEF+n8xqMo
CM45Qt0boIy2YOpo3oBdhOnDfiWWgXy9FQtkTunzJugheyyaQNEWJf417Cg5JPbC
fegZL90DLHBbuHHPDoBUrU0ijoKtTseRVun/HwrSU2Qke93B383Z2650CcN5wjUf
89fMJdvkMyEVeI3/hzevVFvekhfaRXonyx2hVkvQMaeCN4+AjUv/tocgSC7SCMqG
eKqkISHa24+ShXr7/yTF8g5qNJTcIC/I8vaIYxm2F2zFFro0V8PkMcb3wdgddYmN
vENPD9l39ZqZq4YRSH+NndSww6RBNzRipGA+iB+Px63/xS33qcqbDru16OFuSxsy
XZCCF21prbkQYTc59q+roMJtINwH3tqOfjqQu6jJq2CrSy7uW0dIg/PBSTVC8Jav
Cm3dyVel0de6BUEmwh3qD0jcy0rk1eiLikDxuQnGfMd1XUNEbWvCfsdSGx6jl9jH
jh4lfm+j4EDpK6+wzRLain2KD/iBQbyOklaZmyPvVX9Tcih2LrYnkRmVIEcEfYs3
EAiesXx7y2mXTL9aLwJw
=gqvd
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--

--===============2608722730924907013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2608722730924907013==--

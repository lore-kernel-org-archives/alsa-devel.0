From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs-ac97: make selectable in
	config
Date: Thu, 14 May 2015 20:10:31 +0100
Message-ID: <20150514191031.GS2761@sirena.org.uk>
References: <554E8634.2010008@maciej.szmigiero.name>
 <20150512175807.GL3066@sirena.org.uk>
 <5553BAB4.3040209@maciej.szmigiero.name>
 <20150514175351.GQ2761@sirena.org.uk> <5554ED71.4040608@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5249144592237757191=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A4962605A1
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2015 21:10:46 +0200 (CEST)
In-Reply-To: <5554ED71.4040608@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Bard Liao <bardliao@realtek.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5249144592237757191==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fCjW77bNSYaih4x3"
Content-Disposition: inline


--fCjW77bNSYaih4x3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2015 at 08:46:09PM +0200, Lars-Peter Clausen wrote:
> On 05/14/2015 07:53 PM, Mark Brown wrote:

> >select doesn't respect dependencies, it'll just force on the selected
> >symbol.

> The patch works fine, neither SND_SOC_AC97_BUS nor the symbols selected by
> SND_SOC_AC97_BUS have any dependencies.

Does the select from SND_SOC_AC97_BUS actually happen if it is selected
by SND_SOC_ALL_CODECS?  That's the issue, if it works now it's a
relatively recent thing.

--fCjW77bNSYaih4x3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVVPMnAAoJECTWi3JdVIfQt7UH/2QB42+b17u+mDyLz6wscekP
tmN0E+OPyhYWQIgKyhialNjGZV3AAu72lP0Ic4VAj3CdnSg24fsYq//IK4VeERts
G1JvK6zU/41OWILHqsyZgoWXJyHBa56VV3y+dtxy8NOqVKRSX2njtpP5IxqvgNj+
wH3ZM8romS5/NxM5/Q88bkHWu8JDL5rq9003ZR5ZOux/BEEtqAHVNfGUbvDy68vO
aOzM+cXdJ3muLknuyc0DCZhdO81FhXBPcWxJrm5a+Gyf2g9GB5Uqr/3XS4/yWULO
bl/i0rGi9vjIV7MPS1eSipkaiUYY0UA0s7Y2FxuRIqDoT6Bf7SuPpWQo4UykTL4=
=MWq6
-----END PGP SIGNATURE-----

--fCjW77bNSYaih4x3--

--===============5249144592237757191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5249144592237757191==--

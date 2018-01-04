From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: rt5645: change micbias widget
	type to supply.
Date: Thu, 4 Jan 2018 10:53:43 +0000
Message-ID: <20180104105343.GA10774@sirena.org.uk>
References: <20180102185314.17189-1-hdegoede@redhat.com>
 <20180102185314.17189-2-hdegoede@redhat.com>
 <20180103105053.GA5603@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D702756F3C@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0156001099348840632=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F21052677F1
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 11:53:50 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D702756F3C@RTITMBSV02.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Hans de Goede <hdegoede@redhat.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Koro Chen =?utf-8?B?KOmZs+aAnee/sCk=?= <koro.chen@mediatek.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============0156001099348840632==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 04, 2018 at 07:19:15AM +0000, Bard Liao wrote:

> I found mt8173 from mediatek is using rt5650 micbias.
> 	{"Headset Mic", NULL, "micbias1"},
> 	{"Headset Mic", NULL, "micbias2"},
> I think we should remove it but still need to verify.
> We are co-working with MTK folks on it and it may take some days.

That looks like normal supply usage for a micbias so most likely your
patch is a fix for them anyway.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpOB7UACgkQJNaLcl1U
h9AXyggAg9DViiuj2vmK5kzZb9ZdxQwr0bhNvlHAmNGVeGLCzvhqHJn/ucQ8eqoF
2zldoJXmcnShe74ArlBcncSmNAczYCjd8VxmBk44EFvSpbSqiDIbCAkp68CnVh1H
dUYYnM6WuMk6BZuIwL9FnK2YCbJNsgYFeJKBLMTYo+4ryXcHENRAlIJms4l84c4A
kSQ1IZJX1Gs1IJdqogTj7S/EuUoQmYBZW2T15MOa1i+J5nCiMh0J9XZZIiaciikW
M0SU+4W51m3QXp973wf0apNE6zkuIKtMKvxZFoJ9aK/LJVZ6k2RdpGAdDuy81W06
OA2IBSaZT2tzUZ/HTg6S9Dh0OxzMrw==
=tESt
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

--===============0156001099348840632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0156001099348840632==--

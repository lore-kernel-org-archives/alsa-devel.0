From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: rt5645: change micbias widget
	type to supply.
Date: Thu, 4 Jan 2018 12:01:26 +0000
Message-ID: <20180104120125.GD10774@sirena.org.uk>
References: <20180102185314.17189-1-hdegoede@redhat.com>
 <20180102185314.17189-2-hdegoede@redhat.com>
 <20180103105053.GA5603@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D702756F3C@RTITMBSV02.realtek.com.tw>
 <20180104105343.GA10774@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7027574B8@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2326068799752672433=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CE9526782A
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 13:01:39 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7027574B8@RTITMBSV02.realtek.com.tw>
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


--===============2326068799752672433==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 04, 2018 at 11:14:40AM +0000, Bard Liao wrote:

> > > I found mt8173 from mediatek is using rt5650 micbias.
> > > 	{"Headset Mic", NULL, "micbias1"},
> > > 	{"Headset Mic", NULL, "micbias2"},
> > > I think we should remove it but still need to verify.
> > > We are co-working with MTK folks on it and it may take some days.

> > That looks like normal supply usage for a micbias so most likely your
> > patch is a fix for them anyway.

> Yes, it's supply usage for a micbias. So it didn't take effect with
> MICBIAS widget type. Actually, we don't need to set the micbias
> power bit for headset mic and we have verified it today. So, I will
> send a patch to remove them soon.

Are you sure that's likely to be helpful?

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpOF5UACgkQJNaLcl1U
h9A5kgf/SqT0UPPvNYIYIK83jUxsaTkXSdsP573xEtSkMLzkrdLKs0hnDcHPEZFd
5ce+3rTtGhhCLYC0SzUlRUQkuwyreuJFHbH3cMRf3k9U1L2RAwYPHToIDCJUGx12
Vx8Uydw5CVEp2fAUHN3SLRsFP3Ok6+oM6JyaNAn3CKPtRmLtiyI1rvCi4SnGL7km
qVeaCIc2W/gc0kVf+9FGlL9K+n131iVwphgZuhso/jljm7eWw6+vN2CZahiKXqoj
yM0H6DIbeKxKGayXIcqnsFrUsu9B6w10caezGWTLhknC/2hTj0jbU6LBIDHXrIkz
tzXsaaBY2ItUVcmW5b1jOqIa4rXTjg==
=rn7L
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--

--===============2326068799752672433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2326068799752672433==--

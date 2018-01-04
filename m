From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: rt5645: change micbias widget
	type to supply.
Date: Thu, 4 Jan 2018 12:41:44 +0000
Message-ID: <20180104124144.GG10774@sirena.org.uk>
References: <20180102185314.17189-1-hdegoede@redhat.com>
 <20180102185314.17189-2-hdegoede@redhat.com>
 <20180103105053.GA5603@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D702756F3C@RTITMBSV02.realtek.com.tw>
 <20180104105343.GA10774@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7027574B8@RTITMBSV02.realtek.com.tw>
 <20180104120125.GD10774@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D702757599@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7840793392076797702=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FEDF26782A
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 13:41:49 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D702757599@RTITMBSV02.realtek.com.tw>
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


--===============7840793392076797702==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 04, 2018 at 12:20:06PM +0000, Bard Liao wrote:

> > > Yes, it's supply usage for a micbias. So it didn't take effect with
> > > MICBIAS widget type. Actually, we don't need to set the micbias
> > > power bit for headset mic and we have verified it today. So, I will
> > > send a patch to remove them soon.

> > Are you sure that's likely to be helpful?

> Yes, I checked the register dump and the micbias power bits are
> not set. The register settings will be the same if we remove it,
> and it is verified. On the other hand, the micbias power bits will
> be set and the micbias_event will be invoked after we convert the
> micbias widget type to SUPPLY if we don't remove it.

But are you sure that this was working properly for the Mediatek systems
previously and your and Hans' patches don't actually fix a bug for them
too?  If that's the case then removing the supply hookup would cause a
bug for them.

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpOIQcACgkQJNaLcl1U
h9Cn6wf8CBV6rrATw/Gg+R+G+gl69Zq0dZ1+vO5dLiBa3suDTQGS4Rwfn0036VgS
RNbJfFRCerOUtIoY8nTpobdGe3R7m9Bv1ulMYPT0QlJR2M61RUuMWJXYPK/GC0tZ
OXIGWWz9uiXuigCeRugFCmboy9OS5mj7CFPxXdplgNeIgBCsnju+7ywXZwqJ9DMf
wl67uZ5VTXMuhgvmiU1NxQ7bp6JUUt+M8t/bf/ccY+d6y8NYlMOjnddsnBV3eqID
IHjA7FxrRK2+v15TLNeLTDUA6pb+guEo1C9PGgfrLE/Sj407HyqaYf7yUPdpdKTH
S0axw3pTqeuQ1y9GSg8ZLrKxDe65cA==
=Ws14
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--

--===============7840793392076797702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7840793392076797702==--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: da7219: read fmw property to get
 mclk for non-dts systems
Date: Thu, 3 May 2018 10:39:19 +0900
Message-ID: <20180503013919.GN2714@sirena.org.uk>
References: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
 <20180501205006.GE2714@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337014C1E9782@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7270691707633314716=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C4C33266C1C
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 03:39:26 +0200 (CEST)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1E9782@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============7270691707633314716==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MSd2ShuMixI0uVaZ"
Content-Disposition: inline


--MSd2ShuMixI0uVaZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 02, 2018 at 10:13:55AM +0000, Adam Thomson wrote:
> On 01 May 2018 21:50, Mark Brown wrote:

> > There's a lot of things that ACPI *should* do but doesn't - it's a bit
> > of a shambles how ACPI standards get defined and what's there is not
> > really intended to handle systems like these semi-embedded ones.  One of
> > the big gaps in ACPI is that it has no handling at all of clocks, that's
> > supposed to be done transparently by firmware in the ACPI model.  What a
> > lot of the embedded Intel people have been doing is coopting the DT
> > bindings wholesale for ACPI systems but that has problems when you get
> > into areas which should be handled in some way on ACPI systems like
> > power and unfortunately clocks are kind of power adjacent so might be a
> > bit sketchy here.

> Yes I was aware that previously that was the case, although have not followed
> this for a while. It just feels here that we should aim for something more
> generic rather than a device specific property/binding, if possible, as that
> feels messy to me and I'm sure other drivers could take advantage of this as
> well. I've not looked at the clock code in too much detail though, at least with
> regards to this area, so not sure how feasible that is.

> As a suggestion for ACPI would it be possible to re-use the 'clock-names'
> property and add something in the framework to handle this?

I completely agree that ACPI should have handling for clocks but it
really feels like something that should be done as a proper spec rather
than just ad hoc by Linux like the x86 embedded people often do - it's
too close to the power management stuff that ACPI definitely does
handle.

--MSd2ShuMixI0uVaZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrqaEYACgkQJNaLcl1U
h9DjEwf/akcOq3FX7OJHawOodNuod6nfkVvTE5kWue1W5AVdzCXlsTknOiOkIn1z
pEPHEJ1G56wzcFt4ezga+5DkIYnB1RNzxCdC0noLuFEQNSegwJ7oskOQUaAwRTgd
2FlNUEi2pmEpP7A4bU6EonrIkhrC1zN5MHgmh4VjfBXpbVKEPvbxeTMDr1X8b2I2
sXXGMNDAn76mlG0xiEskLThHEpqyAFbxjBQIIBGmbgpjRIJJWg87WXT/0aLTBAEn
WzUK8iaNFiPeIqYNFH3drHquTqSHwZyXdhZwifT6m2hpK+UfHXTcEQNtf+6jbkEF
D1KA6ISg0/rcMVBzr40DQpx1qvCunA==
=nEHY
-----END PGP SIGNATURE-----

--MSd2ShuMixI0uVaZ--

--===============7270691707633314716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7270691707633314716==--

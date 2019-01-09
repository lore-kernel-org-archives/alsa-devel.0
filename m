From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: Intel: sst: Missing IRQ at index 5 on BYT-T
	device
Date: Wed, 9 Jan 2019 21:14:56 +0000
Message-ID: <20190109211456.GV10405@sirena.org.uk>
References: <20181216185429.GA20408@gerhold.net>
 <e82d5720-3c73-3dff-1b31-dae9a0b09408@redhat.com>
 <20181217180330.GA845@gerhold.net>
 <20190109192241.GN10405@sirena.org.uk>
 <235ba68c-1a43-6c9e-3bbb-6872dd39a036@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0047492108025618320=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7191C26743A
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 22:14:58 +0100 (CET)
In-Reply-To: <235ba68c-1a43-6c9e-3bbb-6872dd39a036@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Stephan Gerhold <stephan@gerhold.net>
List-Id: alsa-devel@alsa-project.org


--===============0047492108025618320==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wfgmFf0LjPE7xkRl"
Content-Disposition: inline


--wfgmFf0LjPE7xkRl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 09, 2019 at 03:10:53PM -0600, Pierre-Louis Bossart wrote:
> On 1/9/19 1:22 PM, Mark Brown wrote:

> > This thread appears to have died without a conclusion I can see?  I
> > don't have strong feelings here, it seems like it's a choice between
> > different evils so people working on the platform should make the call.

> this was fixed by the v2 patch applied on January 4?

> [alsa-devel] Applied "ASoC: Intel: sst: Fallback to BYT-CR if IRQ 5 is
> missing" to the asoc tree

That's entirely possible, the subject line did change so I didn't
immediately notice it was the same quirk.

--wfgmFf0LjPE7xkRl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2ZE8ACgkQJNaLcl1U
h9CPqgf/Q16R8fDJyEdZdhXcX+2eQe7JXBTLQJXq8BgLb+KEtjQLwLfKx1yTflSZ
xWZJpODK1/uV8C1SA6XyGKOGd3imUlpM1VNpucvrqCL65o5KHTksE4Wj127wvDUk
Br2LxQzShqX6wrc16K0zGB0kWwSrKbQu6yAFGlMhJMFeW2Hx6oRFbqbf1fSYxKzV
TU8gB8tDcBHWhjXhm7Ri8mXz5zchFWeV6ECUqW/Bj7OOyZEDuLF0C+Vt61S1TPlJ
IRHRaw4vnG93Qv70MhkDmPxFJdFgI13i6ZcyIMfwUe67tqi1SwZFTONyPhDdW4H5
+KqB48oU9f08E66GAQDP5L95kse5CA==
=Albr
-----END PGP SIGNATURE-----

--wfgmFf0LjPE7xkRl--

--===============0047492108025618320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0047492108025618320==--

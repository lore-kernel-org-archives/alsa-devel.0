From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm8580: Fix build error
Date: Fri, 24 Jan 2014 12:16:38 +0000
Message-ID: <20140124121638.GW11727@sirena.org.uk>
References: <1390552765-32210-1-git-send-email-sachin.kamat@linaro.org>
 <20140124111035.GS11727@sirena.org.uk>
 <CAK9yfHy6kW3ZnS9Pz29h=8nxdX0sMLP-R-SpPVfF7131EjEs7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2571349969046194691=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E53532616F1
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 13:16:47 +0100 (CET)
In-Reply-To: <CAK9yfHy6kW3ZnS9Pz29h=8nxdX0sMLP-R-SpPVfF7131EjEs7w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Patch Tracking <patches@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============2571349969046194691==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="doUn1Hmx68n+7ij2"
Content-Disposition: inline


--doUn1Hmx68n+7ij2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2014 at 05:22:35PM +0530, Sachin Kamat wrote:
> On 24 January 2014 16:40, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Jan 24, 2014 at 02:09:24PM +0530, Sachin Kamat wrote:

> >> +#if IS_ENABLED(CONFIG_I2C)
> >> +static const char *wm8580_supply_names[WM8580_NUM_SUPPLIES] = {
> >> +     "AVDD",
> >> +     "DVDD",
> >> +     "PVDD",
> >> +};

> > This is obviously not sensible - the device doesn't suddenly stop
> > needing power if it is using SPI.

> This structure is being used only in wm8580_i2c_probe which is guarded
> by IS_ENABLED(CONFIG_I2C).
> Do you mean the existing implementation is wrong or we just need to
> move it out of the #if?

Think about what the code is doing - obviously there is a problem with
the existing code here but this is not a good fix for it.  Like I say
it's not very likely that the device only requires power when used with
I2C, it would be better to fix the fact that the driver is only using
regulators for I2C.

--doUn1Hmx68n+7ij2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4lmjAAoJELSic+t+oim9C24QAJePei/mCAjuSAFDYbg4PNwd
SbA+L92S5oQAGBQLwlowAHST3AjDOyfwM7o/XqcgQcLRYQEsUhnWNTORpuikZ99/
yP5vFHqrh31/78rNDEf7OTXNTmDNdKSAVPVWOcbBmCQPVDQY62yVaq22JECF9jgs
MIxpkcNP/fE3N9Dh2k/PSwKgnjQbPCe4TkiPUw8hbWtvN4GTCtzUYaoNd2gVzBxq
zFztIsjyvOUAsVoRou8tiwjz6BqaWmPwccHmp7FEu7kiUC02kBOeV4MCBqgTdKJ5
qmV/PRMFAAqLAVP7NjxTEWh+UTjP3HgRpx3aIplabg/IWL97XIWxPe0uI9mdGkaG
FTh5NUU3/8nUHMW5pU49Jkk92X7YNgniz3+4IVFCBs9FEm1P4ScWGxqdLZXCYr6v
0aksEVDh2SNEKl5as9aYD2fOxZSc9TZ9KPHJe5QZJIEbjC1vPPQmX7Qg8qUlPqNk
swQp35DZ8KovJ8XzeYymWRy7C8ioWuNBmhQY5TAz+qVktxo1ywoaxCDac52tZKoE
tRQsFKl4DLkS3OErGeV5qmPoeg+bTW3/YGLzl9TwL7xATWwf2UoNWQJhRlt0NUIu
yOBOsW8rte1rTvfS6kc8nZOT3DkeoCNEuFZgr276f2AFVNEcQH2UBK1Zi6I2etA6
hklb7Hup6GU//RRh2f3f
=AaBi
-----END PGP SIGNATURE-----

--doUn1Hmx68n+7ij2--

--===============2571349969046194691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2571349969046194691==--

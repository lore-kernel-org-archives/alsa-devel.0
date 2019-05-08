From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Add support for Conexant CX2072X
	CODEC
Date: Wed, 8 May 2019 17:59:53 +0900
Message-ID: <20190508085953.GF14916@sirena.org.uk>
References: <20190427175938.GJ14916@sirena.org.uk>
 <s5h36lxpcbd.wl-tiwai@suse.de>
 <20190503064729.GF14916@sirena.org.uk>
 <s5hk1f8m2f1.wl-tiwai@suse.de>
 <20190506042625.GK14916@sirena.org.uk>
 <s5hsgtr6h5y.wl-tiwai@suse.de>
 <20190506140506.GQ14916@sirena.org.uk>
 <s5h4l674n9g.wl-tiwai@suse.de>
 <20190508081006.GZ14916@sirena.org.uk>
 <s5hk1f1nyyh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9077892183590915916=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C7F0F807B5
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 11:00:01 +0200 (CEST)
In-Reply-To: <s5hk1f1nyyh.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============9077892183590915916==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="siaTt5BtGpUbPgBZ"
Content-Disposition: inline


--siaTt5BtGpUbPgBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 10:16:06AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > The GPIO/IRQ equivalence thing should just be a purely Linux internal
> > thing - looking at the driver it appears that there's no need to look at
> > the GPIO status, Linux can tell if something is plugged in purely by
> > reading the chip registers so the jack status function could directly be
> > the interrupt handler.

> But it can't see the button status or detect the headset type without
> reading the codec's magic registers...  So some help from the codec
> side is required, and the irq handler isn't in the codec side because

The whole thing should be in the CODEC side.

> there is no i2c irq assigned but only ACPI gpio, as far as I checked.

You can map through an ACPI GPIO to an interrupt without worrying about
the fact that it's mapped as a GPIO in ACPI IIRC - if you can't there's
lots of other drivers are going to have issues.

--siaTt5BtGpUbPgBZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSmogACgkQJNaLcl1U
h9Cxmwf9E//0XZbVYq6CQrhljPmCtuPy+/5jOA+n4/M/Iqi+Pi8k3a/jpZCjVRd7
PHhaifIvqtsNN19tw3t7I+8DF2l8Yp8QifwOg/E74VuXtOKvy0Uss6jIsl3nCKPG
+ppEq0C6i/viaUMNcIccJWbIEAQ5mNhD3Qw9Qqq6lbnwXttysudjNlz0zkwmEZOK
TWS+O9s/bUTXzdI76A02OddVdPcyYSwUTtgysIUX5Kuo0nnejxzlXAR0DcDev8b3
9Thk3RR2HmA9SpDv/lrv69xX0kF7z8vh4oGQqcBtZOa8OPgtWr6kSY6m2P5o0nbG
yGD5idGqpaHpu5LYaUWfXH0YaDEWZw==
=UCPA
-----END PGP SIGNATURE-----

--siaTt5BtGpUbPgBZ--

--===============9077892183590915916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9077892183590915916==--

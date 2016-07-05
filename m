From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 3/4] ASoC: mediatek: add BT implementation
Date: Tue, 5 Jul 2016 10:12:32 +0200
Message-ID: <20160705081232.GL6247@sirena.org.uk>
References: <1467629788-14411-1-git-send-email-garlic.tseng@mediatek.com>
 <1467629788-14411-4-git-send-email-garlic.tseng@mediatek.com>
 <20160704144406.GH6247@sirena.org.uk>
 <1467683533.4212.16.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j5abB2DrWbqmv6QP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467683533.4212.16.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Garlic Tseng <garlic.tseng@mediatek.com>
Cc: tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, koro.chen@mediatek.com, PC.Liao@mediatek.com, ir.lian@mediatek.com
List-Id: alsa-devel@alsa-project.org


--j5abB2DrWbqmv6QP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 05, 2016 at 09:52:13AM +0800, Garlic Tseng wrote:
> On Mon, 2016-07-04 at 16:44 +0200, Mark Brown wrote:

> > We really shouldn't be writing the registers or other internal data of
> > the device.  Instead we should be getting the driver for the relevant
> > hardware component to do it.  If we just write to registers that makes
> > the interoperation with the real driver for the device more fragile than
> > it should be, people might update the main driver without noticing the
> > external driver.

> The AUDIO_TOP_CON4 is a reg of the ASoC hw module. All the registers
> which are set in the btmrg operator belong to ASoC hardware. The reg
> writing you mention above is to power up the MRG interface in the ASoC
> module.

The problem is that this is the machine driver, not a driver for the
chip that's being controlled.

--j5abB2DrWbqmv6QP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXe2vvAAoJECTWi3JdVIfQ5qsH/RaA11ZXK3IffV7aONXWE5z+
h1emJa6Y1j7Yw8iHd2HuU0uJKeRBMXXrnPE5+YZzHhA4uA7gj63Lqq4RzDnJ0dnN
aYnwBXWsAnzEuQPhGaY2GLlN42+UOJwRzd43DuFQ2DOys589Vogy8Yl7wvOF/YR0
KUuJ3tyAxjIRn24zcvOxkcgTi+5LlP2GeVomA/URqGBf5am1AZ37cOAw0PXHsCTx
rZIUOKq9qO41gkz7LwmvT4y9XKHj6ilPdeUz/s6KjAguwPSOA4MGRyrIEKxp5O+L
MVD8zWOVNjCUs1593blK7TRs0kuzdXRFUimykenjozXLpz4VkM5xjh8FdmB74aM=
=SNd4
-----END PGP SIGNATURE-----

--j5abB2DrWbqmv6QP--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] Applied "ASoC: topology: Fix logical inversion in
 set_link_hw_format()" to the asoc tree
Date: Tue, 27 Feb 2018 15:57:58 +0000
Message-ID: <20180227155758.GD11822@sirena.org.uk>
References: <E1eqGmV-0005Rk-Jt@debutante>
 <20180226183407.22335-1-k.marinushkin@gmail.com>
 <e25d592b-0fab-68f8-d9e0-e5061c54f4e0@linux.intel.com>
 <20180227103848.GA11822@sirena.org.uk>
 <a5bdbfc8-6abd-6757-6afd-68e27d6a9697@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a5bdbfc8-6abd-6757-6afd-68e27d6a9697@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>, alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 27, 2018 at 07:13:17AM -0800, Pierre-Louis Bossart wrote:
> On 2/27/18 2:38 AM, Mark Brown wrote:
> > On Mon, Feb 26, 2018 at 06:30:15PM -0800, Pierre-Louis Bossart wrote:

> > > This issue was found during the development of SOF (Sound Open Firmware)
> > > where we get the reverse of the intended behavior when using the same
> > > conventions in topology files as in machine drivers.

> > Is this perhaps something that the earlier firmware is handling inside
> > the firmware?

> For SKL+ the SSP settings come from binary blobs read from ACPI/NHLT tables
> so I am wondering if this inversion is compensated for in the tools used to
> generate the blobs.

Ugh, I'm confused here.  Is this a case of SoF differing from the
regular firmware somehow - presumably the stuff coming from the NHLT
table is the same for both firmwares?

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqVgAYACgkQJNaLcl1U
h9B6ZAf9G02T/l9HTS4GS8EgC0IrNBxcgF3e9c5Eb5QTxn1kfZlS0Ew3G0e0JJi2
Q4/q+lxwzVDhlPkL1SL0Jtq4eDHycnRxfYi7t6zGAR5QLab8bYHFZ7XNOor2DHKh
A7hEaqtAVkGy0lp5FMMdZ07FDvjFjeB2HWzZ24ak1MPFenvNCBHQjL8aO4iUEEk3
NMiGeWO7Wc9L4QUDs8k6o0I5daqG6K8aDwpQRwHgSNIuKoYbuXntYGLloHNgltaT
KHjnAi7JBAWO4YvmzPt5DmGqp8cfakE8kzj8GDlKiyoS8dw52iS9YyKCPPRZLC4G
ttCOfcNCNQMilfov9Pn+aE3hI5/VJQ==
=B9eR
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--

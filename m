From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/9] ASoC: hda: Add helper to read/write to
	dsp mmio space
Date: Mon, 20 Apr 2015 22:46:38 +0100
Message-ID: <20150420214638.GX14892@sirena.org.uk>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5376623534435512343=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B75C2654FC
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 23:46:43 +0200 (CEST)
In-Reply-To: <1429276567-29007-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5376623534435512343==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ngiTnHdmUEG79yp6"
Content-Disposition: inline


--ngiTnHdmUEG79yp6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 17, 2015 at 06:45:59PM +0530, Vinod Koul wrote:

> +u8 ssth_readb_traced(struct ssth_lib *dsp, u32 offset)
> +{
> +	u8 val;
> +
> +	val = readb((dsp)->mmio_base + offset);
> +	dev_dbg(dsp->dev, "readb offset=%#x val=%#x\n", offset, val);
> +
> +	return val;
> +}

Much of this looks like a MMIO regmap, there's the memcpy() bits too
which aren't but otherwise...

--ngiTnHdmUEG79yp6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNXO+AAoJECTWi3JdVIfQ3AsH/iTupIitsKW0n2f89f/EWqOn
r3hoEW1shPm1EMmo4KoVDpqPFLbcC7tsWeI2Yc7n3nv0IhMIRW8lHEgAejwUREma
iDNBhoATwBibt0PuNzYkO/pO+n68tcxSvKYfdHs9jnoVWsYgBs7rxZfmVcjkOYOW
GT2BditmYCsY8Jjk08y1yPeZwt+mhFfMZ+kDw8ovyX6kPCZ6cn3NOVdmH8CDM8wU
Dqq8y1/NFl7AQuKKRf7KALdVmD88IiIPuv33G034cMaCDrvLwZsmz58uLKT0tuR/
tccj4N//wuPWtFBkh9DPhLfZfr/5SLU2KA9dxfYLxOW2JbOXytPtTMHIhDR1X0A=
=ugrU
-----END PGP SIGNATURE-----

--ngiTnHdmUEG79yp6--

--===============5376623534435512343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5376623534435512343==--

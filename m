From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: Intel: Skylake: Add DSP firmware
 manifest parsing
Date: Fri, 13 May 2016 13:14:17 +0100
Message-ID: <20160513121417.GL22038@sirena.org.uk>
References: <1463140547-20895-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8917393954366364932=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5548C260564
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 14:14:33 +0200 (CEST)
In-Reply-To: <1463140547-20895-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8917393954366364932==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m+jEI8cDoTn6Mu9E"
Content-Disposition: inline


--m+jEI8cDoTn6Mu9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 13, 2016 at 05:25:47PM +0530, Vinod Koul wrote:

> +	/* Get the FW pointer to derive ADSP header */
> +	buf = ctx->fw->data;

> +	adsp_hdr = (struct adsp_fw_hdr *)(buf + SKL_ADSP_FW_BIN_HDR_OFFSET);

> +	mod_entry = (struct adsp_module_entry *)
> +		(buf + SKL_ADSP_FW_BIN_HDR_OFFSET + adsp_hdr->header_len);

What if we somehow managed to end up with a zero length firmware (or
something smaller than these headers)?

> +		/*
> +		 * we check if current pointer is larger than file size from
> +		 * base value to check excceding the file while parsing
> +		 */
> +		if ((const char *)mod_entry >= buf + ctx->fw->size) {
> +			dev_err(ctx->dev,
> +				"Exceeds file bound: Entry %d Ptr %p\n",
> +				i, mod_entry);
> +
> +			return -EIO;
> +		}

This checks the start of the entry but it still lets us read beyond the
end of the file.

--m+jEI8cDoTn6Mu9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNcUYAAoJECTWi3JdVIfQq2wH/0hqGyr/j31oe+urPDZagO98
bTlaOOgEZl3xc8953ln6wURjX30/vpVSjm7BU3/kua+qp2yoOcN5bIe9agsy0TGA
kWPkPCIGaCHciC1TJeiHje+0ozUtB46MySO4PomAq5NkjJZP8FbvwAtqto5pyP37
0ZLoGHsuqVfcbFndd0W6NVBJNsxey3XN3dWPFJD9zanbI15eP5bfNm0m+ZomkkRx
BoaqRSe5CA+f9ySe7XDpj1TA5F0I3QaAFndWLxC+EMGEHhrCbXbXjE3OLvU+/2Gh
Lho16ZdkNilEeH7S0dsb0+WMxWu24BUVN8KDzzeMLxycqNob2utWtDuGaDRBDSg=
=nKAl
-----END PGP SIGNATURE-----

--m+jEI8cDoTn6Mu9E--

--===============8917393954366364932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8917393954366364932==--

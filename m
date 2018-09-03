From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 04/12] ASoC: SOF: Add support for IPC IO
 between DSP and Host
Date: Mon, 3 Sep 2018 16:53:00 +0100
Message-ID: <20180903155300.GQ10302@sirena.org.uk>
References: <20180831151910.16122-1-liam.r.girdwood@linux.intel.com>
 <20180831151910.16122-5-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8905773413583443906=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DE79267668
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 17:53:01 +0200 (CEST)
In-Reply-To: <20180831151910.16122-5-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8905773413583443906==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="glwmnIOgU1tcuP7N"
Content-Disposition: inline


--glwmnIOgU1tcuP7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 04:19:02PM +0100, Liam Girdwood wrote:

> +/* SSP Configuration Request - SOF_IPC_DAI_SSP_CONFIG */
> +struct sof_ipc_dai_ssp_params {

> +	/* MCLK */
> +	uint32_t mclk_direction;
> +	uint32_t mclk_keep_active;
> +	uint32_t bclk_keep_active;
> +	uint32_t fs_keep_active;

Is this assuming a 1:1 relationship between the serial port and the
MCLK?  That's not going to be true for all systems.  This definition
does feel a bit specific to the SSP (or I guess just general serial
ports used for audio as opposed to fixed function I2S/PCM controllers).
I don't know if it's worth splitting up though.

> +	uint16_t frame_pulse_width;
> +	uint32_t quirks; // FIXME: is 32 bits enough ?

Better go for 640K to be sure :) ...

> +/* HDA Configuration Request - SOF_IPC_DAI_HDA_CONFIG */
> +struct sof_ipc_dai_hda_params {
> +	struct sof_ipc_hdr hdr;
> +	/* TODO */
> +} __attribute__((packed));

...more seriously I do notice a bunch of these FIXME and TODO comments
in here, given that it's an ABI it seems like those all need sorting
before things are merged.  In this case perhaps just delete the HDA
stuff until someone works out what to do?

--glwmnIOgU1tcuP7N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNWNsACgkQJNaLcl1U
h9Bhwwf6A/5DEuQDlKtZB1AD6hXDeMWY0owQ2/xePZuE3qN9EIMMI/GCc8wJCsQF
17COq7Ou4VyeJXAct/dNgnUfDTACsv7D1QnGeQfS2oo4k7cUbaroo4PMSQYc7i9G
H4GNYkcZB1PCTwXFSZxNCi6ObVEKqbW3lnUflUcvkCKPwMr+TPKeOMjAdpVprHrd
tfGTIQEWtazT1LWCT4cUsC/6CnTlEPDpt5qWKSBvhGAhjARCrcErpr8t6fQ3mUcz
YjqWAf4VVGbEAjACOPIUKtPrGGz1NYxmaCUIpnAc2olYetb4+4495SUZaR8GPY36
+iD5dyuzaEPhVLyIzJKkGfLDlnBlUA==
=TSpQ
-----END PGP SIGNATURE-----

--glwmnIOgU1tcuP7N--

--===============8905773413583443906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8905773413583443906==--

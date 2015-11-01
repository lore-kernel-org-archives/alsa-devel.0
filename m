From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/6] ASoC: hdac-hdmi: Add hdmi driver
Date: Sun, 1 Nov 2015 12:02:31 +0900
Message-ID: <20151101030231.GB17819@sirena.org.uk>
References: <1445931737-30393-1-git-send-email-vinod.koul@intel.com>
 <1445931737-30393-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3454716098090650887=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83F66260708
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 09:54:02 +0100 (CET)
In-Reply-To: <1445931737-30393-3-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Yakir Yang <ykk@rock-chips.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3454716098090650887==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2015 at 04:42:13PM +0900, Vinod Koul wrote:

> +	if (err < 0)
> +		dev_err(&hdac->dev, "Failed to query pcm params for nid: %d\n", cvt->nid);

That looks like the NID is being printed as an error code.

> +	/*
> +	 * Currently on board only 1 pin and 1 converter enabled for
> +	 * simplification, more will be added eventually
> +	 * So using fixed map for dai_id:pin:cvt
> +	 */
> +	return hdac_hdmi_init_dai_map(edev, &hdmi->dai_map[0], hdmi->pin_nid[0],
> +			hdmi->cvt_nid[0], 0);

I'm not entirely sure I understand what this is all doing.  It looks
like it's trying to translate the HDA widget map into a DAPM map which
seems sensible but it appears it's making some simplifying assumptions
about the device it's dealing with?

> +static const struct hda_device_id hdmi_list[] = {
> +	HDA_CODEC_EXT_ENTRY(0x80862809, 0x100000, "Skylake HDMI", 0),
> +	{}
> +};

Which is plausible since it's a driver for a specific HDA CODEC.

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWNYDGAAoJECTWi3JdVIfQjz4H/30T+m5wO5YNiacsZFWY7U/A
m4+zUqd6HOeBhdWdRDBZorPXNhDVcgkmGnYvFsb6cXLQJ9mCvI4brIrrXVQq90c5
1wZc761dYnXZDc/vPezaM+Ky/uFNfnGDuGT6hbjb8gWLMoYawwJUm7fuYBPK00Ft
NOyTTj76fGlnuz40UT1E6AhkDClAwafeA1FUk4soF05fjtrnigO2V3lJ23yfwr8H
vPXH5zjFcwCzPx3MtqrBhrMAPNfdI+EC1PZfXKMsdm8CUIrTLhJhR7d1z2UqTByk
qcg6Wzpdc+tzOesrT1mTAXoEnixH8T+GUUGskVFYUFPJLXhQl8njWNkl4Wmo0qI=
=bVtd
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--

--===============3454716098090650887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3454716098090650887==--

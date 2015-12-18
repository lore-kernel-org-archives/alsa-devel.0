From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/13] ASoC: AMD: add AMD ASoC ACP 2.x DMA driver
Date: Fri, 18 Dec 2015 12:04:08 +0000
Message-ID: <20151218120408.GA5727@sirena.org.uk>
References: <1449272440-8735-1-git-send-email-alexander.deucher@amd.com>
 <1449272440-8735-11-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1153347975=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1449272440-8735-11-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, Alex Deucher <alexander.deucher@amd.com>, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============1153347975==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eOZ5LUtYRk41oVSR"
Content-Disposition: inline


--eOZ5LUtYRk41oVSR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 04, 2015 at 06:40:38PM -0500, Alex Deucher wrote:

> +static irqreturn_t dma_irq_handler(int irq, void *arg)
> +{
> +	u16 dscr_idx;
> +	u32 intr_flag;
> +
> +	int priority_level = 0;
> +	struct device *dev = arg;
> +
> +	struct audio_drv_data *irq_data;
> +	void __iomem *acp_mmio;
> +
> +	irq_data = dev_get_drvdata(dev);
> +	acp_mmio = irq_data->acp_mmio;
> +
> +	intr_flag = acp_get_intr_flag(acp_mmio);
> +
> +	if ((intr_flag & BIT(ACP_TO_I2S_DMA_CH_NUM)) != 0) {

> +	if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {

> +	if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
> +		snd_pcm_period_elapsed(irq_data->capture_stream);
> +		acp_ext_stat_clear_dmaioc(acp_mmio, ACP_TO_SYSRAM_CH_NUM);
> +	}
> +
> +	return IRQ_HANDLED;

What if none of those flags were set?

> +		mul = (dscr == PLAYBACK_START_DMA_DESCR_CH13) ? 0 : 1;
> +		pos =  (mul * period_bytes);

Please just write normal if statements, they're a lot more legible than
the ternery operator.

> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			acp_dma_start(rtd->acp_mmio,
> +						SYSRAM_TO_ACP_CH_NUM, false);
> +			while (acp_reg_read(rtd->acp_mmio, mmACP_DMA_CH_STS) &
> +						BIT(SYSRAM_TO_ACP_CH_NUM))
> +				cpu_relax();

This needs a timeout in case things go wrong, otherwise we lock up.

--eOZ5LUtYRk41oVSR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWc/Y3AAoJECTWi3JdVIfQj/IH/A6eNg96AGIYke1h5eXuk7bs
QFt/buOc6RhBttXM1M1tB2staiLzvfIxdsUlKJkavPUa1FuVN1smy4xl0MLrqpbI
1JmnBB/GRE4CuHxbWFON/kNYOIhzCzUThlPMut8lkjuchxr1VLhG3Cpp8REuKdlp
z+ZxSXN7FjODjW+OefE6Zet4v3aUYSn8/ekSbw2Py+tMszx75aguk1wlbCHRofvw
D1ImEseaOVPY+vmUz/TXBIxnw5QLfigOPEMZfrbCxKPSvXX2Gkdlh0ejR7Bx1FuL
t0pKk3zv/fm1ElUmUU4CzcJfimYB4m5Ihwl4Zz5hbA8kHuaEhQTwPfsiMDeCdZY=
=eptL
-----END PGP SIGNATURE-----

--eOZ5LUtYRk41oVSR--

--===============1153347975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1153347975==--

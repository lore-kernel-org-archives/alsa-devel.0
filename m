From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: AMD: add AMD ASoC ACP-I2S driver
Date: Fri, 23 Oct 2015 01:14:15 +0900
Message-ID: <20151022161415.GU8232@sirena.org.uk>
References: <1444320760-21936-8-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1263972363=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1444320760-21936-8-git-send-email-alexander.deucher@amd.com>
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
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============1263972363==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ULJ2Z7kCM1hyNsWd"
Content-Disposition: inline


--ULJ2Z7kCM1hyNsWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 08, 2015 at 12:12:40PM -0400, Alex Deucher wrote:

> ACP IP block consists of dedicated DMA and I2S blocks. The PCM driver
> provides the platform DMA component to ALSA core.

Overall my main comment on a lot of this code is that it feels like we
have created a lot of infrastructure that parallels standard Linux
subsystems and interfaces without something that clearly shows why we're
doing that.  There may be good reasons but they've not been articulated
and it's making the code a lot more complex to follow and review.  We
end up with multiple layers of abstraction and indirection that aren't
explained.

This patch is also rather large and appears to contain multiple
components which could be split, there's at least the DMA driver and
this abstraction layer than the DMA driver builds on.

> +/* ACP DMA irq handler routine for playback, capture usecases */
> +int dma_irq_handler(struct device *dev)
> +{
> +	u16 dscr_idx;
> +	u32 intr_flag;

This says it's an interrupt handler but it's using some custom,
non-genirq interface?

> +		/* Let ACP know the Allocated memory */
> +		num_of_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +
> +		/* Fill the page table entries in ACP SRAM */
> +		rtd->pg = pg;
> +		rtd->size = size;
> +		rtd->num_of_pages = num_of_pages;
> +		rtd->direction = substream->stream;

We never reference num_of_pages other than to assign it into the page
table entry?

> +static int acp_dma_close(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct audio_substream_data *rtd = runtime->private_data;
> +	struct snd_soc_pcm_runtime *prtd = substream->private_data;
> +
> +	kfree(rtd);
> +
> +	pm_runtime_mark_last_busy(prtd->platform->dev);

Why the _mark_last_busy() here?

> +	/* The following members gets populated in device 'open'
> +	 * function. Till then interrupts are disabled in 'acp_hw_init'
> +	 * and device doesn't generate any interrupts.
> +	 */
> +
> +	audio_drv_data->play_stream = NULL;
> +	audio_drv_data->capture_stream = NULL;
> +
> +	audio_drv_data->iprv->dev = &pdev->dev;
> +	audio_drv_data->iprv->acp_mmio = audio_drv_data->acp_mmio;
> +	audio_drv_data->iprv->enable_intr = acp_enable_external_interrupts;
> +	audio_drv_data->iprv->irq_handler = dma_irq_handler;

I do not that we never seem to reset any of these in teardown paths and
I am slightly worried about races with interrupt handling in teardown,

> +static int acp_pcm_suspend(struct device *dev)
> +{
> +	bool pm_rts;
> +	struct audio_drv_data *adata = dev_get_drvdata(dev);
> +
> +	pm_rts = pm_runtime_status_suspended(dev);
> +	if (pm_rts == false)
> +		acp_suspend(adata->acp_mmio);
> +
> +	return 0;
> +}

This appears to merely call into the parent/core device (at least it
looks like this is the intention, there's a bunch of infrastructure fo
the core device which appeaars to replicate standard infrastructure).
Isn't whatever this eventually ends up doing handled by the parent
device in the normal PM callbacks.

This parallel infrastructure seems like it needs some motivation,
especially given that when I look at the implementation of functions
like amd_acp_suspend() and amd_acp_resume() in the preceeding patch they
are empty and therefore do nothing (they're also not exported so I
expect we get build errors if this is a module and the core isn't).
The easiest thing is probably to remove the code until there is an
immplementation and then review at that time.

> +static int acp_pcm_resume(struct device *dev)
> +{
> +	bool pm_rts;
> +	struct snd_pcm_substream *stream;
> +	struct snd_pcm_runtime *rtd;
> +	struct audio_substream_data *sdata;
> +	struct audio_drv_data *adata = dev_get_drvdata(dev);
> +
> +	pm_rts = pm_runtime_status_suspended(dev);
> +	if (pm_rts == true) {
> +		/* Resumed from system wide suspend and there is
> +		 * no pending audio activity to resume. */
> +		pm_runtime_disable(dev);
> +		pm_runtime_set_active(dev);
> +		pm_runtime_enable(dev);

The above looks very strange - why are we bouncing runtime PM like this?

> +/* Initialize the dma descriptors location in SRAM and page size */
> +static void acp_dma_descr_init(void __iomem *acp_mmio)
> +{
> +	u32 sram_pte_offset = 0;
> +
> +	/* SRAM starts at 0x04000000. From that offset one page (4KB) left for
> +	 * filling DMA descriptors.sram_pte_offset = 0x04001000 , used for

This is a device relative address rather than an absolute address?  A
lot of these numbers seem kind of large...

> +u16 get_dscr_idx(void __iomem *acp_mmio, int direction)
> +{
> +	u16 dscr_idx;
> +
> +	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
> +		dscr_idx = acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_13);
> +		dscr_idx = (dscr_idx == PLAYBACK_START_DMA_DESCR_CH13) ?
> +				PLAYBACK_START_DMA_DESCR_CH12 :
> +				PLAYBACK_END_DMA_DESCR_CH12;

Please write normal if statements rather than using the ternery
operator.

> +/* Check whether ACP DMA interrupt (IOC) is generated or not */
> +u32 acp_get_intr_flag(void __iomem *acp_mmio)
> +{
> +	u32 ext_intr_status;
> +	u32 intr_gen;
> +
> +	ext_intr_status = acp_reg_read(acp_mmio, mmACP_EXTERNAL_INTR_STAT);
> +	intr_gen = (((ext_intr_status &
> +		      ACP_EXTERNAL_INTR_STAT__DMAIOCStat_MASK) >>
> +		     ACP_EXTERNAL_INTR_STAT__DMAIOCStat__SHIFT));
> +
> +	return intr_gen;
> +}

Looking at a lot of the interrupt code I can't help but think there's a
genirq interrupt controller lurking in here somewhere.

> +	/*Invalidating the DAGB cache */
> +	acp_reg_write(ENABLE, acp_mmio, mmACP_DAGB_ATU_CTRL);

/* spaces around comments please */

> +	if ((ch_num == ACP_TO_I2S_DMA_CH_NUM) ||
> +	    (ch_num == ACP_TO_SYSRAM_CH_NUM) ||
> +	    (ch_num == I2S_TO_ACP_DMA_CH_NUM))
> +		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
> +	else
> +		dma_ctrl &= ~ACP_DMA_CNTL_0__DMAChIOCEn_MASK;

switch statement please.

> +	u32 delay_time = ACP_DMA_RESET_TIME;

> +	/* check the channel status bit for some time and return the status */
> +	while (0 < delay_time) {
> +		dma_ch_sts = acp_reg_read(acp_mmio, mmACP_DMA_CH_STS);
> +		if (!(dma_ch_sts & BIT(ch_num))) {
> +			/* clear the reset flag after successfully stopping
> +			   the dma transfer and break from the loop */
> +			dma_ctrl &= ~ACP_DMA_CNTL_0__DMAChRst_MASK;
> +
> +			acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0
> +								+ ch_num);
> +			break;
> +		}
> +		delay_time--;
> +	}
> +}

This isn't really a time, it's a number of spins (the amount of time
involved presumably depending on clock speed).  If this were a time I'd
expect to see a delay or sleep in here.

We're also falling off the end of the loop silently if the hardware
fails to respond, if it's worth waiting for the hardware to do it's
thing I'd expect it's also worth displaying an error if that happens.
This is a common pattern in much of the rest of the driver.

> +/* power off a tile/block within ACP */
> +static void acp_suspend_tile(void __iomem *acp_mmio, int tile)
> +{
> +	u32 val = 0;
> +	u32 timeout = 0;
> +
> +	if ((tile  < ACP_TILE_P1) || (tile > ACP_TILE_DSP2))
> +		return;
> +
> +	val = acp_reg_read(acp_mmio, mmACP_PGFSM_READ_REG_0 + tile);
> +	val &= ACP_TILE_ON_MASK;

This is definitely looking like a SoC that could benefit from the
standard kernel power management infrastructure and/or DAPM.  There's a
lot of code here that looks like it's following very common SoC design
patterns and could benefit from using infrastructure more.

> +static void acp_resume_tile(void __iomem *acp_mmio, int tile)
> +{
> +	u32 val = 0;
> +	u32 timeout = 0;
> +
> +	if ((tile  < ACP_TILE_P1) || (tile > ACP_TILE_DSP2))
> +		return;

Not worth printing an error if the user passed in something invalid?

> +/* Shutdown unused SRAM memory banks in ACP IP */
> +static void acp_turnoff_sram_banks(void __iomem *acp_mmio)
> +{
> +	/* Bank 0 : used for DMA descriptors
> +	 * Bank 1 to 4 : used for playback
> +	 * Bank 5 to 8 : used for capture
> +	 * Each bank is 8kB and max size allocated for playback/ capture is
> +	 * 16kB(max period size) * 2(max periods) reserved for playback/capture
> +	 * in ALSA driver
> +	 * Turn off all SRAM banks except above banks during playback/capture
> +	 */
> +	u32 val, bank;

I didn't see any runtime management of the other SRAM bank power, seems
like that'd be a good idea?

> +	/* initiailizing Garlic Control DAGB register */
> +	acp_reg_write(ONION_CNTL_DEFAULT, acp_mmio, mmACP_AXI2DAGB_ONION_CNTL);
> +
> +	/* initiailizing Onion Control DAGB registers */
> +	acp_reg_write(GARLIC_CNTL_DEFAULT, acp_mmio,
> +			mmACP_AXI2DAGB_GARLIC_CNTL);

The comments don't match the code...

> +/* Update DMA postion in audio ring buffer at period level granularity.
> + * This will be used by ALSA PCM driver
> + */
> +u32 acp_update_dma_pointer(void __iomem *acp_mmio, int direction,
> +				  u32 period_size)
> +{
> +	u32 pos;
> +	u16 dscr;
> +	u32 mul;
> +	u32 dma_config;
> +
> +	pos = 0;
> +
> +	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
> +		dscr = acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_13);
> +
> +		mul = (dscr == PLAYBACK_START_DMA_DESCR_CH13) ? 0 : 1;
> +		pos =  (mul * period_size);

Don't limit the accuracy to period level if the harwdare can do better,
report the current position as accurately as possible please.  This is
also feeling like we've got an unneeded abstraction here - why was this
not just directly the pointer operation?

> +/* Wait for initial buffering to complete in HOST to SRAM DMA channel
> + * for plaback usecase
> + */
> +void prebuffer_audio(void __iomem *acp_mmio)
> +{
> +	u32 dma_ch_sts;
> +	u32 channel_mask = BIT(SYSRAM_TO_ACP_CH_NUM);
> +
> +	do {
> +		/* Read the channel status to poll dma transfer completion
> +		 * (System RAM to SRAM)
> +		 * In this case, it will be runtime->start_threshold
> +		 * (2 ALSA periods) of transfer. Rendering starts after this
> +		 * threshold is met.
> +		 */
> +		dma_ch_sts = acp_reg_read(acp_mmio, mmACP_DMA_CH_STS);
> +		udelay(20);
> +	} while (dma_ch_sts & channel_mask);

This will hang hard if the hardware fails to respond for some reason,
please have a timeout.  A cpu_relax() would also be friendly.

> +#define DISABLE					0
> +#define ENABLE					1

Please don't do this :(

> +#define STATUS_SUCCESS 0
> +#define STATUS_UNSUCCESSFUL -1

Please use normal Linux error codes.

--ULJ2Z7kCM1hyNsWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKQtWAAoJECTWi3JdVIfQagIH/0WAMvaNENO+A8wI1/qxNBEi
QBFyZBduEpOB5pJ5peEs4XY7UQYQsvU91+H3iui9BUyVk3A5MdApBvaMq5RVE7Xs
VQR8E2oHfbca7rXkzMzIirt2ek7zgNJRC1UXG1x83RMDHh6ID1nN30IG/MDfQUS5
3iEf2gVTRATJAiOkcA/DMohqzMYTrjiuPmAxz/dogfOItqvyV047V+h3HOLTQ5w5
/G1OXcTLT2T3BPW4J1NHOMXbthS6JMTdF0y2n9LN4Odq5bMLs5eFyveuUeCPlVAf
qIDgpxOYiRhexXiWllE1MQRGUFTCM7hU+iOYWCcs35Hk+/Ef/rOF+Awfh2Laps8=
=dkja
-----END PGP SIGNATURE-----

--ULJ2Z7kCM1hyNsWd--

--===============1263972363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============1263972363==--

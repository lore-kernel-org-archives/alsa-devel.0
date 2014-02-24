From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 3/6] ASoC: Intel: Add Haswell and Broadwell
 PCM platform driver
Date: Mon, 24 Feb 2014 20:07:12 +0000
Message-ID: <1393272432.2323.72.camel@loki>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392932927-9725-3-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5hsircx6tq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 8227B261ADF
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 21:09:22 +0100 (CET)
In-Reply-To: <s5hsircx6tq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-02-21 at 08:28 +0100, Takashi Iwai wrote:
> At Thu, 20 Feb 2014 21:48:44 +0000,
> Liam Girdwood wrote:
> > +/* TLV used by both global and stream volumes */
> > +static const DECLARE_TLV_DB_SCALE(hsw_vol_tlv, -9000, 300, 1);
> > +
> > +/* System Pin has no volume control */
> > +static const struct snd_kcontrol_new hsw_volume_controls[] = {
> > +	/* Global DSP volume */
> > +	SOC_DOUBLE_EXT_TLV("Master Playback Volume", 0, 0, 8,
> > +		ARRAY_SIZE(volume_map) -1, 0,
> > +		hsw_volume_get, hsw_volume_put, hsw_vol_tlv),
> > +	/* Offload 0 volume */
> > +	SOC_DOUBLE_EXT_TLV("Media0 Playback Volume", 1, 0, 8,
> > +		ARRAY_SIZE(volume_map), 0,
> > +		hsw_stream_volume_get, hsw_stream_volume_put, hsw_vol_tlv),
> 
> Why -1 is for Master and not for others although they use the same
> TLV?

Iirc, one could be gain and the other attenuation. Let me double check.

> 
> 
> > +/* Create DMA buffer page table for DSP */
> > +static int create_adsp_page_table(struct hsw_priv_data *pdata,
> > +	struct snd_soc_pcm_runtime *rtd,
> > +	unsigned char *dma_area, size_t size, int pcm, int stream)
> > +{
> > +	int i, pages;
> > +
> > +	if (size % PAGE_SIZE)
> > +		pages = (size / PAGE_SIZE) + 1;
> > +	else
> > +		pages = size / PAGE_SIZE;
> > +
> > +	dev_dbg(rtd->dev, "generating page table for %p size 0x%zu pages %d\n",
> > +		dma_area, size, pages);
> > +
> > +	for (i = 0; i < pages; i++) {
> > +		u32 idx = (((i << 2) + i)) >> 1;
> > +		u32 pfn = (virt_to_phys(dma_area + i * PAGE_SIZE)) >> PAGE_SHIFT;
> 
> virt_to_phys() is bad, pretty unportable.  And, this implementation
> doesn't use SG-buffer although the hardware can it obviously.
> 
> For managing SG-buffer, just use SNDRV_DMA_TPE_DEV_SG for
> preallocation, and change the page setup code like:
> 
> 	struct snd_dma_buffer *dmab = snd_pcm_get_dma_buf(substream)
> 
> 	....
> 	pages = snd_sgbuf_aligned_pages(size);
> 	for (i = 0; i < pages; i++) {
> 		u32 idx = (((i << 2) + i)) >> 1;
> 		u32 pfn = snd_sgbuf_get_addr(dmab, i * PAGE_SIZE) >> PAGE_SHIFT;
> 
> The only other thing to change is to pass snd_pcm_sgbuf_ops_page to
> snd_pcm_ops.page.  That's all.

Thanks, I wasn't aware these helpers existed. Will fix.

Liam

From: Nicolas Pitre <nico@cam.org>
Subject: Re: new ALSA driver for audio on the ARM PXA2xx platform
Date: Wed, 26 Jan 2005 10:20:39 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0501261004410.16341@localhost.localdomain>
References: <Pine.LNX.4.61.0501251624470.16341@localhost.localdomain>
 <s5hfz0o5vf4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfz0o5vf4.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Jan 2005, Takashi Iwai wrote:

> Hi Nicolas,
> 
> At Tue, 25 Jan 2005 16:33:40 -0500 (EST),
> Nicolas Pitre wrote:
> > 
> > 
> > This patch adds two modules: one for generic PCM support on PXA2xx and 
> > another to interface with the AC97 link on the PXA2xx.  Eventually 
> > additional modules could be written to use the PCM module with SSP or 
> > I2S audio ports.
> > 
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> 
> Thanks, the code looks nice.

Thanks.

> > Index: linux-2.6/sound/arm/pxa2xx-pcm.c
> (snip)
> > +static const snd_pcm_hardware_t pxa2xx_pcm_hardware = {
> > +	.info			= SNDRV_PCM_INFO_MMAP |
> > +				  SNDRV_PCM_INFO_MMAP_VALID |
> > +				  SNDRV_PCM_INFO_INTERLEAVED |
> > +				  SNDRV_PCM_INFO_PAUSE,
> 
> Don't forget SNDRV_PCM_INFO_RESUME if the driver supports PM.

Well, I initially had problems with it (the code was too ugly for my 
taste).  And since aplay appears to restart the stream anyway I decided 
to revisit it later.

> > +	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
> > +	.period_bytes_min	= 32,
> > +	.period_bytes_max	= 8192 - 32,
> 
> I suppose this 32 is fifo size?  If so, you don't have to count it
> here.  The period size defines the size of DMA interrupt period.
> (The fifo_size isn't used in the driver currently.)

It really has to be 8192 - 32 since the maximum DMA size is actually 
8191 and problems occur if things aren't rounded to the FIFO size.

> > +static void pxa2xx_pcm_dma_irq(int dma_ch, void *dev_id, struct pt_regs *regs)
> > +{
> > +	snd_pcm_substream_t *substream = dev_id;
> > +	struct pxa2xx_runtime_data *rtd = substream->runtime->private_data;
> > +	int dcsr;
> > +
> > +	dcsr = DCSR(dma_ch);
> > +	DCSR(dma_ch) = dcsr & ~DCSR_STOPIRQEN;
> > +
> > +	if (dcsr & DCSR_ENDINTR) {
> > +		snd_pcm_period_elapsed(substream);
> > +	} else {
> > +		printk( KERN_ERR "%s: DMA error on channel %d (DCSR=%#x)\n",
> > +			rtd->params->name, dma_ch, dcsr );
> 
> You can call here snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN) to
> notify the buffer over/underrun.

Well there should never be any error at that level even if a hardware 
xrun occurs.  This is mainly to display something if ever anything 
really odd happens..


Nicolas


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

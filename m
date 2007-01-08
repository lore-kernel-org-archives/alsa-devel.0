From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [RFC,
	PATCH] ep93xx: alsa pcm and ac97 support (fwd)
Date: Mon, 8 Jan 2007 15:13:00 +0100
Message-ID: <20070108141300.GA30819@xi.wantstofly.org>
References: <20070107211614.GA21247@xi.wantstofly.org>
	<s5h3b6lydqt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from xi.wantstofly.org (alephnull.demon.nl [83.160.184.112])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7C43A21D
	for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2007 15:13:04 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5h3b6lydqt.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 08, 2007 at 12:11:38PM +0100, Takashi Iwai wrote:

> > (Please CC on replies, not subscribed.)
> > 
> > I sent this to linux-arm-kernel@ some time ago, but didn't get any
> > complaints, so I guess it's time I send it to the alsa list.  This
> > driver depends on the cirrus m2p dma driver that I also sent to the
> > linux-arm-kernel@ list some time ago.
> 
> Thanks for the patch.

Thanks for the review!


> > --- /dev/null
> > +++ linux-2.6.19/sound/arm/ep93xx-ac97.c
> (snip)
> > +static void ep93xx_ac97_bus_reset(struct snd_ac97 *ac97)
> > +{
> > +	int i;
> > +
> > +	printk(KERN_INFO "ep93xx-ac97: resetting bus.. ");
> 
> If these are nothing but debug messages, use snd_printd(), for
> example.

OK.


> > +/* AC'97 platform driver ****************************************************/
> > +static int ep93xx_ac97_probe(struct platform_device *dev)
> > +{
> > +	struct ep93xx_ac97_audio_ops *ops = dev->dev.platform_data;
> > +	struct snd_card *card;
> > +	struct snd_ac97_bus *ac97_bus;
> > +	struct snd_ac97_template ac97_template;
> > +	int ret;
> > +
> > +	// @@@ register resources
> 
> Avoid C++ style comments (ditto for some other places).

(I was going to nuke the // and @@@ comments before submitting a final
version anyway.)


> > +err:
> > +	/* @@@ This causes hangs..
> > +	 * if (card != NULL)
> > +	 *	snd_card_free(card);
> > +	 */
> 
> Any clue how does it hang?

I remember making a backtrace, but I don't seem to have it anymore.
I'll give it another try when I have a moment.


> > +#ifdef CONFIG_PM
> > +static int ep93xx_ac97_suspend(struct platform_device *dev, pm_message_t state)
> > +{
> > +	return 0;
> 
> Hm, don't you need any suspend action for PCM and AC97 registers?

At the least, I suppose we should deactivate the AC link, and perhaps
we can also gate the DMA channel clock.  I'll implement this.


> > --- /dev/null
> > +++ linux-2.6.19/sound/arm/ep93xx-pcm.c
> > +static int ep93xx_pcm_open(struct snd_pcm_substream *substream)
> > +{
> > +	struct ep93xx_pcm_client *client = substream->private_data;
> > +	struct snd_pcm_runtime *runtime = substream->runtime;
> > +	struct ep93xx_runtime_data *rtd;
> > +	int ret;
> > +
> > +	runtime->hw = ep93xx_pcm_hardware;
> > +
> > +	rtd = kmalloc(sizeof(*rtd), GFP_KERNEL);
> > +	if (rtd == NULL) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	rtd->params = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
> > +			client->playback_params : client->capture_params;
> > +
> > +	memset(&rtd->period_tasklet, 0, sizeof(rtd->period_tasklet));
> > +	rtd->period_tasklet.func = do_period_elapsed;
> > +	rtd->period_tasklet.data = (unsigned long)substream;
> 
> Use tasklet_init().

ACK.


> > +static u64 ep93xx_pcm_dmamask = 0xffffffff;
> 
> Use DMA_32BIT_MASK.

OK.  Note that pxa2xx-pcm has the same construct. 


> > +	pcm->private_data = client;
> > +	pcm->private_free = ep93xx_pcm_free_dma_buffers;
> > +
> > +	if (!card->dev->dma_mask)
> > +		card->dev->dma_mask = &ep93xx_pcm_dmamask;
> > +	if (!card->dev->coherent_dma_mask)
> > +		card->dev->coherent_dma_mask = 0xffffffff;
> 
> Doesn't dma_set_mask() work?

Again, this was just copied from pxa2xx-pcm.  I'll have a look.


> > +EXPORT_SYMBOL(ep93xx_pcm_new);
> > +
> > +MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
> > +MODULE_DESCRIPTION("EP93xx ALSA PCM interface");
> > +MODULE_LICENSE("GPL");
> 
> Could ep93xx-pcm be merged to ep93xx-ac97 as a single module?
> Since you have only one interface, it doesn't make much sense to split
> to two modules.  With a single module, you can avoid unnecessary
> exported symbols.

The ep93xx CPU also has I2S/SSP, which I haven't yet written a driver
for -- but someone else started work on an I2S driver:

	http://www.freelists.org/archives/linux-cirrus/01-2007/msg00018.html

Thanks again for the review.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

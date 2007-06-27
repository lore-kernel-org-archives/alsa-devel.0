From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: SoC Machine Code Suggestions
Date: Wed, 27 Jun 2007 15:10:18 -0500
Message-ID: <61c0054e0706271310y6061a773n691ea3a2d66edcfb@mail.gmail.com>
References: <61c0054e0706270847n42fbd896lc2e778e1e3862380@mail.gmail.com>
	<1182962888.3172.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F9B224330
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2007 22:10:19 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so354996mue
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2007 13:10:19 -0700 (PDT)
In-Reply-To: <1182962888.3172.72.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/27/07, Liam Girdwood <lg@opensource.wolfsonmicro.com> wrote:
>
> On Wed, 2007-06-27 at 10:47 -0500, Paul Kavan wrote:
>
> >
> > First. when the pcm interface starts/stops, I get a pop that comes from
> the
> > codec analog output transitioning some.
>
> Does your codec have a digital mute ?


It has a digital power down/up line. I suppose I could strap a gpio to it
and then turn the codec on first...wait an sec....and then turn the amp on.
Then on shutdown, do the reverse. However....the more I think....it also has
auto shutdown once any of the 5 clocks is off. So knowing where the ssc
starts and stops clocking would be helpful. I could then turn my amp on and
off around those clock start/stops.

Fwiw, you may want read the application notes in the codec datasheet for
> minimising any pops and clicks.
>
> It's also sometimes useful to minimise any output gains at startup and
> then ramp them up to the desired volume before playback starts on some
> devices.
>
> > Now, there may be some hardware
> > fixes to this, but what I would like to do it mute the amp until the
> last
> > possible second before audio is played. I can accomplish this with a
> simple
> > gpio call, but am not sure where best to turn the mute on and off. Any
> > suggestions with that would be appreciated.
> >
>
> Turning the amp on and off will probably also cause a pop. It's just a
> matter of finding what pops the least. You could add your GPIO amp code
> to the machine driver say in startup/shutdown, but please bear in mind
> the amp may take a little time to get up and running.


There is a cap on the amp mute that is designed to bring it up and down
slower. So the amp does not pop much when it is brought in and out of mute.

I am thinking it would be best to do the muting around the ssc clocking
start/stops. I thought I understood where those are in code, but it is not
seeming to work that way.

For startup, I was trying the following in at91-ssc.c:

static int at91_ssc_prepare(struct snd_pcm_substream *substream)
{
    struct snd_soc_pcm_runtime *rtd = substream->private_data;
    struct at91_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
    struct at91_pcm_dma_params *dma_params;
    int dir, i;

    dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;


    dma_params = ssc_p->dma_params[dir];

    at91_ssc_write(dma_params->ssc_base + AT91_SSC_CR,
            dma_params->mask->ssc_enable);

         /* Check direction. If playback, unmute the amp */
        if(dir==0)
            at91_set_gpio_value(AT91_PIN_PB8,1);

    DBG("%s enabled SSC_SR=0x%08lx\n", dir ? "receive" : "transmit",
        at91_ssc_read(dma_params->ssc_base + AT91_SSC_SR));
    return 0;

}


For shutdown, in at91-ssc.c I was trying:


/*
 * Shutdown.  Clear DMA parameters and shutdown the SSC if there
 * are no other substreams open.
 */
static void at91_ssc_shutdown(struct snd_pcm_substream *substream)
{
    struct snd_soc_pcm_runtime *rtd = substream->private_data;
    struct at91_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
    struct at91_pcm_dma_params *dma_params;
    int dir, dir_mask;

        /*Ensure the amp is muted*/
        at91_set_gpio_value(AT91_PIN_PB8,0);

    dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
    dma_params = ssc_p->dma_params[dir];


    if (dma_params != NULL) {
        at91_ssc_write(dma_params->ssc_base + AT91_SSC_CR,
                dma_params->mask->ssc_disable);
        DBG("%s disabled SSC_SR=0x%08lx\n", (dir ? "receive" : "transmit"),
            at91_ssc_read(ssc_p->ssc.base + AT91_SSC_SR));

        dma_params->ssc_base = NULL;
        dma_params->substream = NULL;
        ssc_p->dma_params[dir] = NULL;
    }

    dir_mask = 1 << dir;

    spin_lock_irq(&ssc_p->lock);
    ssc_p->dir_mask &= ~dir_mask;
    if (!ssc_p->dir_mask) {
        /* Shutdown the SSC clock. */
        DBG("Stopping pid %d clock\n", ssc_p->ssc.pid);
        at91_sys_write(AT91_PMC_PCDR, 1<<ssc_p->ssc.pid);

        if (ssc_p->initialized) {
            free_irq(ssc_p->ssc.pid, ssc_p);
            ssc_p->initialized = 0;
        }

        /* Reset the SSC */
        at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR, AT91_SSC_SWRST);

        /* Clear the SSC dividers */
        ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
    }
    spin_unlock_irq(&ssc_p->lock);
}

/*
 * Record the SSC system clock rate.
 */
static int at91_ssc_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
        int clk_id, unsigned int freq, int dir)
{
    /*
     * The only clock supplied to the SSC is the AT91 master clock,
     * which is only used if the SSC is generating BCLK and/or
     * LRC clocks.
     */
    switch (clk_id) {
    case AT91_SYSCLK_MCK:
        at91_ssc_sysclk = freq;
        break;
    default:
        return -EINVAL;
    }

    return 0;
}

/*
 * Record the DAI format for use in hw_params().
 */
static int at91_ssc_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
        unsigned int fmt)
{
    struct at91_ssc_info *ssc_p = &ssc_info[cpu_dai->id];

    ssc_p->daifmt = fmt;
    return 0;
}

/*
 * Record SSC clock dividers for use in hw_params().
 */
static int at91_ssc_set_dai_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
    int div_id, int div)
{
    struct at91_ssc_info *ssc_p = &ssc_info[cpu_dai->id];

    switch (div_id) {
    case AT91SSC_CMR_DIV:
        /*
         * The same master clock divider is used for both
         * transmit and receive, so if a value has already
         * been set, it must match this value.
         */
        if (ssc_p->cmr_div == 0)
            ssc_p->cmr_div = div;
        else
            if (div != ssc_p->cmr_div)
                return -EBUSY;
        break;

    case AT91SSC_TCMR_PERIOD:
        ssc_p->tcmr_period = div;
        break;

    case AT91SSC_RCMR_PERIOD:
        ssc_p->rcmr_period = div;
        break;

    default:
        return -EINVAL;
    }

    return 0;
}


This does not seem to work. Any ideas why?

Paul



-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************

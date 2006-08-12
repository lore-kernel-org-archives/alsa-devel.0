From: Julien Bramary <julien.bramary@blueyonder.co.uk>
Subject: Re: aplay skipping first periods
Date: Sat, 12 Aug 2006 04:44:18 +0100
Message-ID: <44DD4E92.3060202@blueyonder.co.uk>
References: <44DD4583.2020409@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44DD4583.2020409@blueyonder.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Julien Bramary <julien.bramary@blueyonder.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Julien Bramary wrote:
> When testing my driver at low sampling rates like 8k,
> I noticed that aplay was skipping the very first samples.
>
> This skipping process might also happen at 44.1k but is then too short 
> to be noticeable.
>
> Is this a know issue with aplay or a bug with my driver?
> I really don't see how my code could be causing this.
>
No it was my code breaking the stuff.
Some obscure transfer request that I was enabling too soon.
I needed to add that in the trigger callback instead of the open callback.

Here is my new trigger, do you think it is short enough? (atomicity in 
mind):

static int snd_card_mdac3560c_pcm_trigger(struct snd_pcm_substream 
*substream, int cmd)
{
    struct snd_pcm_runtime *runtime = substream->runtime;
    struct snd_mdac3560c_pcm *dpcm = runtime->private_data;
    int err = 0;

    spin_lock(&dpcm->lock);
    switch (cmd) {
    case SNDRV_PCM_TRIGGER_START:
    case SNDRV_PCM_TRIGGER_RESUME:
        unlock_mdac_irq(); /* enable hardware IRQ */
        at91_ssc_write(AT91_PDC_PTCR, AT91_PDC_TXTEN);    /* enable PDC 
transfer requests */
        at91_ssc_write(AT91_SSC_CR, AT91_SSC_TXEN);    /* enable SSC 
(I2S) data Tx */
        break;
    case SNDRV_PCM_TRIGGER_STOP:
    case SNDRV_PCM_TRIGGER_SUSPEND:
        at91_ssc_write(AT91_SSC_CR, AT91_SSC_TXDIS); /* disable SSC 
(I2S) data Tx */
        at91_ssc_write(AT91_PDC_PTCR, AT91_PDC_TXTDIS);    /* disable 
PDC transfer requests */
        lock_mdac_irq();   /* disable hardware IRQ /*
        break;
    default:
        err = -EINVAL;
        break;
    }
    spin_unlock(&dpcm->lock);
    return 0;
}

Cheers then,

Julien


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

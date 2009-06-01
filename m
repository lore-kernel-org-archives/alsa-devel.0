From: "chaithrika" <chaithrika@ti.com>
Subject: Re: [PATCH v3 5/6] ARM: DaVinci: ASoC: Add
	mcasp	support for DM646x
Date: Mon, 1 Jun 2009 16:00:05 +0530
Message-ID: <001301c9e2a3$edd4e970$c97ebc50$@com>
References: <1243501868-28565-1-git-send-email-chaithrika@ti.com>
	<20090530162647.GA19692@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E8AEF243F2
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Jun 2009 12:30:58 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n51AUqCs011031
	for <alsa-devel@alsa-project.org>; Mon, 1 Jun 2009 05:30:57 -0500
Received: from tidmzi-ftp.india.ext.ti.com (localhost [127.0.0.1])
	by dflp53.itg.ti.com (8.13.8/8.13.8) with SMTP id n51AUosf021054
	for <alsa-devel@alsa-project.org>; Mon, 1 Jun 2009 05:30:51 -0500 (CDT)
Received: from symphonyindia.ti.com (symphony-ftp [192.168.247.11])
	by tidmzi-ftp.india.ext.ti.com (Postfix) with SMTP id B0DEB3886F
	for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2009 15:58:12 +0530 (IST)
In-Reply-To: <20090530162647.GA19692@sirena.org.uk>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'Pavel Kiryukhin' <pkiryukhin@ru.mvista.com>, alsa-devel@alsa-project.org, 'Steve Chen' <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com, 'Naresh Medisetty' <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Saturday, May 30, 2009 9:57 PM
> To: Chaithrika U S
> Cc: alsa-devel@alsa-project.org; davinci-linux-open-
> source@linux.davincidsp.com; Steve Chen; Naresh Medisetty; Pavel
> Kiryukhin
> Subject: Re: [alsa-devel] [PATCH v3 5/6] ARM: DaVinci: ASoC: Add mcasp
> support for DM646x
> 
> On Thu, May 28, 2009 at 05:11:08AM -0400, Chaithrika U S wrote:
> 
> > The codec on the DM646x EVM is AIC32 which is connected to
> Serializer0 and
> > Serializer1 of McASP0. The McASP0 consists of transmit and receive
> sections
> > that may operate synchronized, or completely independently with
> separate master
> > clocks, bit clocks, and frame syncs, and using different transmit
> modes with
> > different bit-stream formats.
> 
> The particular configuration used for the EVM should not be relevant
> for
> the McASP driver.

Yes, agree.

> 
> > +/* Left (even TDM Slot) Channel Status Register File*/
> > +#define DAVINCI_MCASP_DITCSRA_REG	0x100
> > +/* Right (odd TDM slot) Channel Status RegisterFile*/
> > +#define DAVINCI_MCASP_DITCSRB_REG	0x118
> 
> Interesting spacing in the comments...
> 
> > +	case DAVINCI_AUDIO_WORD_32:
> > +		fmt = 0x0F;
> > +		break;
> > +
> > +	default:
> > +		return -1;
> > +	}
> 
> Should be a real error code.
> 

Agree.

> > +static void davinci_hw_param(struct snd_pcm_substream *substream)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct davinci_audio_dev *dev = rtd->dai->cpu_dai->private_data;
> 
> It might be easier with a lot of these functions to just pass the
> davinci_audio_dev as a parameter.

OK.I will change this wherever possible.

> 
> > +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> > +               /* bit stream is MSB first  with no delay */
> > +               /* DSP_B mode */
> 
> Your driver consistently refers to itself as an I2S driver but it
> appears that in actual fact it only implements DSP mode B.  This might
> be a bit confusing for users.
> 

The hardware supports I2S, DSP A/B modes, currently it is configured in DSP
B mode. May be changing all the function names from davinci_i2s_mcasp_XXX() 
to davinci_mcasp_xxx() will avoid confusion. Along with this, the
file names can be changed to davinci-mcasp.c[h].

> > +	/* Set the TX format : 24 bit right rotation, 32 bit slot, Pad 0
> > +	   and LSB first */
> > +	mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
> > +						TXROT(6) | TXSSZ(15));
> 
> I suspect looking at some of the indentation that you're writing this
> code with 4 character tabs.
> 
> > +static int davinci_i2s_mcasp_probe(struct platform_device *pdev)
> > +{
> > +	struct evm_snd_platform_data *parray = pdev->dev.platform_data;
> > +	struct davinci_pcm_dma_params *dma_data;
> > +	struct resource *mem, *ioarea, *res;
> > +	struct evm_snd_platform_data *pdata;
> 
> Why is the McASP driver using platform data called
> 'evm_snd_patform_data'?
> This suggests that there's some abstraction problem with the separation
> between the machine and McASP drivers.
> 
> Are the two DAIs directly tied to each other in hardware?  If not it'd
> probably be better to have them registered as separate devices and
> probe
> separately so that if another chip comes along with a different set of
> DAIs it can be accommodated more readily - if the register interfaces
> stay consistent it may simply be a case of registering the new device.
> 

Are you referring to the two DAI links in this driver?
They are two instances of the same hardware, therefore tied to 
each other. For future chips, the instances may change. Therefore, the 
number of links should come from the platform data and hard coding it 
to 2 is not right. I will correct this.

> > +	ret = snd_soc_register_dais(davinci_iis_mcasp_dai,
> > +				ARRAY_SIZE(davinci_iis_mcasp_dai));
> > +	if (ret != 0)
> > +		goto err_release_region;
> 
> You should initialise dev within the DAI to be the struct device for
> the
> platform driver you were probed with.  It might also be nice to tie
> this
> in to num_links somehow.

OK, will look into this.

Regards,
Chaithrika

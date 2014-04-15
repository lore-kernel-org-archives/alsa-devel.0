From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Using simple-card to replace kirkwood-t5325.c
Date: Tue, 15 Apr 2014 20:40:49 +0200
Message-ID: <534D7D31.6040802@metafoo.de>
References: <20140415161302.GC1871@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-049.synserver.de
 [212.40.185.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 76449264F1D
 for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2014 20:40:53 +0200 (CEST)
In-Reply-To: <20140415161302.GC1871@lunn.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Xiubo Li <Li.Xiubo@freescale.com>, Jean Delvare <khali@linux-fr.org>
List-Id: alsa-devel@alsa-project.org

On 04/15/2014 06:13 PM, Andrew Lunn wrote:
> Hi Folks

Adding a few people to Cc.

>
> I'm an ALSA newbie, so if i say anything stupid, please let me know.
>
> I'm trying to replace sound/soc/kirkwood/kirkwood-t5325.c with DT,
> using simple-card. I can get near, but i'm missing two things:
>
> There does not appear to be a way to represent this in DT:
>
> static int t5325_dai_init(struct snd_soc_pcm_runtime *rtd)
> {
> 	struct snd_soc_codec *codec = rtd->codec;
> 	struct snd_soc_dapm_context *dapm = &codec->dapm;
>
> 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
> 	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
> 	snd_soc_dapm_enable_pin(dapm, "Speaker");
>
> 	return 0;
> }
>
> It appears that quite a few drivers need to enable pins.

I'm not sure where this got started, but this mostly seems to be 
cargo-culting. External pins are enabled by default, there is no need to 
call snd_soc_dapm_enable_pin() unless snd_soc_dapm_disable_pin() has been 
called before for the same pin.

> It also seems
> common to disable pins and to set them to NC. Is this a generic enough
> feature it could be added to the DT binding?

We should probably require that the DAPM routes and widgets are always 
completely specified. In this case the fully_routed flag can be set and 
unconnected pins will automatically be marked as not connected. Although it 
might be too late now to require this since there are already users of the 
simple card out in the wild which may have incomplete constraints.

>
> The second thing i need is:
>
> static int t5325_hw_params(struct snd_pcm_substream *substream,
>         	   struct snd_pcm_hw_params *params)
> {
> 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> 	unsigned int freq;
>
> 	freq = params_rate(params) * 256;
>
> 	return snd_soc_dai_set_sysclk(codec_dai, 0, freq, SND_SOC_CLOCK_IN);
>
> }
>
> static struct snd_soc_ops t5325_ops = {
>         .hw_params = t5325_hw_params,
> };
>
>
> This seems a lot less common requirements. All the Marvell SoCs need
> it, but not many others. So i don't think it makes sense to add it
> directly to simple-card, otherwise simple-card quickly becomes
> complex-card as everybody else wants there quirks adding.

Maybe the drivers can be reworked to not require this anymore. The CODEC 
driver may be able to figure this out on its own.

>
> Has there been any thoughts about turning simple-card.c into a
> library, or adding hooks so that a driver can modify the created
> dai_link structures to add in ops like this?

A few of the function that got added for the simple card are already 
available as library functions in soc-core.c. More can probably made 
available to other drivers if useful.

- Lars

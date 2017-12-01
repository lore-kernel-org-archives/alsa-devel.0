From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v4] ASoC: ak4613: call dummy write for
 PW_MGMT1/3 when Playback
Date: Sat, 2 Dec 2017 00:51:26 +0900
Message-ID: <14212e10-35eb-074a-956a-7f929ab842bb@sakamocchi.jp>
References: <87k1y73wwa.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id B5635267029
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 16:51:32 +0100 (CET)
In-Reply-To: <87k1y73wwa.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Dec 1 2017 13:25, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Power Down Release Command (PMVR, PMDAC, RSTN, PMDA1-PMDA6)
> which are located on PW_MGMT1 / PW_MGMT3 register must be
> write again after at least 5 LRCK cycle or later on each command.
> Otherwise, Playback volume will be 0dB.
> Basically, it should be
> 
> 	1.   PowerDownRelease by Power Management1 <= call 1.x after 5LRCK
> 	1.x  Dummy write      to Power Management1
> 	2.   PowerDownRelease by Power Management3 <= call 2.x after 5LRCK
> 	2.x  Dummy write      to Power Management3
> 
> To avoid too many dummy write, this patch is merging these.
> 
> 	1.   PowerDownRelease by Power Management1
> 	2.   PowerDownRelease by Power Management3   <= call after 5LRCK
> 	2.x  Dummy write      to Power Management1/3 <= merge dummy write
> 
> This patch adds dummy write when Playback Start timing.
> 
> Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 
>   - use schedule_work() instead of schedule_delayed_work()
> 
>   sound/soc/codecs/ak4613.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
> index ee9e822..8d2c90b 100644
> --- a/sound/soc/codecs/ak4613.c
> +++ b/sound/soc/codecs/ak4613.c
> ...
> +static void ak4613_dummy_write(struct work_struct *work)
> +{
> +	struct ak4613_priv *priv = container_of(work,
> +						struct ak4613_priv,
> +						dummy_write_work);
> +	struct snd_soc_component *component = priv->component;
> +	unsigned int mgmt1;
> +	unsigned int mgmt3;
> +
> +	/* wait 5 LR clocks */
> +	udelay(5000000 / priv->rate);
> +
> +	snd_soc_component_read(component, PW_MGMT1, &mgmt1);
> +	snd_soc_component_read(component, PW_MGMT3, &mgmt3);
> +
> +	snd_soc_component_write(component, PW_MGMT1, mgmt1);
> +	snd_soc_component_write(component, PW_MGMT3, mgmt3);
> +}

In my understanding, it's better to have care of kernel preemption in 
this case because data transmission is already activated and these 
should be executed as quick as possible to prevent much presentation loss.

> +static int ak4613_dai_trigger(struct snd_pcm_substream *substream, int cmd,
> +			      struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct ak4613_priv *priv = snd_soc_codec_get_drvdata(codec);
> +
> +	/*
> +	 * FIXME
> +	 *
> +	 * PW_MGMT1 / PW_MGMT3 needs dummy write at least after 5 LR clocks
> +	 * from Power Down Release. Otherwise, Playback volume will be 0dB.
> +	 * To avoid complex multiple delay/dummy_write method from
> +	 * ak4613_set_bias_level() / SND_SOC_DAPM_DAC_E("DACx", ...),
> +	 * call it once here.
> +	 *
> +	 * But, unfortunately, we can't "write" here because here is atomic
> +	 * context (It uses I2C access for write).
> +	 * Thus, use delayed work with 0 delay to switch to normal context
> +	 * immediately, and wait 5 LR clocks and do dummy_write there.

You don't use 'struct delayed_work' anymore.

> +	 */
> +
> +	if ((cmd != SNDRV_PCM_TRIGGER_START) &&
> +	    (cmd != SNDRV_PCM_TRIGGER_RESUME))
> +		return 0;
> +
> +	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
> +		return  0;
> +
> +	priv->component = &codec->component;
> +	schedule_work(&priv->dummy_write_work);
> +
> +	return 0;
> +}

Furthermore, you said that a task for the work is scheduled immediately 
after queueing. Renesas' R-Car SoC and its derivatives are designed to 
be multi core processor on which several threads are available. On the 
other hand, there're some SoCs which has a core for single thread. It's 
welcome to design this driver for such poor machine, in my opinion.

Overall, no information about possibilities of presentation loss in the 
beginning of playback, which I addressed several times.

Before posting revised patches, please have a time to re-evaluate it in 
your side. It often brings easy mistakes because some points are newly 
added against its original shape. The points can causes contradictions 
and lose consistency.


Regards

Takashi Sakamoto

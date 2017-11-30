From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2] ASoC: ak4613: call dummy write for
 PW_MGMT1/3 when Playback
Date: Fri, 1 Dec 2017 07:47:51 +0900
Message-ID: <ec1cdec4-7d75-842d-7227-52468e04ac8c@sakamocchi.jp>
References: <87609uubjp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 2A9EB2678AC
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 23:47:57 +0100 (CET)
In-Reply-To: <87609uubjp.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Nov 26 2017 16:15, Kuninori Morimoto wrote:
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
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
>   - add more explain on log area
>   - call dummy write after 5LRCK
> 
>   sound/soc/codecs/ak4613.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
> 
> diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
> index ee9e822..937cff4 100644
> --- a/sound/soc/codecs/ak4613.c
> +++ b/sound/soc/codecs/ak4613.c
> @@ -15,6 +15,7 @@
> ...
> +static int ak4613_dai_trigger(struct snd_pcm_substream *substream, int cmd,
> +			      struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct ak4613_priv *priv = snd_soc_codec_get_drvdata(codec);
> +	unsigned long delay;
> +
> +	/*
> +	 * FIXME
> +	 *
> +	 * PW_MGMT1 / PW_MGMT3 needs dummy write at least after 5 LR clocks
> +	 * from Power Down Release. Otherwise, Playback volume will be 0dB.
> +	 * To avoid complex multiple delayed_work call from
> +	 * ak4613_set_bias_level() / SND_SOC_DAPM_DAC_E("DACx", ...),
> +	 * call it once here.
> +	 */
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
> +		return  0;
> +
> +	delay = 5000000 / priv->rate;
> +	priv->component = &codec->component;
> +	schedule_delayed_work(&priv->dummy_write_work,
> +			      usecs_to_jiffies(delay));
> +
> +	return 0;
> +}

Please add enough descriptions that kernel's timer functionality cannot 
guarantee accuracy of expiration of timer for 5 phases of word select 
clock on usual serial sound interface, and my (and Mark's) concern about 
missing sound wave on analog part of hardware in the beginning of 
playback. Without the information, users of this codec driver will be 
puzzled in their hardware test. I can easily imagine that.

For example, 5 phases of word select clock can be calculated:
  - 0.113379 msec at 44.1 kHz
  - 0.104167 msec at 48.0 kHz
  - 0.026042 msec at 192.0 kHz

Kernel's timer service doesn't work by such accurate expiration time. At 
the best, 1 msec or more. On the other hand, typical drivers for any 
serial sound interface starts data transmission after a callback of 
.trigger.

Essentially, kernel's timer service is designed for 'rough' expiration 
to release system resources, such as socket buffer for any internet 
protocol. It surely guarantees timer expiration, but not for its accuracy.

But Mark Brown approved your idea under a certain compromise, due to 
current design of ALSA SoC part. The part includes no guarantee of 
timing to enable clocks on serial sound lines between .hw_params and 
.trigger, in my understanding.


Regards

Takashi Sakamoto

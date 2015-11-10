From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: ASoC: multicodec: No matching channels with system
 with DACs and ADCs on same bus
Date: Tue, 10 Nov 2015 17:57:41 +0000
Message-ID: <1447178261.2427.12.camel@loki>
References: <CAG5mAdzz0ZnXx_t3+G+f5FuaqfxmfRfBW6_r3vcX2Rybb3LuYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E016926526D
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 18:57:44 +0100 (CET)
In-Reply-To: <CAG5mAdzz0ZnXx_t3+G+f5FuaqfxmfRfBW6_r3vcX2Rybb3LuYg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Takashi Iwai <tiwai@suse.de>, "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, =?ISO-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau.dev@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-11-10 at 09:12 -0800, Caleb Crome wrote:
> Hi again,
>   I have a system that has separate DACs and ADCs, as opposed to
> bidirectional CODECS.
> 
> The ADCs have a snd_soc_dai_driver structure that have a .capture
> field defined with a .rates parameter, and the DACs have a
> snd_soc_dai_driver structure that have a .playback field defined with
> a .rates parameter.
> 
> However, the ADCs have no .playback.rates, and the DACs have no
> .capture.rates. Even though the ADC can record at a given rate and the
> DAC can play at that same rate, the soc_pcm_init_runtime_hw function
> calculates the rates in this loop:
> 
> ------------------------------
>     /* first calculate min/max only for CODECs in the DAI link */
>     for (i = 0; i < rtd->num_codecs; i++) {
>         codec_dai_drv = rtd->codec_dais[i]->driver;
>         if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>             codec_stream = &codec_dai_drv->playback;
>         else
>             codec_stream = &codec_dai_drv->capture;
>         chan_min = max(chan_min, codec_stream->channels_min);
>         chan_max = min(chan_max, codec_stream->channels_max);
>         rate_min = max(rate_min, codec_stream->rate_min);
>         rate_max = min_not_zero(rate_max, codec_stream->rate_max);
>         formats &= codec_stream->formats;
>         rates = snd_pcm_rate_mask_intersect(codec_stream->rates, rates);
>     }
> ------------------------------
> 
> which can't work out that one side is play only and the other is
> record only, yet they do in fact have matching rates.  So, I get a "no
> matching channels" error.
> 
> 
> Here are my example drivers declarations:
> for the ADC:
> ----------------------
> static struct snd_soc_dai_driver cs53l30_dai = {
>     .name = "cs53l30-hifi",
>     .capture = {
>         .stream_name = "Capture",
>         .channels_min = 4,
>         .channels_max = 16,
>         .rates = SNDRV_PCM_RATE_16000,
>         .formats =SNDRV_PCM_FMTBIT_S16_LE,
>     },
> };
> --------------------
> 
> and for the DAC
> 
> ----------------------
> static struct snd_soc_dai_driver tlv320dac3100_dai = {
>     .name = "tlv320dac3100-hifi",
>     .playback = {
>         .stream_name = "Playback",
>         .channels_min = 2,
>         .channels_max = 16,
>         .rates = SNDRV_PCM_RATE_16000,
>         .formats =SNDRV_PCM_FMTBIT_S16_LE,
>     },
>     .ops = &tlv320dac3100_dai_ops,
> };
> ------------------------------
> 
> I was able to fake it out by adding a .playback field to my ADC with 0
> channels, and a .capture field to my DAC with 0 channels.
> 
> My question is: what's the right way to manage this?  I assume we
> should probably tweak soc_pcm_init_runtime_hw, right?

Not sure why this is not working for you. There are other DAI drivers
upstream that are unidirectional and work fine. 

Are you combining both unidirectional DAIs above into a single
bidirectional DAI ?

Liam

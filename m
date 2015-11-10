From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: ASoC: multicodec: No matching channels with system
 with DACs and ADCs on same bus
Date: Tue, 10 Nov 2015 19:30:08 +0100
Message-ID: <564237B0.70906@metafoo.de>
References: <CAG5mAdzz0ZnXx_t3+G+f5FuaqfxmfRfBW6_r3vcX2Rybb3LuYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-224.synserver.de
 [212.40.185.224])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D63526053D
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 19:30:11 +0100 (CET)
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
To: Caleb Crome <caleb@crome.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Lu,
 Han" <han.lu@intel.com>, Takashi Iwai <tiwai@suse.de>, =?windows-1252?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau.dev@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11/10/2015 06:12 PM, Caleb Crome wrote:
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
[...]

Try the latest asoc/for-next kernel. There is a patch[1] that addresses the
issue.

- Lars

[1]
http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/sound/soc/soc-pcm.c?h=for-next&id=cde79035c6cf578dd33dfea3e39666efc27cbcf2

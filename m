From: Caleb Crome <caleb@crome.org>
Subject: Re: ASoC: multicodec: No matching channels with system
 with DACs and ADCs on same bus
Date: Tue, 10 Nov 2015 13:33:02 -0800
Message-ID: <CAG5mAdx7peaB5W2rOnZdfpF44HRY8uKZnD4ykqkBTvLaCXAJUQ@mail.gmail.com>
References: <CAG5mAdzz0ZnXx_t3+G+f5FuaqfxmfRfBW6_r3vcX2Rybb3LuYg@mail.gmail.com>
 <564237B0.70906@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B8FA261643
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 22:33:22 +0100 (CET)
Received: by wmww144 with SMTP id w144so136042359wmw.1
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 13:33:21 -0800 (PST)
In-Reply-To: <564237B0.70906@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Lu,
 Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau.dev@gmail.com>
List-Id: alsa-devel@alsa-project.org

Ah, that looks like the one!

Thanks,
 -Caleb


On Tue, Nov 10, 2015 at 10:30 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 11/10/2015 06:12 PM, Caleb Crome wrote:
>> Hi again,
>>   I have a system that has separate DACs and ADCs, as opposed to
>> bidirectional CODECS.
>>
>> The ADCs have a snd_soc_dai_driver structure that have a .capture
>> field defined with a .rates parameter, and the DACs have a
>> snd_soc_dai_driver structure that have a .playback field defined with
>> a .rates parameter.
>>
>> However, the ADCs have no .playback.rates, and the DACs have no
>> .capture.rates. Even though the ADC can record at a given rate and the
>> DAC can play at that same rate, the soc_pcm_init_runtime_hw function
>> calculates the rates in this loop:
>>
>> ------------------------------
>>     /* first calculate min/max only for CODECs in the DAI link */
>>     for (i = 0; i < rtd->num_codecs; i++) {
>>         codec_dai_drv = rtd->codec_dais[i]->driver;
>>         if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>             codec_stream = &codec_dai_drv->playback;
>>         else
>>             codec_stream = &codec_dai_drv->capture;
>>         chan_min = max(chan_min, codec_stream->channels_min);
>>         chan_max = min(chan_max, codec_stream->channels_max);
>>         rate_min = max(rate_min, codec_stream->rate_min);
>>         rate_max = min_not_zero(rate_max, codec_stream->rate_max);
>>         formats &= codec_stream->formats;
>>         rates = snd_pcm_rate_mask_intersect(codec_stream->rates, rates);
>>     }
>> ------------------------------
>>
>> which can't work out that one side is play only and the other is
>> record only, yet they do in fact have matching rates.  So, I get a "no
>> matching channels" error.
> [...]
>
> Try the latest asoc/for-next kernel. There is a patch[1] that addresses the
> issue.
>
> - Lars
>
> [1]
> http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/sound/soc/soc-pcm.c?h=for-next&id=cde79035c6cf578dd33dfea3e39666efc27cbcf2
>

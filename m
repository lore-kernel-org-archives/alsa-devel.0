From: Caleb Crome <caleb@crome.org>
Subject: ASoC: multicodec: No matching channels with system
 with DACs and ADCs on same bus
Date: Tue, 10 Nov 2015 09:12:21 -0800
Message-ID: <CAG5mAdzz0ZnXx_t3+G+f5FuaqfxmfRfBW6_r3vcX2Rybb3LuYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 79F6A265262
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 18:12:41 +0100 (CET)
Received: by wmec201 with SMTP id c201so144321556wme.0
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 09:12:41 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Lu,
 Han" <han.lu@intel.com>, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau.dev@gmail.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi again,
  I have a system that has separate DACs and ADCs, as opposed to
bidirectional CODECS.

The ADCs have a snd_soc_dai_driver structure that have a .capture
field defined with a .rates parameter, and the DACs have a
snd_soc_dai_driver structure that have a .playback field defined with
a .rates parameter.

However, the ADCs have no .playback.rates, and the DACs have no
.capture.rates. Even though the ADC can record at a given rate and the
DAC can play at that same rate, the soc_pcm_init_runtime_hw function
calculates the rates in this loop:

------------------------------
    /* first calculate min/max only for CODECs in the DAI link */
    for (i = 0; i < rtd->num_codecs; i++) {
        codec_dai_drv = rtd->codec_dais[i]->driver;
        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
            codec_stream = &codec_dai_drv->playback;
        else
            codec_stream = &codec_dai_drv->capture;
        chan_min = max(chan_min, codec_stream->channels_min);
        chan_max = min(chan_max, codec_stream->channels_max);
        rate_min = max(rate_min, codec_stream->rate_min);
        rate_max = min_not_zero(rate_max, codec_stream->rate_max);
        formats &= codec_stream->formats;
        rates = snd_pcm_rate_mask_intersect(codec_stream->rates, rates);
    }
------------------------------

which can't work out that one side is play only and the other is
record only, yet they do in fact have matching rates.  So, I get a "no
matching channels" error.


Here are my example drivers declarations:
for the ADC:
----------------------
static struct snd_soc_dai_driver cs53l30_dai = {
    .name = "cs53l30-hifi",
    .capture = {
        .stream_name = "Capture",
        .channels_min = 4,
        .channels_max = 16,
        .rates = SNDRV_PCM_RATE_16000,
        .formats =SNDRV_PCM_FMTBIT_S16_LE,
    },
};
--------------------

and for the DAC

----------------------
static struct snd_soc_dai_driver tlv320dac3100_dai = {
    .name = "tlv320dac3100-hifi",
    .playback = {
        .stream_name = "Playback",
        .channels_min = 2,
        .channels_max = 16,
        .rates = SNDRV_PCM_RATE_16000,
        .formats =SNDRV_PCM_FMTBIT_S16_LE,
    },
    .ops = &tlv320dac3100_dai_ops,
};
------------------------------

I was able to fake it out by adding a .playback field to my ADC with 0
channels, and a .capture field to my DAC with 0 channels.

My question is: what's the right way to manage this?  I assume we
should probably tweak soc_pcm_init_runtime_hw, right?

Thanks,
  -Caleb

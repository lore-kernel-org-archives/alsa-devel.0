From: anish kumar <yesanishhere@gmail.com>
Subject: DAPM: codec to codec link documentation[RFC]
Date: Wed, 14 Sep 2016 12:08:56 -0700
Message-ID: <CABCoZhDD3QhFXCKM59Di9zUTJ1=TT42D-HN=bD05yOUORHVSsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f169.google.com (mail-yb0-f169.google.com
 [209.85.213.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 64D482664FB
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2016 21:08:57 +0200 (CEST)
Received: by mail-yb0-f169.google.com with SMTP id u125so20483159ybg.3
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2016 12:08:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linux-ALSA <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles <Charles.Keepax@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I had a tough time figuring out how to get codec to codec link to work.
So thought of making it easier for other people who wants to use the same.

I will appreciate any inputs for below documentation. Excuse my diagrams
if it doesn't render on your browser. I am still learning as how to best
draw txt diagrams.

Mostly the flow of audio is always from CPU to codec so your system
will look as below:

 ----------               ----------
|            |  dai      |            |
    CPU  ------->    codec
|            |             |            |
 ----------               ----------

In case your system looks as below:
                            ----------
                           |            |
                            codec-2
                           |            |
                            ----------
                                 |
                              dai-2
                                 |
 ----------               ----------
|            |  dai-1    |            |
    CPU    ------->  codec-1
|            |              |            |
 ----------                ----------
                                 |
                              dai-3
                                 |
                             ----------
                            |            |
                             codec-3
                            |            |
                             ----------

Suppose codec-2 is a bluetooth chip and codec-3 is connected to
a speaker and you have a below scenario:
codec-2 will receive the audio data and the user wants to play that
audio through codec-3 without involving the CPU.This
aforementioned case is the ideal case when codec to codec
connection should be used.

Your dai_link should appear as below in your machine
file:

static const struct snd_soc_pcm_stream dummy_params = {
        .formats = SNDRV_PCM_FMTBIT_S24_LE,
        .rate_min = 48000,
        .rate_max = 48000,
        .channels_min = 2,
        .channels_max = 2,
};

{
    .name = "your_name",
    .stream_name = "your_stream_name",
    .cpu_dai_name = "snd-soc-dummy-dai",
    .codec_name = "codec-2,
    .codec_dai_name = "codec-2-dai_name",
    .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
                    | SND_SOC_DAIFMT_CBM_CFM,
    .ignore_suspend = 1,
    .params = &dummy_params,
},
{
    .name = "your_name",
    .stream_name = "your_stream_name",
    .cpu_dai_name = "snd-soc-dummy-dai",
    .codec_name = "codec-3,
    .codec_dai_name = "codec-3-dai_name",
    .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
                    | SND_SOC_DAIFMT_CBM_CFM,
    .ignore_suspend = 1,
    .params = &dummy_params,
},

Note the "params" callback which lets the dapm know that this
dai_link is a codec to codec connection.
Also, in above code cpu_dai should be replaced with your actual
cpu dai but in case you don't have a actual cpu dai then dummy will
do.

You can browse the speyside.c for an actual example code in mainline.

In dapm core a route is created between cpu_dai playback widget
and codec_dai capture widget for playback path and vice-versa is
true for capture path. In order for this aforementioned route to get
triggered, DAPM needs to find a valid endpoint which could be either
a sink or source widget corresponding to playback and capture path
respectively.

Below is what you can use it to trigger the widgets provided you have
stream name ending with "Playback" and "Capture" for cpu and
codec dai's.

static const struct snd_soc_dapm_widget aif_dapm_widgets[] = {
        SND_SOC_DAPM_SPK("dummyspk", NULL),
        SND_SOC_DAPM_MIC("dummymic", NULL),
};

static const struct snd_soc_dapm_route audio_i2s_map[] = {
        {"dummyspk", NULL, "Playback"},
        {"Capture", NULL, "dummymic"},
};

Thanks,

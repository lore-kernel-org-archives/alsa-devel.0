From: JongHo Kim <furmuwon@gmail.com>
Subject: Re: ASoC : playback and capture counts in soc_new_pcm
Date: Tue, 5 Mar 2013 16:55:51 +0900
Message-ID: <CANXQt8ans6uVNqT2V7MuGuRu47fLE-2vWaegBYOTxnAezZ7GZg@mail.gmail.com>
References: <CANXQt8a6XyQVgb50+e-jQ-QXn5d-fS_AGZZrnXo4oU9WOQbKXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
 [209.85.160.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CD99264FFF
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2013 08:55:52 +0100 (CET)
Received: by mail-pb0-f54.google.com with SMTP id rr4so4072224pbb.27
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2013 23:55:52 -0800 (PST)
In-Reply-To: <CANXQt8a6XyQVgb50+e-jQ-QXn5d-fS_AGZZrnXo4oU9WOQbKXw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2013/3/5 JongHo Kim <furmuwon@gmail.com>

> Hi I am developing the ALSA ASoC part. I has some problem.
> Now my situation must only use the cpu_dai(AP I2S IP) to half duplex.
> So, I want to allocate either a capture substream or a playback substream.
> But ASoC(soc-pcm.c) referred to the playback(capture)_channel_min of
> codec_dai
> at the calling snd_pcm_new in soc_new_pcm.
> I do not want to modify the codec_dai codes.
> As a result, hope to see below
>
> /dev/snd/pcmC0D0p
> /dev/snd/pcmC0D1c
>
> attach the ASCII schematic diagram.
>
> Slaves                          Master
> +--------------+               +-----------------+
> |I2S.0 data_out|---------------|data_in(AIF1)    |
> |I2S.0 bclk    |-------+-------|bclk             |
> |I2S.0 lrclk   |-------|--+----|lrclk            |
> +--------------+       |  |    |                 |
> +--------------+       |  |    |   AUDIO CODEC   |
> |I2S.1 bclk    |-------+  |    |                 |
> |I2S.1 lrclk   |----------+    |                 |
> |I2S.1 data_in |---------------|data_out(AIF1)   |
> +--------------+               +-----------------+
>
> attach the i2s and dai_link codes.
>
> -----------------------------------------------------------------------------
> static struct snd_soc_dai_driver board_i2s_dai_hf_playback_template = {
>  .probe = board_i2s_probe,
> .playback = {
>  .stream_name = "Playback",
> .channels_min = 1,
>  .channels_max = 2,
> .rates = SNDRV_PCM_RATE_8000_96000,
>  .formats = SNDRV_PCM_FMTBIT_S16_LE,
> },
>  .ops = &board_i2s_dai_ops,
> };
>
> static struct snd_soc_dai_driver board_i2s_dai_hf_capture_template = {
> .probe = board_i2s_probe,
>  .capture = {
> .stream_name = "Capture",
>  .channels_min = 1,
> .channels_max = 2,
>  .rates = SNDRV_PCM_RATE_8000_96000,
> .formats = SNDRV_PCM_FMTBIT_S16_LE,
>  },
> .ops = &board_i2s_dai_ops,
> };
>
> static struct snd_soc_dai_link board_dai[] = {
> {
>  .name = "audcodec_l0",
> .stream_name = "audcodec HiFi",
>  .cpu_dai_name = "board-i2s.0",
> .codec_dai_name = "audcodec-aif1",
>  .platform_name = "board-pcm-audio",
> .codec_name = "audcodec-codec",
>  .ops = &board_ops,
> },
>  {
> .name = "audcodec_l1",
>  .stream_name = "audcodec HiFi",
> .cpu_dai_name = "board-i2s.1",
>  .codec_dai_name = "audcodec-aif1",
> .platform_name = "board-pcm-audio",
>  .codec_name = "audcodec-codec",
> .ops = &board_ops,
>  },
> };
>
> -----------------------------------------------------------------------------
>
> So, I suggest the next diff.
>
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2014,9 +2014,11 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd,
> int num)
>                 if (cpu_dai->driver->capture.channels_min)
>                         capture = 1;
>         } else {
> -               if (codec_dai->driver->playback.channels_min)
> +               if (codec_dai->driver->playback.channels_min &&
> +                   cpu_dai->driver->playback.channels_min)
>                         playback = 1;
> -               if (codec_dai->driver->capture.channels_min)
> +               if (codec_dai->driver->playback.channels_min &&
> +                   cpu_dai->driver->playback.channels_min)
>                         capture = 1;
>         }
>

oh! my bad :(

--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2014,9 +2014,11 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int
num)
                if (cpu_dai->driver->capture.channels_min)
                        capture = 1;
        } else {
-               if (codec_dai->driver->playback.channels_min)
+               if (codec_dai->driver->playback.channels_min &&
+                   cpu_dai->driver->playback.channels_min)
                        playback = 1;
-               if (codec_dai->driver->capture.channels_min)
+               if (codec_dai->driver->capture.channels_min &&
+                   cpu_dai->driver->capture.channels_min)
                        capture = 1;
        }

>
> Thanks.
>

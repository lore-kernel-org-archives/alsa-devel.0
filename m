From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: DAPM: codec to codec link documentation[RFC]
Date: Thu, 15 Sep 2016 09:33:21 +0100
Message-ID: <20160915083321.GO21682@localhost.localdomain>
References: <CABCoZhDD3QhFXCKM59Di9zUTJ1=TT42D-HN=bD05yOUORHVSsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id CBF32266D08
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2016 10:33:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CABCoZhDD3QhFXCKM59Di9zUTJ1=TT42D-HN=bD05yOUORHVSsg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles <Charles.Keepax@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 14, 2016 at 12:08:56PM -0700, anish kumar wrote:
> Hello,
> 
> I had a tough time figuring out how to get codec to codec link to work.
> So thought of making it easier for other people who wants to use the same.
> 
> I will appreciate any inputs for below documentation. Excuse my diagrams
> if it doesn't render on your browser. I am still learning as how to best
> draw txt diagrams.
> 
> Mostly the flow of audio is always from CPU to codec so your system
> will look as below:
> 
>  ----------               ----------
> |            |  dai      |            |
>     CPU  ------->    codec
> |            |             |            |
>  ----------               ----------
> 
> In case your system looks as below:
>                             ----------
>                            |            |
>                             codec-2
>                            |            |
>                             ----------
>                                  |
>                               dai-2
>                                  |
>  ----------               ----------
> |            |  dai-1    |            |
>     CPU    ------->  codec-1
> |            |              |            |
>  ----------                ----------
>                                  |
>                               dai-3
>                                  |
>                              ----------
>                             |            |
>                              codec-3
>                             |            |
>                              ----------
> 
> Suppose codec-2 is a bluetooth chip and codec-3 is connected to
> a speaker and you have a below scenario:
> codec-2 will receive the audio data and the user wants to play that
> audio through codec-3 without involving the CPU.This
> aforementioned case is the ideal case when codec to codec
> connection should be used.
> 
> Your dai_link should appear as below in your machine
> file:
> 
> static const struct snd_soc_pcm_stream dummy_params = {
>         .formats = SNDRV_PCM_FMTBIT_S24_LE,
>         .rate_min = 48000,
>         .rate_max = 48000,
>         .channels_min = 2,
>         .channels_max = 2,
> };
> 

Dummy params is probably not the best name here as this is
setting the actual params for the link.

> {
>     .name = "your_name",
>     .stream_name = "your_stream_name",
>     .cpu_dai_name = "snd-soc-dummy-dai",
>     .codec_name = "codec-2,
>     .codec_dai_name = "codec-2-dai_name",
>     .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
>                     | SND_SOC_DAIFMT_CBM_CFM,
>     .ignore_suspend = 1,
>     .params = &dummy_params,
> },
> {
>     .name = "your_name",
>     .stream_name = "your_stream_name",
>     .cpu_dai_name = "snd-soc-dummy-dai",
>     .codec_name = "codec-3,
>     .codec_dai_name = "codec-3-dai_name",
>     .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
>                     | SND_SOC_DAIFMT_CBM_CFM,
>     .ignore_suspend = 1,
>     .params = &dummy_params,
> },
> 

Probably worth having a look at DT options as well, not sure how
well would be supported for c2c links at the mo but probably
worth mentioning something about it.

> Note the "params" callback which lets the dapm know that this
> dai_link is a codec to codec connection.
> Also, in above code cpu_dai should be replaced with your actual
> cpu dai but in case you don't have a actual cpu dai then dummy will
> do.
> 
> You can browse the speyside.c for an actual example code in mainline.
> 
> In dapm core a route is created between cpu_dai playback widget
> and codec_dai capture widget for playback path and vice-versa is
> true for capture path. In order for this aforementioned route to get
> triggered, DAPM needs to find a valid endpoint which could be either
> a sink or source widget corresponding to playback and capture path
> respectively.
> 
> Below is what you can use it to trigger the widgets provided you have
> stream name ending with "Playback" and "Capture" for cpu and
> codec dai's.
> 
> static const struct snd_soc_dapm_widget aif_dapm_widgets[] = {
>         SND_SOC_DAPM_SPK("dummyspk", NULL),
>         SND_SOC_DAPM_MIC("dummymic", NULL),
> };
> 
> static const struct snd_soc_dapm_route audio_i2s_map[] = {
>         {"dummyspk", NULL, "Playback"},
>         {"Capture", NULL, "dummymic"},
> };

For mainline it would likely be expected you would create a very
thin codec driver for the speaker amp rather than doing this sort
of thing, as that at least sets appropriate constraints for the
device even if it needs no control. For an example of such a
driver you can see:

sound/soc/codecs/wm8727.c

Thanks,
Charles

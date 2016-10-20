From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Codec to codec dai link description
Date: Thu, 20 Oct 2016 10:44:07 +0100
Message-ID: <20161020094407.GL3207@localhost.localdomain>
References: <CABCoZhDiBxGHbZopLqkkMALozAt9eO2ANNT9puRy12Ez_oZstQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A30E2657DF
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 11:44:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CABCoZhDiBxGHbZopLqkkMALozAt9eO2ANNT9puRy12Ez_oZstQ@mail.gmail.com>
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
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 19, 2016 at 11:00:37PM -0700, anish kumar wrote:
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
>  Documentation/sound/alsa/soc/codec_to_codec.txt | 114 ++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 Documentation/sound/alsa/soc/codec_to_codec.txt
> 
> diff --git a/Documentation/sound/alsa/soc/codec_to_codec.txt
> b/Documentation/sound/alsa/soc/codec_to_codec.txt
> new file mode 100644
> index 0000000..b0f221d
> --- /dev/null
> +++ b/Documentation/sound/alsa/soc/codec_to_codec.txt
> @@ -0,0 +1,114 @@
> +Creating codec to codec dai link for ALSA dapm
> +===================================================
> +
> +Mostly the flow of audio is always from CPU to codec so your system
> +will look as below:
> +
> + ----------         ---------
> +|         |  dai   |         |
> +    CPU    ------->    codec
> +|         |        |         |
> + ---------          ---------
> +
> +In case your system looks as below:
> +                     ---------
> +                    |         |
> +                      codec-2
> +                    |         |
> +                     ---------
> +                         |
> +                       dai-2
> +                         |
> + ----------          ---------
> +|          |  dai-1 |         |
> +    CPU     ------->  codec-1
> +|          |        |         |
> + ----------          ---------
> +                         |
> +                       dai-3
> +                         |
> +                     ---------
> +                    |         |
> +                      codec-3
> +                    |         |
> +                     ---------
> +
> +Suppose codec-2 is a bluetooth chip and codec-3 is connected to
> +a speaker and you have a below scenario:
> +codec-2 will receive the audio data and the user wants to play that
> +audio through codec-3 without involving the CPU.This
> +aforementioned case is the ideal case when codec to codec
> +connection should be used.
> +
> +Your dai_link should appear as below in your machine
> +file:
> +
> +static const struct snd_soc_pcm_stream dummy_params = {

Still not sure I like the name dummy_params its not really a
dummy its specifying how the link will be configured.

> +        .formats = SNDRV_PCM_FMTBIT_S24_LE,
> +        .rate_min = 48000,
> +        .rate_max = 48000,
> +        .channels_min = 2,
> +        .channels_max = 2,
> +};
> +
> +{
> +    .name = "your_name",
> +    .stream_name = "your_stream_name",
> +    .cpu_dai_name = "snd-soc-dummy-dai",

Not sure we should be using dummies in the example we wouldn't
expect people to use the dummy in a real system so my thinking
would be it shouldn't look like that in the documentation.

> +    .codec_name = "codec-2,
> +    .codec_dai_name = "codec-2-dai_name",
> +    .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> +                    | SND_SOC_DAIFMT_CBM_CFM,
> +    .ignore_suspend = 1,
> +    .params = &dummy_params,
> +},
> +{
> +    .name = "your_name",
> +    .stream_name = "your_stream_name",
> +    .cpu_dai_name = "snd-soc-dummy-dai",
> +    .codec_name = "codec-3,
> +    .codec_dai_name = "codec-3-dai_name",
> +    .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
> +                    | SND_SOC_DAIFMT_CBM_CFM,
> +    .ignore_suspend = 1,
> +    .params = &dummy_params,
> +},
> +
> +Note the "params" callback which lets the dapm know that this
> +dai_link is a codec to codec connection.
> +Also, in above code cpu_dai should be replaced with your actual
> +cpu dai but in case you don't have a actual cpu dai then dummy will
> +do.

Again here not sure we should mention the dummy here.

> +
> +You can browse the speyside.c for an actual example code in mainline.
> +
> +Note that in current device tree there is no way to mark a dai_link
> +as codec to codec. However, it may change in future.
> +
> +In dapm core a route is created between cpu_dai playback widget
> +and codec_dai capture widget for playback path and vice-versa is
> +true for capture path. In order for this aforementioned route to get
> +triggered, DAPM needs to find a valid endpoint which could be either
> +a sink or source widget corresponding to playback and capture path
> +respectively.
> +
> +Below is what you can use it to trigger the widgets provided you have
> +stream name ending with "Playback" and "Capture" for cpu and
> +codec dai's.
> +
> +static const struct snd_soc_dapm_widget aif_dapm_widgets[] = {
> +        SND_SOC_DAPM_SPK("dummyspk", NULL),
> +        SND_SOC_DAPM_MIC("dummymic", NULL),
> +};
> +
> +static const struct snd_soc_dapm_route audio_i2s_map[] = {
> +        {"dummyspk", NULL, "Playback"},
> +        {"Capture", NULL, "dummymic"},
> +};

I would still be tempted to leave the part with aif_dapm_widgets
out. Its showing bad practice and the documentation should be
advising people just to link up two CODEC drivers.

> +
> +Above code is good for quick testing but in order to mainline it
> +you are expected to create a thin codec driver for the speaker
> +amp rather than doing this sort of thing, as that at least
> +sets appropriate constraints for the device even if it needs
> +no control. For an example of such a driver you can see:
> +sound/soc/codecs/wm8727.c

Only some minor comments, but it generally looks good thanks for
doing this.

Thanks,
Charles

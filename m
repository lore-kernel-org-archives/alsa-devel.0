From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 06/14] ASoC: sun4i-codec: Add support for A31 playback
 through headphone output
Date: Fri, 4 Nov 2016 09:08:11 +0800
Message-ID: <CAGb2v65CZJ+1LTWWk3+vABV8PDgsDta+nZ7o3H2Z--KFPe2kog@mail.gmail.com>
References: <20161103075556.29018-1-wens@csie.org> <20161103075556.29018-7-wens@csie.org>
 <20161103173602.zchyciwj66zdibc7@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161103173602.zchyciwj66zdibc7@lukather>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 4, 2016 at 1:36 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Nov 03, 2016 at 03:55:48PM +0800, Chen-Yu Tsai wrote:
>> +/* headphone controls */
>> +static const char * const sun6i_codec_hp_src_enum_text[] = {
>> +     "DAC", "Mixer",
>> +};
>> +
>> +static SOC_ENUM_DOUBLE_DECL(sun6i_codec_hp_src_enum,
>> +                         SUN6I_CODEC_OM_DACA_CTRL,
>> +                         SUN6I_CODEC_OM_DACA_CTRL_LHPIS,
>> +                         SUN6I_CODEC_OM_DACA_CTRL_RHPIS,
>> +                         sun6i_codec_hp_src_enum_text);
>> +
>> +static const struct snd_kcontrol_new sun6i_codec_hp_src[] = {
>> +     SOC_DAPM_ENUM("Headphone Source Playback Route",
>> +                   sun6i_codec_hp_src_enum),
>> +};
>
> What is that route exactly? A muxer?

Yup. The following is part of the widgets list later in the code:

+       /* Headphone output path */
+       SND_SOC_DAPM_MUX("Headphone Source Playback Route",
+                        SND_SOC_NOPM, 0, 0, sun6i_codec_hp_src),

ChenYu

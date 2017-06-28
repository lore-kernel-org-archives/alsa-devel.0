From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] Re: [PATCH v13 05/14] ASoC:
 sun4i-codec: Merge sun4i_codec_left_mixer_controls and
 sun4i_codec_right_mixer_controls into sun4i_codec_mixer_controls.
Date: Wed, 28 Jun 2017 16:38:48 +0800
Message-ID: <CAGb2v66eUNbBwLXH8Sk8zQUTOQFdRYmyWytm3tfxBGa8CL_Bew@mail.gmail.com>
References: <20170624062419.23778-1-dannym@scratchpost.org>
 <20170624062419.23778-6-dannym@scratchpost.org>
 <CAGb2v64i_S5HCsLHJGg0WbkFodOFFc5masUYQ53JaLTO7N2BMw@mail.gmail.com>
 <20170626192100.h5o366tawcnkqosx@flea.lan>
 <20170628102520.29c50592@scratchpost.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 2956A267065
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 10:39:16 +0200 (CEST)
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com
 [209.85.214.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 3C23C208F3
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 16:39:11 +0800 (CST)
Received: by mail-it0-f50.google.com with SMTP id v202so26170762itb.0
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 01:39:11 -0700 (PDT)
In-Reply-To: <20170628102520.29c50592@scratchpost.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Danny Milosavljevic <dannym@scratchpost.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 28, 2017 at 4:25 PM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> Hi,
>
>> > > -static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
>> > > -       SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
>> > > -                       SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
>> > > -};
>> > > -
>> > > -static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
>> > > -       SOC_DAPM_SINGLE("Right DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
>> > > +static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
>> > > +       SOC_DAPM_DOUBLE("DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
>> > > +                       SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
>> > >                         SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
>> >
>> > This changes the mixer control names exposed to userspace. While I think
>> > consolidating mixer controls is nice, giving the user a less cluttered
>> > view, I'm not sure about the changing a possible userspace ABI.
>> >
>> > Maxime, ALSA and ASoC people, any comments about this?
>
>>Yeah, breaking userspace is definitely not ok.
>
> Okay.  I can restore DAC Playback Switch as two different controls with the same
> names as before.
>
> Is the mixer itself (SND_SOC_DAPM_MIXER) - not talking about its controls -
> exposed to userspace?

Other than debugfs, no it is not.

> Because if not, I can still merge the left mixer and right mixer and just fix up
> the control names for DAC Playback Switch to be the same as before, something
> like this:
>
> static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
>         SOC_DAPM_SINGLE("Left Mixer Left DAC Playback Switch", // !!!
>                         SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
>         SOC_DAPM_SINGLE("Right Mixer Right DAC Playback Switch", // !!!
>                         SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
>         SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
>                         SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
>         SOC_DAPM_DOUBLE("Line Playback Switch", SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_LLNS,
>                         SUN4I_CODEC_DAC_ACTL_RLNS, 1, 0),
>         SOC_DAPM_DOUBLE("FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_LFMS,
>                         SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
>         SOC_DAPM_DOUBLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_MIC1LS,
>                         SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
>         SOC_DAPM_DOUBLE("Mic2 Playback Switch", SUN4I_CODEC_DAC_ACTL,
>                         SUN4I_CODEC_DAC_ACTL_MIC2LS,
>                         SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),
> };
>
> static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
> ...
>         SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
>                            sun4i_codec_mixer_controls,
>                            ARRAY_SIZE(sun4i_codec_mixer_controls)), // !!!
>         SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
>                            sun4i_codec_mixer_controls,
>                            ARRAY_SIZE(sun4i_codec_mixer_controls)), // !!!
> };
>
> Would this be a good way?

I think that would work. We would need to verify that the DAPM routing
graph for the existing single channel controls work as intended though.

ChenYu

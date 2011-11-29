From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH] ASoC: Tegra: Add support of tegra boards
 based on ALC5632 codec
Date: Tue, 29 Nov 2011 07:35:44 +0200
Message-ID: <CALq1K=KobQ3f3LtBmyiCYPizEVD=XV8aAtbLLzQWxEWQb1sdZg@mail.gmail.com>
References: <1321906088-29964-1-git-send-email-leon@leon.nu>
	<74CDBE0F657A3D45AFBB94109FB122FF174F08C817@HQMAIL01.nvidia.com>
	<CALq1K=LOLUmK48X7wbycAq2rJmynU08H4Y7qL-8+cZCALgGgVA@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF174FDAF7CE@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id DEDE824407
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 06:36:05 +0100 (CET)
Received: by laam7 with SMTP id m7so855091laa.38
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 21:36:05 -0800 (PST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174FDAF7CE@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2011 at 18:52, Stephen Warren <swarren@nvidia.com> wrote:

> Leon Romanovsky wrote at Sunday, November 27, 2011 1:48 AM:
> > On Wed, Nov 23, 2011 at 23:50, Stephen Warren <swarren@nvidia.com>
> wrote:
> > > Leon Romanovsky wrote at Monday, November 21, 2011 1:08 PM:
> > >> At this stage only Toshiba AC100/Dynabook supported.
> > > ...
> > >> diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
> > > ...
> > >> +config SND_SOC_TEGRA_ALC5632
> > >> +     tristate "SoC Audio support for Tegra boards using an ALC5632
> codec"
> > >> +     depends on SND_SOC_TEGRA && I2C
> > >> +     select SND_SOC_TEGRA_I2S
> > >> +     select SND_SOC_ALC5632
> > >> +     help
> > >> +       Say Y or M here if you want to add support for SoC audio on
> the
> > >> +       Toshiba AC100 netbook.
> > >
> > > If this is going to be named tegra_acl5632 rather than something board-
> > > specific such as tegra_paz00, then perhaps you should do Kconfig the
> > > same way as the tegra_wm8903 driver; have a
> MACH_HAS_SND_SOC_TEGRA_ALC5632
> > > variable that boards need to select, and make this depend on that?
> >
> > I saw in the Kconfing MACH_HAS_SND_SOC_TEGRA_WM8903, but don't know if
> > it is necessary, because no one use it.
> > Do I need to do the same in our case too?
>
> Well, I suppose we can always add this later if we need.
>
> Thinking about this more though, with the moved to device-tree, having
> such a variable isn't that useful, since the arch/arm/mach-tegra side
> won't have individual machine Kconfig options that'll allow selecting
> this driver.
>
> So, it's fine the way it is.
>
> > >> diff --git a/sound/soc/tegra/tegra_alc5632.c
> b/sound/soc/tegra/tegra_alc5632.c
> > > ...
> > >> +static int tegra_alc5632_asoc_hw_params(struct snd_pcm_substream
> *substream,
> > >> +                                     struct snd_pcm_hw_params
> *params)
> > > ...
> > >> +     srate = params_rate(params);
> > >> +     switch (srate) {
> > >> +     case 64000:
> > >> +     case 88200:
> > >> +     case 96000:
> > >> +             mclk = 128 * srate;
> > >> +             break;
> > >> +     default:
> > >> +             mclk = 512 * srate;
> > >> +             break;
> > >> +     }
> > >> +     /* FIXME: Codec only requires >= 3MHz if OSR==0 */
> > >> +     while (mclk < 6000000)
> > >> +             mclk *= 2;
> > >
> > > That is identical to the code in tegra_wm8903. Are you sure it's
> correct
> > > for the ALC5632? At the very least, I think the comment is wrong; OSR
> is
> > > a WM8903 register field, which I doubt exists on the ALC5632.
> >
> > The code started from the harmony board file, there are possibilities
> > it is not necessary.
>
> Mark pointed out that this might be correct anyway. Still, I'd ask that
> you check the codec's datasheet to be sure.
>
Sure

>
> > >> +static struct snd_soc_jack_gpio tegra_alc5632_hs_jack_gpios[] = {
> > >> +     {
> > >> +             .name = "Headset Detect",
> > >> +             .report = SND_JACK_HEADSET,
> > >> +             .debounce_time = 150,
> > >> +     }
> > >> +};
> > >
> > > You probably don't want to make this an array, since that'll make the
> > > code that fills in tegra_alc5632_hs_jack_gpio [0].gpio have to
> hard-code
> > > the "0" array index; better to make this just:
> >
> > This is something, I never understand. There are plenty
> > implementations which use SND_JACK_HEADSET and plenty which prefer to
> > separate it.
> > What is the guideline?
>
> I don't quite understand your response. I was simply pointing out that
> The code above would be simpler as:
>
> static struct snd_soc_jack_gpio tegra_alc5632_hs_jack_gpio = {
>      .name = "Headset Detect",
>      .report = SND_JACK_HEADSET,
>     .debounce_time = 150,
> };
>

Thanks, I previously missed the difference:
 static struct snd_soc_jack_gpio tegra_alc5632_hs_jack_gpios[]
-----> static struct snd_soc_jack_gpio tegra_alc5632_hs_jack_gpio


> This was review feedback from Mark on other Tegra ASoC machine drivers.
>
> It's plausible there are machines which don't format it that way. Still,
> when adding new ones, we may as well follow best practices if possible.
>
> > >> +static const struct snd_soc_dapm_route tegra_alc5632_audio_map[] = {
> > >> +     /* Internal Mic */
> > >> +     {"MIC2", NULL, "Mic Bias 2"},
> > >> +     {"Mic Bias 2", NULL, "Int Mic"},
> > >
> > > Yay, a separate mic bias for each microphone:-)
> > Is it wrong? Our codec support two microphones, and two different biases.
>
> My comment was re: the design of the Harmony board, which is difficult
> to fully support in HW. It's good that there are two mic bias pins. I
> see no issue with your code.
>
> --
> nvpublic
>
>
Thanks for the review, I'll post updated patch in the next few days.



-- 
Leon Romanovsky | Independent Linux Consultant
        www.leon.nu | leon@leon.nu

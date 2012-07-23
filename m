From: Lee Jones <lee.jones@linaro.org>
Subject: Help request - ASoC recursion issue
Date: Mon, 23 Jul 2012 15:05:19 +0100
Message-ID: <500D5A1F.9000808@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I was wondering if I may bother you for some help. I've been having=20
serious issues with testing the new mop500 sound system you have in you=
r=20
ASoC for-next branch. I've fixed a few issues and will be submitting=20
patches shortly. The most serious issue I came across was with=20
recursion. Let me show you:

So here we setup the power_check function pointer with=20
'dapm_supply_check_power()'.

> static struct snd_soc_dapm_widget *
> snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
> 			 const struct snd_soc_dapm_widget *widget)
> {
<snip>
> 	case snd_soc_dapm_regulator_supply:
> 	case snd_soc_dapm_clock_supply:
> 		w->power_check =3D dapm_supply_check_power;
> 		break;
<snip>
> }

Later we call 'dapm_widget_power_check()' which calls into the function=
=20
pointer we know to be 'dapm_supply_check_power()'.

 > static int dapm_widget_power_check(struct snd_soc_dapm_widget *w)
 > {
 > 	if (w->power_checked)
 > 		return w->new_power;
 >
 > 	if (w->force)
 > 		w->new_power =3D 1;
 > 	else
 > 		w->new_power =3D w->power_check(w);
 >
 > 	w->power_checked =3D true;
 >
 > 	return w->new_power;
 > }

The problem seems to be that 'dapm_supply_check_power()' then calls bac=
k=20
into 'dapm_widget_power_check()'. Then round and round we go!

> /* Check to see if a power supply is needed */
> static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
> {
<snip>
> 	/* Check if one of our outputs is connected */
> 	list_for_each_entry(path, &w->sinks, list_source) {
> 		DAPM_UPDATE_STAT(w, neighbour_checks);
>
> 		if (path->weak)
> 			continue;
>
> 		if (path->connected &&
> 		    !path->connected(path->source, path->sink))
> 			continue;
>
> 		if (!path->sink)
> 			continue;
>
> 		if (dapm_widget_power_check(path->sink))     /* <-- Doh! */
> 			return 1;
> 	}
<snip>
> }

Can you shed some light on what the correct solution might be?

Any help would be gratefully received.

Kind regards,
Lee

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

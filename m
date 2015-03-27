From: yakir <ykk@rock-chips.com>
Subject: Re: [PATCH v4 14/15] ASoC: rockchip/rockchip-hdmi-audio: add sound
 driver for hdmi audio
Date: Fri, 27 Mar 2015 09:16:17 +0800
Message-ID: <5514AF61.2050909@rock-chips.com>
References: <1425175834-24661-1-git-send-email-ykk@rock-chips.com> <1425179070-2736-1-git-send-email-ykk@rock-chips.com> <20150326181620.GZ3572@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150326181620.GZ3572@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, David Airlie <airlied@linux.ie>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Andy Yan <andy.yan@rock-chips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@freescale.com>, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Max Filippov <jcmvbkbc@gmail.com>, Axel Lin <axel.lin@ingics.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Sean Cross <xobs@kosagi.com>, Ben Zhang <benzh@chromium.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, mmind00@googlemail.c
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 2015=E5=B9=B403=E6=9C=8827=E6=97=A5 02:16, Mark Brown wrote:
> On Sat, Feb 28, 2015 at 10:04:30PM -0500, Yakir Yang wrote:
>
>> +	ret =3D snd_soc_dai_set_fmt(cpu_dai, dai_fmt);
>> +	if (ret < 0) {
>> +		dev_err(cpu_dai->dev, "failed to set cpu_dai fmt.\n");
>> +		return ret;
>> +	}
> You've already set this in the dai_link, no need to do it again.

Okay, correct it in next v5.


> +	dev_info(&pdev->dev, "hdmi audio init success.\n");
> Please remove noisy prints like this.

Okay, turn it to dev_debug(...)

>> +free_cpu_of_node:
>> +	hdmi_audio_dai.cpu_of_node =3D NULL;
>> +	hdmi_audio_dai.platform_of_node =3D NULL;
>> +free_priv_data:
>> +	snd_soc_card_set_drvdata(card, NULL);
>> +	platform_set_drvdata(pdev, NULL);
>> +	card->dev =3D NULL;
> If any of these assignments is doing anything there's a problem with =
the
> code.
>
Yes, when probe failed, program will goto this code.
>> +{
>> +	struct snd_soc_card *card =3D platform_get_drvdata(pdev);
>> +
>> +	snd_soc_unregister_card(card);
> devm_snd_soc_register_card() and you can remove this function entirel=
y.
do you mean that when I take devm_snd_soc_register_card() to register c=
ard,
then I do not need unregister card any more(destroy with device) ?
>
>> +static const struct of_device_id rockchip_hdmi_audio_of_match[] =3D=
 {
>> +	{ .compatible =3D "rockchip,rk3288-hdmi-audio", },
>> +	{},
>> +};
> There is no documentation for this binding, binding documentation is
> mandatory.  Based on the compatible string this looks like it's speci=
fic
> to the SoC rather than a design for a board - is the whole card part =
of
> the SoC?
It's my fault, cause the dts patch have not CC you, I will correct it i=
n=20
next v5

Thanks :)
Yakir

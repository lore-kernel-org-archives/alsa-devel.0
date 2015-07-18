From: zhengxing <zhengxing@rock-chips.com>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
Date: Sat, 18 Jul 2015 11:51:24 +0800
Message-ID: <55A9CD3C.10300@rock-chips.com>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com> <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com> <20150717180402.GS11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150717180402.GS11162@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 2015=E5=B9=B407=E6=9C=8818=E6=97=A5 02:04, Mark Brown wrote:
> On Wed, Jul 15, 2015 at 11:15:42AM +0800, Xing Zheng wrote:
>
> This looks pretty good, a couple of minor points below which should b=
e
> quick to fix.
>
>> +static int rk_init(struct snd_soc_pcm_runtime *runtime)
>> +{
>> +	struct snd_soc_card *card =3D runtime->card;
>> +
>> +	card->dapm.idle_bias_off =3D true;
> You shouldn't need to do this?  If you do need to do it we should mak=
e
> it possible to do it from the card struct.
Done, we don't need it in the machine driver.
>> +	ret =3D snd_soc_register_card(card);
>> +	if (ret) {
>> +		pr_err("snd_soc_register_card failed %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret =3D snd_soc_of_parse_card_name(card, "rockchip,model");
>> +	if (ret)
>> +		return ret;
> This should be devm_snd_soc_register_card() and you need to parse the
> card name before registering it, otherwise the card might instantiate
> before the name is set.
Done.
>> +static int snd_rk_mc_remove(struct platform_device *pdev)
>> +{
>> +	struct snd_soc_card *soc_card =3D platform_get_drvdata(pdev);
>> +
>> +	snd_soc_card_set_drvdata(soc_card, NULL);
>> +	snd_soc_unregister_card(soc_card);
>> +	platform_set_drvdata(pdev, NULL);
> No need for any of the _set_drvdata() calls, the core does them and t=
hey
> shouldn't make any difference anyway.
Done. I will remove *_set_drvdata and *get_drvdata because we don't nee=
d=20
them any more.

Thanks.

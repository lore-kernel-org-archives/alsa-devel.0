From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [asoc:topic/tas2552 1/8]
 sound/soc/codecs/tas2552.c:493:27-28: Unneeded semicolon
Date: Fri, 5 Jun 2015 09:50:24 +0300
Message-ID: <557146B0.9060800@ti.com>
References: <201506050350.VWBQIwkL%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id C377A26672E
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 08:50:29 +0200 (CEST)
In-Reply-To: <201506050350.VWBQIwkL%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On 06/04/2015 10:21 PM, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git t=
opic/tas2552
> head:   16bd395259cf3e9966d40478891e0e610da109d4
> commit: ea178d1456dcf88875d5edd148f2df8ea0de1794 [1/8] ASoC: tas2552: Mak=
e the enable-gpio really optional
> =

> =

> coccinelle warnings: (new ones prefixed by >>)
> =

>>> sound/soc/codecs/tas2552.c:493:27-28: Unneeded semicolon
> =

> vim +493 sound/soc/codecs/tas2552.c
> =

>    477	{
>    478		struct device *dev;
>    479		struct tas2552_data *data;
>    480		int ret;
>    481		int i;
>    482	=

>    483		dev =3D &client->dev;
>    484		data =3D devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
>    485		if (data =3D=3D NULL)
>    486			return -ENOMEM;
>    487	=

>    488		data->enable_gpio =3D devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW=
);
>    489		if (IS_ERR(data->enable_gpio)) {
>    490			if (PTR_ERR(data->enable_gpio) =3D=3D -EPROBE_DEFER)
>    491				return -EPROBE_DEFER;
>    492	=

>  > 493			data->enable_gpio =3D NULL;;

I did run checkpatch.pl --strict...
Either checkpatch or I missed to spot this, I will send a followup patch to
fix it.

>    494		}
>    495	=

>    496		data->tas2552_client =3D client;
>    497		data->regmap =3D devm_regmap_init_i2c(client, &tas2552_regmap_con=
fig);
>    498		if (IS_ERR(data->regmap)) {
>    499			ret =3D PTR_ERR(data->regmap);
>    500			dev_err(&client->dev, "Failed to allocate register map: %d\n",
>    501				ret);
> =

> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corpora=
tion
> =



-- =

P=E9ter

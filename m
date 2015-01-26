From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2 1/3] ASoC: codecs: wm8904: add dt ids table
Date: Mon, 26 Jan 2015 16:24:38 +0100
Message-ID: <54C65C36.9050106@atmel.com>
References: <1418614273-2303-1-git-send-email-voice.shen@atmel.com> <20150115115425.GX3043@sirena.org.uk> <54B866B9.8000900@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <54B866B9.8000900@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, Alexander Morozov <linux@meltdown.ru>
List-Id: alsa-devel@alsa-project.org

Le 16/01/2015 02:17, Bo Shen a =E9crit :
> Hi Mark,
>=20
> On 01/15/2015 07:54 PM, Mark Brown wrote:
>> On Mon, Dec 15, 2014 at 11:31:11AM +0800, Bo Shen wrote:
>>
>>> +#ifdef CONFIG_OF
>>> +static enum wm8904_type wm8904_data =3D WM8904;
>>> +static enum wm8904_type wm8912_data =3D WM8912;
>>> +
>>> +static const struct of_device_id wm8904_of_match[] =3D {
>>> +	{
>>> +		.compatible =3D "wlf,wm8904",
>>> +		.data =3D &wm8904_data,
>>
>> Does this end up in the i2c_driver_id driver data or do we need some
>> extra code when devtype is assigned to check for an of_node and look=
 at
>> the DT data instead?  That certainly used to be the case...
>=20
> At the beginning I think as the same as you, and also add the code to=
=20
> get the data as I do in <drivers/misc/atmel-ssc.c>. However, as I=20
> remember, I2C seems only use the compatible string after the comma, t=
hat=20
> means only for "wlf,wm8904", it uses "wm8904" to match. So, I remove =
all=20
> the code I added, and just keep these, and it can get the device type=
=20
> correctly.
>=20
> So, when I submit the patch and keep the code as simple as possible.
>=20
> Thanks.
>=20
> Best Regards,
> Bo Shen

I don't understand what's keeping this patch from being applied. Voice,
do you mind re-sending?

On my side, I take the two patches that apply on AT91 DT (2/3 and 3/3).

Bye,
--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-sound" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

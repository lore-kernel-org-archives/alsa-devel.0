From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH v2] soc/lapis: add machine driver
Date: Mon, 5 Dec 2011 18:33:03 +0900
Message-ID: <CANKRQniyjT_2Ko=EYmffu3_NzDJQTMm9nY6rUp-DQ70e6AVQpA@mail.gmail.com>
References: <1322819115-15808-1-git-send-email-tomoya.rohm@gmail.com>
	<20111202153401.GX8245@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111202153401.GX8245@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>, Daniel Mack <zonque@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com
List-Id: alsa-devel@alsa-project.org

2011/12/3 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Dec 02, 2011 at 06:45:15PM +0900, Tomoya MORINAGA wrote:
>
>> +#define CODEC_DEV_ADDR 0x1A
>> +static struct i2c_board_info ioh_hwmon_info[] =3D {
>> + =A0 =A0 {I2C_BOARD_INFO("ioh_i2c-0", CODEC_DEV_ADDR + 1)},
>> + =A0 =A0 {I2C_BOARD_INFO("ioh_i2c-1", CODEC_DEV_ADDR + 2)},
>> + =A0 =A0 {I2C_BOARD_INFO("ioh_i2c-2", CODEC_DEV_ADDR + 3)},
>> + =A0 =A0 {I2C_BOARD_INFO("ioh_i2c-3", CODEC_DEV_ADDR + 4)},
>> + =A0 =A0 {I2C_BOARD_INFO("ioh_i2c-4", CODEC_DEV_ADDR + 5)},
>> + =A0 =A0 {I2C_BOARD_INFO("ioh_i2c-5", CODEC_DEV_ADDR + 0)},
>
> This looks completely wrong. =A0I'd not expect to see any I2C_BOARD_I=
NFO
> usage at all in a machine driver (that should be done by whatever
> enumerates the system as a whole)
Do you mean machine driver must not use I2C_BOARD_INFO ? Is this true ?
Grepping I2C_BOARD_INFO at sound/soc,  the following drivers use
I2C_BOARD_INFO.
pxa/raumfeld.c: I2C_BOARD_INFO("max9485", 0x63),
pxa/magician.c:         I2C_BOARD_INFO("uda1380", 0x18),
s6000/s6105-ipcam.c:    { I2C_BOARD_INFO("tlv320aic33", 0x18), }

> and I'm not clear what the intended
> effect of the above is - the names look like the names of I2C
> controllers...
You are right.
"ioh_i2c-0" must be "ml26124".


>
>> +static int ml7213_startup(struct snd_pcm_substream *substream)
>> +{
>> + =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_dat=
a;
>> + =A0 =A0 struct snd_soc_codec *codec =3D rtd->codec;
>> + =A0 =A0 struct i2c_client *i2c;
>> + =A0 =A0 struct i2c_adapter *adapter;
>> +
>> + =A0 =A0 mutex_lock(&codec->mutex);
>> +
>> + =A0 =A0 adapter =3D i2c_get_adapter(1);
>> + =A0 =A0 if (!adapter)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> +
>> + =A0 =A0 i2c =3D i2c_new_device(adapter, &ioh_hwmon_info[substream-=
>number]);
>> + =A0 =A0 if (!i2c) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&codec->mutex);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>> + =A0 =A0 }
>> + =A0 =A0 i2c_put_adapter(adapter);
>> + =A0 =A0 mutex_unlock(&codec->mutex);
>
> No, this is definitely wrong - we certainly shouldn't be registering =
new
> devices whenever someone starts an audio stream. =A0I'm struggling to
> understand what the intended effect is though.
Do you mean this registering must be at xx_init processing ?
OK, I'll move this processing into init().

>> + =A0 =A0 ret =3D snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S =
|
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DA=
IFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
>> + =A0 =A0 if (ret < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>
> Use the dai_fmt field in the dai_link to set this.
Sorry, I can't understand your saying.
Let me know in more detail.

>
>> +MODULE_AUTHOR("Tomoya MORINAGA <tomoya.rohm@gmail.com>");
>> +MODULE_DESCRIPTION("LAPIS Semiconductor ML7213 IOH ALSA SoC machine=
 driver");
>> +MODULE_LICENSE("GPL");
>
> Should have MODULE_ALIAS too.
Do you mean machine driver should have MODULE_ALIAS ?
Grepping  MODULE_ALIAS at sound/soc, it seems MODULE_ALIAS is used in
platform driver only like below.
pxa/pxa2xx-i2s.c:MODULE_ALIAS("platform:pxa2xx-i2s");

Does machine driver need like "MODULE_ALIAS("machine:ml7213CRB")" ?

Thanks in advance

tomoya

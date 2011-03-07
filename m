From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH] Add driver for Analog Devices
 ADAU1701 SigmaDSP
Date: Sun, 6 Mar 2011 21:44:49 -0500
Message-ID: <AANLkTinGyn8tujw-TrLibuDuj_Xqb4_YEPfLPFUy4WdO@mail.gmail.com>
References: <1299460302-15392-1-git-send-email-cliff.cai@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1299460302-15392-1-git-send-email-cliff.cai@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cliff.cai@analog.com
Cc: broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, akpm@linux-foundation.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 6, 2011 at 20:11,  <cliff.cai@analog.com> wrote:
> +#define ADAU1701_FIRMWARE "SigmaDSP_fw.bin"

this probably needs to be more specific.  like "adau1701.bin".
otherwise it makes it a pain to work with diff codecs in the same
system.

> +static int adau1701_write_register(struct snd_soc_codec *codec,
> + =C2=A0 =C2=A0 =C2=A0 u16 reg_address, u8 length, u32 value)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 int count =3D length + 2; /*data plus 16bit re=
gister address*/
> + =C2=A0 =C2=A0 =C2=A0 u8 buf[8] =3D {0, 0, 0, 0, 0, 0, 0, 0};
> +
> + =C2=A0 =C2=A0 =C2=A0 if (length =3D=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
> + =C2=A0 =C2=A0 =C2=A0 buf[0] =3D (reg_address >> 8) & 0xFF;

should be a blank line after that return

> + =C2=A0 =C2=A0 =C2=A0 buf[1] =3D reg_address & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 if (length =3D=3D 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[2] =3D value &=
 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 else if (length =3D=3D 2) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[2] =3D (value =
>> 8) & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[3] =3D value &=
 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 } else if (length =3D=3D 3) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[2] =3D (value =
>> 16) & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[3] =3D (value =
>> 8) & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[4] =3D value &=
 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 }

i think the buf[8] init forces gcc to generate bad code, and seems to
be useless.  shouldnt the code have an "else" brace to return -1 if
length is greater than 3, and then change the decl to "u8 buf[5];" ?

also, all these 0xFF masks are useless -- you're assigning it to a u8
which implies bit truncation

> +       ret =3D i2c_master_send(codec->control_data, buf, count);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +
> +}

the whole "int ret" seems kind of useless in this func.  just return
the i2c_master_send and drop the ret var completely.  and drop the
blank link after the return.

> +/*
> + * read ADAU1701 hw register
> + */
> +static u32 adau1701_read_register(struct snd_soc_codec *codec,
> + =C2=A0 =C2=A0 =C2=A0 u16 reg_address, u8 length)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u8 addr[2];
> + =C2=A0 =C2=A0 =C2=A0 u8 buf[2];
> + =C2=A0 =C2=A0 =C2=A0 u32 value =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (reg_address < ADAU1701_FIRSTREG)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg_address =3D re=
g_address + ADAU1701_FIRSTREG;
> +
> + =C2=A0 =C2=A0 =C2=A0 if ((reg_address < ADAU1701_FIRSTREG) || (reg_=
address > ADAU1701_LASTREG))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;

this func has "u32" for ret, and you return the raw register value
below.  but here you try returning -EIO.  shouldnt it be "int" so the
caller can check for "< 0" ?

> + =C2=A0 =C2=A0 =C2=A0 addr[0] =3D (reg_address >> 8) & 0xFF;
> + =C2=A0 =C2=A0 =C2=A0 addr[1] =3D reg_address & 0xFF;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* write the 2byte read address */
> + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_master_send(codec->control_data, a=
ddr, 2);
> + =C2=A0 =C2=A0 =C2=A0 if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (length =3D=3D 1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i2c_master_rec=
v(codec->control_data, buf, 1) !=3D 1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return -EIO;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D buf[0];
> + =C2=A0 =C2=A0 =C2=A0 } else if (length =3D=3D 2) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i2c_master_rec=
v(codec->control_data, buf, 2) !=3D 2)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return -EIO;

seems like this can be combined into one simple code block where you
replace "1" and '2" with "length"

> +static int adau1701_setprogram(struct snd_soc_codec *codec)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D process_sigma_firmware(codec->control_=
data, ADAU1701_FIRMWARE);
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}

seems like this should be one statement -- a simple return

> +static int adau1701_set_bias_level(struct snd_soc_codec *codec,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum snd_soc_bias_level level=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u16 reg;
> + =C2=A0 =C2=A0 =C2=A0 switch (level) {
> + =C2=A0 =C2=A0 =C2=A0 case SND_SOC_BIAS_ON:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D adau1701_r=
ead_register(codec, ADAU1701_AUXNPOW, 2);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg &=3D ~(AUXNPOW=
_AAPD | AUXNPOW_D0PD | AUXNPOW_D1PD | =C2=A0AUXNPOW_D2PD |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0AUXNPOW_D3PD | AUXNPOW_VBPD | AUXNPOW_VRPD);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adau1701_write_reg=
ister(codec, ADAU1701_AUXNPOW, 2, reg);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case SND_SOC_BIAS_PREPARE:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case SND_SOC_BIAS_STANDBY:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case SND_SOC_BIAS_OFF:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* everything off,=
 dac mute, inactive */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D adau1701_r=
ead_register(codec, ADAU1701_AUXNPOW, 2);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg |=3D AUXNPOW_A=
APD | AUXNPOW_D0PD | AUXNPOW_D1PD | =C2=A0AUXNPOW_D2PD |
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0AUXNPOW_D3PD | AUXNPOW_VBPD | AUXNPOW_VRPD;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adau1701_write_reg=
ister(codec, ADAU1701_AUXNPOW, 2, reg);

error checking missing on the read_register() call

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> +
> + =C2=A0 =C2=A0 =C2=A0 }

drop the blank line before the brace

> +struct snd_soc_dai_driver adau1701_dai =3D {
> + =C2=A0 =C2=A0 =C2=A0 .name =3D "ADAU1701",

i think the standard is to use all lower case

> +static int adau1701_suspend(struct snd_soc_codec *codec, pm_message_=
t state)
> +{
> + =C2=A0 =C2=A0 =C2=A0 adau1701_set_bias_level(codec, SND_SOC_BIAS_OF=
=46);
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> +static int adau1701_resume(struct snd_soc_codec *codec)
> +{
> + =C2=A0 =C2=A0 =C2=A0 adau1701_set_bias_level(codec, SND_SOC_BIAS_ST=
ANDBY);
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> ...
> +static int adau1701_remove(struct snd_soc_codec *codec)
> +{
> +       adau1701_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +       return 0;
> +}

why not return set_bias_level ?

> +static int adau1701_reg_init(struct snd_soc_codec *codec)
> ...
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "L=
oading program data failed\n");

dev_err

> +struct snd_soc_codec_driver soc_codec_dev_adau1701 =3D {

static

> +static __devinit int adau1701_i2c_probe(struct i2c_client *i2c,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct i2c_device_id *id)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct adau1701_priv *adau1701;
> + =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 adau1701 =3D kzalloc(sizeof(struct adau1701_pr=
iv), GFP_KERNEL);

sizeof(*adau1701)

> +static int __init adau1701_modinit(void)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_add_driver(&adau1701_i2c_driver);
> + =C2=A0 =C2=A0 =C2=A0 if (ret !=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_ERR "F=
ailed to register adau1701 I2C driver: %d\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret);
> + =C2=A0 =C2=A0 =C2=A0 }

uesless braces, and should be pr_err

> +MODULE_DESCRIPTION("ASoC ADAU1701 SigmaDSP driver");
> +MODULE_AUTHOR("Cliff Cai");
> +MODULE_LICENSE("GPL");

MODULE_ALIAS() ?

> +++ b/sound/soc/codecs/adau1701.h
> ...
> +#define =C2=A0 =C2=A0 =C2=A0 =C2=A0AUXADCE_AAEN =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(1 << 15)
> +#define OSCIPOW_OPD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0x04)
> +#define =C2=A0 =C2=A0 =C2=A0 =C2=A0DACSET_DACEN =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(1)

looks like you got "#define<tab>" junk in here
-mike

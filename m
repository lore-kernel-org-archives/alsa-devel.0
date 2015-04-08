From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH] ASoC: max98090: add shutdown callback for max98090
Date: Wed, 08 Apr 2015 18:15:28 +0800
Message-ID: <5524FFC0.4070900@rock-chips.com>
References: <1428483128-23498-1-git-send-email-wxt@rock-chips.com> <1428483128-23498-2-git-send-email-wxt@rock-chips.com> <20150408095005.GS6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150408095005.GS6023@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Sonny Rao <sonnyrao@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>, Heiko Stuebner <heiko@sntech.de>, zhengxing <zhengxing@rock-chips.com>, "jay.xu" <xjq@rock-chips.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Tushar Behera <tushar.b@samsung.com>
List-Id: alsa-devel@alsa-project.org

Mark,


=E5=9C=A8 2015=E5=B9=B404=E6=9C=8808=E6=97=A5 17:50, Mark Brown =E5=86=99=
=E9=81=93:
> On Wed, Apr 08, 2015 at 04:52:08PM +0800, Caesar Wang wrote:
>
>> +static void max98090_i2c_shutdown(struct i2c_client *i2c)
>> +{
>> +	struct max98090_priv *max98090 =3D dev_get_drvdata(&i2c->dev);
>> +
>> +	dev_info(&i2c->dev, "shut down device\n");
> Remove this, it's adding noise.

Done
>> +
>> +	/* Enable volume smoothing, disable zero cross.  This will cause
>> +	 * a quick 40ms ramp to mute on shutdown.
>> +	 */
>> +	regmap_write(max98090->regmap,
>> +		M98090_REG_LEVEL_CONTROL, M98090_VSENN_MASK);
>> +	regmap_write(max98090->regmap,
>> +		M98090_REG_DEVICE_SHUTDOWN, 0x00);
>> +	msleep(40);
>> +}
> This is OK but equivalent code should be being added to the driver
> remove path as the same thing should be happening there.
Yeah.I will fix it in v2 patch.

Thanks!

--=20
***********************************************************************=
***************
=E7=8E=8B=E6=99=93=E8=85=BE    Caesar Wang
=E7=B3=BB=E7=BB=9F=E4=BA=A7=E5=93=81=E4=B8=89=E9=83=A8   Product R&D De=
pt.III
=E7=A6=8F=E5=B7=9E=E7=91=9E=E8=8A=AF=E5=BE=AE=E7=94=B5=E5=AD=90=E6=9C=89=
=E9=99=90=E5=85=AC=E5=8F=B8 Fuzhou Rockchip Electronics Co.Ltd
=E5=9C=B0=E5=9D=80=EF=BC=9A=E7=A6=8F=E5=BB=BA=E7=9C=81=E7=A6=8F=E5=B7=9E=
=E5=B8=82=E9=93=9C=E7=9B=98=E8=B7=AF=E8=BD=AF=E4=BB=B6=E5=A4=A7=E9=81=93=
89=E5=8F=B7=E8=BD=AF=E4=BB=B6=E5=9B=ADA=E5=8C=BA18=E5=8F=B7=E6=A5=BC =EF=
=BC=88=E7=A6=8F=E5=B7=9E=E6=80=BB=E9=83=A8=EF=BC=89
         =E6=B7=B1=E5=9C=B3=E5=8D=97=E5=B1=B1=E5=8C=BA=E7=A7=91=E6=8A=80=
=E4=B8=AD=E4=B8=80=E8=B7=AF=E4=B8=87=E5=88=A9=E8=BE=BE=E5=A4=A7=E5=8E=A6=
21=E5=B1=82 =EF=BC=88=E6=B7=B1=E5=9C=B3=E5=88=86=E5=85=AC=E5=8F=B8=EF=BC=
=89
Addr=EF=BC=9A  NO.18 Building, A District, Fuzhou Software Park,Gulou D=
istrict,Fuzhou, Fujian,China(Fuzhou Headquarters)
          21F,Malata Building,Kejizhongyi Avenue,Nanshan District,Shenz=
hen  (Shenzhen Office)
Tel=EF=BC=9A+86-591-83991906/07 - 8221
Mobile:+86 15059456742
E-mail : wxt@rock-chips.com
***********************************************************************=
****************
***********************************************************************=
****************
=E4=BF=9D=E5=AF=86=E6=8F=90=E7=A4=BA=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=B6=
=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=E6=9C=89=E6=9C=BA=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E5=8F=91=E9=80=81=E7=BB=99=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E6=89=80=E6=8C=87=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=
=E4=BA=BA=E3=80=82=E8=8B=A5=E9=9D=9E=E8=AF=A5=E7=89=B9=E5=AE=9A=E6=94=B6=
=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7=E5=8B=BF=E5=A4=8D=E5=88=B6=E3=80=81=
 =E4=BD=BF=E7=94=A8=E6=88=96=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=
=E7=9A=84=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E3=80=82
=E8=8B=A5=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=
=E4=BB=8E=E7=B3=BB=E7=BB=9F=E4=B8=AD=E6=B0=B8=E4=B9=85=E6=80=A7=E5=88=A0=
=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E6=89=80=E6=9C=89=E9=99=84=
=E4=BB=B6=EF=BC=8C=E5=B9=B6=E4=BB=A5=E5=9B=9E=E5=A4=8D=E9=82=AE=E4=BB=B6=
=E6=88=96=E5=85=B6=E4=BB=96=E6=96=B9=E5=BC=8F=E5=8D=B3=E5=88=BB=E5=91=8A=
=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=82=E7=A6=8F=E5=B7=9E=E7=91=9E=
=E8=8A=AF=E5=BE=AE=E7=94=B5=E5=AD=90=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=
=E6=8B=A5=E6=9C=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=BF=A1
=E6=81=AF=E7=9A=84=E8=91=97=E4=BD=9C=E6=9D=83=E5=8F=8A=E8=A7=A3=E9=87=8A=
=E6=9D=83=EF=BC=8C=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E6=9C=AA=E7=BB=8F=
=E6=8E=88=E6=9D=83=E8=AE=B8=E5=8F=AF=E7=9A=84=E4=BE=B5=E6=9D=83=E8=A1=8C=
=E4=B8=BA=E3=80=82
 =20
IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., L=
td .The contents of this email and any attachments may
contain information that is privileged, confidential and/or exempt from=
 disclosure under applicable law and relevant NDA.
If you are not the intended recipient, you are hereby notified that any=
 disclosure, copying, distribution, or use of the
information is STRICTLY PROHIBITED. Please immediately contact the send=
er as soon as possible and destroy the material
in its entirety in any format. Thank you.
***********************************************************************=
****************

From: Axel Lin <axel.lin@gmail.com>
Subject: Re: ASoC: uninitialized variable i used in wait_for_dc_servo
Date: Thu, 15 Sep 2011 19:13:38 +0800
Message-ID: <CAF+7xW=OdZYq4ufz=r_Bp0OUL2SnGNmEDDiGkRaUvXL2Jrx+tw@mail.gmail.com>
References: <1316055154.3496.6.camel@phoenix> <20110915095427.GB7988@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110915095427.GB7988@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2011/9/15 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Thu, Sep 15, 2011 at 10:52:34AM +0800, Axel Lin wrote:
>> @@ -722,7 +723,7 @@ static void wait_for_dc_servo(struct snd_soc_cod=
ec *codec, u16 mask)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (--i) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (--i =3D=3D 0) {
>
> You should avoid making random stylistic changes that aren't needed w=
hen
> doing things like this.
>
Ah. I didn't mean to change the coding style.
It's to reverse the logic of the if condition.

BTW, your fix looks good to me.

Regards,
Axel

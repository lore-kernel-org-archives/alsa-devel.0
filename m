From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 2/4] ARM: dts: pbab01: enable I2S audio on
 phyFLEX-i.MX6 boards
Date: Fri, 12 Sep 2014 13:40:02 -0300
Message-ID: <CAOMZO5C9_XwgcLvVWvxB1A306_Ehm17ZE111j6d+7MhudAhT0g@mail.gmail.com>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
	<1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
	<1410537872-17274-3-git-send-email-d.lavnikevich@sam-solutions.com>
	<1410539161.314611261@f174.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410539161.314611261@f174.i.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>, Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, =devicetree@vger.kernel.org, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 12, 2014 at 1:26 PM, Alexander Shiyan <shc_work@mail.ru> wr=
ote:
> Fri, 12 Sep 2014 19:04:30 +0300 =D0=BE=D1=82 Dmitry Lavnikevich <d.la=
vnikevich@sam-solutions.com>:
>> Audio on phyFLEX boards is presented by tlv320aic3007 codec connecte=
d
>> over SSI interface.
>>
>> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
>> ---
> ...
>> +&ssi2 {
>> +     fsl,mode =3D "i2s-slave";
>> +     status =3D "okay";
>> +     #sound-dai-cells =3D <0>;
>> +};
>
> I have already sent patch to add "#sound-dai-cells" into all i.MX DT-=
files.
> Shawn, can you point us to this tree/commit?

https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/=
?h=3Dfor-next&id=3D36c7e8826cf32dd4dd34c71b526653b800414355

From: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.net>
Subject: Re: [PATCH v2 2/4] ARM: dts: pbab01: enable I2S audio on phyFLEX-i.MX6
 boards
Date: Mon, 15 Sep 2014 15:04:50 +0300
Message-ID: <5416D5E2.5050109@sam-solutions.net>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com> <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com> <1410537872-17274-3-git-send-email-d.lavnikevich@sam-solutions.com> <1410538486.406482403@f174.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410538486.406482403@f174.i.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>, Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
Cc: =devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com, kernel@pengutronix.de, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, perex@perex.cz, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On 12/09/14 19:14, Alexander Shiyan wrote:
> Fri, 12 Sep 2014 19:04:30 +0300 =D0=BE=D1=82 Dmitry Lavnikevich <d.la=
vnikevich@sam-solutions.com>:
>> +&audmux {
>> +	status =3D "okay";
>> +
>> +	ssi2 {
>> +		fsl,audmux-port =3D <1>;
>> +		fsl,port-config =3D <0xa5000000 0x00008000>;
>> +	};
>> +	pins5 {
>> +		fsl,audmux-port =3D <4>;
>> +		fsl,port-config =3D <0x00000000 0x00002000>;
>> +	};
>> +};
> You should use defines from sound/fsl-imx-audmux.h for audmux.
Ok, will change it in next patchset version.

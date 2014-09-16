From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [alsa-devel] [PATCH v2 2/4] ARM: dts: pbab01: enable I2S audio
 on phyFLEX-i.MX6 boards
Date: Tue, 16 Sep 2014 09:46:58 +0800
Message-ID: <20140916014657.GB23450@dragon>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410537872-17274-3-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410539161.314611261@f174.i.mail.ru>
 <CAOMZO5C9_XwgcLvVWvxB1A306_Ehm17ZE111j6d+7MhudAhT0g@mail.gmail.com>
 <5416D666.2050302@sam-solutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5416D666.2050302@sam-solutions.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.net>
Cc: Fabio Estevam <festevam@gmail.com>, Alexander Shiyan <shc_work@mail.ru>, Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>, Mark Rutland <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Russell King <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, =devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 15, 2014 at 03:07:02PM +0300, Dmitry Lavnikevich wrote:
> On 12/09/14 19:40, Fabio Estevam wrote:
> >On Fri, Sep 12, 2014 at 1:26 PM, Alexander Shiyan <shc_work@mail.ru>=
 wrote:
> >>Fri, 12 Sep 2014 19:04:30 +0300 =D0=BE=D1=82 Dmitry Lavnikevich <d.=
lavnikevich@sam-solutions.com>:
> >>>Audio on phyFLEX boards is presented by tlv320aic3007 codec connec=
ted
> >>>over SSI interface.
> >>>
> >>>Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com=
>
> >>>---
> >>...
> >>>+&ssi2 {
> >>>+     fsl,mode =3D "i2s-slave";
> >>>+     status =3D "okay";
> >>>+     #sound-dai-cells =3D <0>;
> >>>+};
> >>I have already sent patch to add "#sound-dai-cells" into all i.MX D=
T-files.
> >>Shawn, can you point us to this tree/commit?
> >https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/comm=
it/?h=3Dfor-next&id=3D36c7e8826cf32dd4dd34c71b526653b800414355
> So should I base my next patchset on for-next branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> ?

Yes, please.

Shawn

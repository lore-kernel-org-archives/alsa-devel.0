From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add external amplifier controls for
	Visstrim_M10.
Date: Thu, 19 Jan 2012 17:59:13 +0000
Message-ID: <20120119175913.GL3178@opensource.wolfsonmicro.com>
References: <1326984807-10424-1-git-send-email-javier.martin@vista-silicon.com>
	<20120119154521.GG3178@opensource.wolfsonmicro.com>
	<CACKLOr10BtcBjRGYjU7H+6tBYwWZf4h15O=bNU2gxvGU9re0qQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 036F72436E
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 18:59:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACKLOr10BtcBjRGYjU7H+6tBYwWZf4h15O=bNU2gxvGU9re0qQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2012 at 05:37:46PM +0100, javier Martin wrote:
> On 19 January 2012 16:45, Mark Brown

> >> + =A0 =A0 ret =3D mxc_gpio_setup_multiple_pins(mx27vis_amp_pins,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(mx27vis_amp_pins)=
, "MX27VIS_AMP");
> >> + =A0 =A0 if (ret) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "ASoC: unable to setup gpios=
\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 platform_device_put(mx27vis_aic32x4_snd_devi=
ce);
> >> + =A0 =A0 }

> > This looks awfully like it should be arch/arm code except it looks like
> > it also munges in the gpio_request. =A0Odd.

> This is a doubt I had. I could also use board specific file to request
> these gpios and then use some platform data to tell the driver what
> GPIOS must be used.
> However, as those gpios are fixed for all Visstrim_M10 boards I
> considered it didn't worth it.

> On the other hand, if you think it's cleaner that way I can do that.

I think this is just the arch being non-standard.

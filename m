From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH] ASoC: Add external amplifier controls for
	Visstrim_M10.
Date: Thu, 19 Jan 2012 17:37:46 +0100
Message-ID: <CACKLOr10BtcBjRGYjU7H+6tBYwWZf4h15O=bNU2gxvGU9re0qQ@mail.gmail.com>
References: <1326984807-10424-1-git-send-email-javier.martin@vista-silicon.com>
	<20120119154521.GG3178@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DB1FD2417E
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 17:37:47 +0100 (CET)
Received: by wgbdy1 with SMTP id dy1so92376wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 08:37:46 -0800 (PST)
In-Reply-To: <20120119154521.GG3178@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,
thank you for your review.

On 19 January 2012 16:45, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Jan 19, 2012 at 03:53:27PM +0100, Javier Martin wrote:
>> Visstrim_M10 has an external class D amplifier.
>> This patch provides support for controlling the 4
>> possible gain levels and per channel muting.
>
> It does seem like there could usefully be a generic driver but it's so
> little code...
>
>> + =A0 =A0 switch (reg) {
>> + =A0 =A0 case MX27VIS_AMP_GAIN:
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(MX27VIS_PIN_G0, value & 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(MX27VIS_PIN_G1, value >> 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 mx27vis_amp_gain =3D value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case MX27VIS_AMP_MUTE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(MX27VIS_PIN_SDL, value & 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(MX27VIS_PIN_SDR, value >> 1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 mx27vis_amp_mute =3D value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> These should validate that value is in range.

Sure. Sorry.

>> + =A0 =A0 ret =3D mxc_gpio_setup_multiple_pins(mx27vis_amp_pins,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(mx27vis_amp_pins), =
"MX27VIS_AMP");
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "ASoC: unable to setup gpios\n=
");
>> + =A0 =A0 =A0 =A0 =A0 =A0 platform_device_put(mx27vis_aic32x4_snd_device=
);
>> + =A0 =A0 }
>
> This looks awfully like it should be arch/arm code except it looks like
> it also munges in the gpio_request. =A0Odd.

This is a doubt I had. I could also use board specific file to request
these gpios and then use some platform data to tell the driver what
GPIOS must be used.
However, as those gpios are fixed for all Visstrim_M10 boards I
considered it didn't worth it.

On the other hand, if you think it's cleaner that way I can do that.

Regards.
-- =

Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com

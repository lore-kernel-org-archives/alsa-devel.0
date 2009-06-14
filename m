From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH,
	RFC 2/3] ASoC: UDA1380: register from board 	files,
	configure via pdata
Date: Sun, 14 Jun 2009 22:52:00 +0200
Message-ID: <74d0deb30906141352x2503283dib19934ef9d97b13d@mail.gmail.com>
References: <1244976692-5189-1-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-2-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-3-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-4-git-send-email-philipp.zabel@gmail.com>
	<20090614145128.GB4482@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id AAE0C2414D
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Jun 2009 22:52:08 +0200 (CEST)
Received: by ewy21 with SMTP id 21so2156868ewy.32
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2009 13:52:00 -0700 (PDT)
In-Reply-To: <20090614145128.GB4482@sirena.org.uk>
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

On Sun, Jun 14, 2009 at 4:51 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Jun 14, 2009 at 12:51:31PM +0200, Philipp Zabel wrote:
>> This patch removes the I2C board info registration from the codec driver.
>> Instead, device instantiation will be done via global i2c_board_info from
>> board files. At the same time, platform specific configuration is moved
>> to platform data and common power/reset GPIO handling moves into the
>> codec driver.
>
> Thanks for doing this. =A0This should probably either be squashed in with
> the arch patch that follows.

Ok. If Eric agrees, I'll squash as you propose.

>> +struct uda1380_platform_data {
>> + =A0 =A0 int gpio_power;
>> + =A0 =A0 int gpio_reset;
>> + =A0 =A0 int dac_clk;
>> +#define UDA1380_DAC_CLK_SYSCLK 0
>> +#define UDA1380_DAC_CLK_WSPLL =A01
>
> Is it worth changing this to make both options non-zero so that there's
> no possibility that it could be left zero by default?

I think this is fine as-is: SYSCLK is the default setting for DAC
clock input when the chip comes out of reset.

>> +static int uda1380_add_i2c_device(struct platform_device *pdev)
>> =A0{
>
> ...
>
>> =A0 =A0 =A0 ret =3D i2c_add_driver(&uda1380_i2c_driver);
>
> If you're doing this conversion the ideal thing is to convert the driver
> completely so that the driver is registered when the module loads and
> does the DAI registration once the I2C device probes. =A0The I2C device
> probe should also do any other initialisation that can be done without
> the rest of the ASoC subsystem such as registering the GPIOs.

Ok.

> This implies a bit more rearrangment of the registration functions -
> most of the initialisation can stay in the I2C function but anything
> that uses the entire ASoC device and the final instantiation of the card
> should be moved into the ASoC probe function which will be called once
> the entire card has started. =A0WM8731 is a good template to look at here.

I'll look at WM8731 for guidance, thanks.

>> --- a/sound/soc/codecs/uda1380.h
>> +++ b/sound/soc/codecs/uda1380.h
>> @@ -8,9 +8,6 @@
>> =A0 * Copyright (c) 2005 Giorgio Padrin <giorgio@mandarinlogiq.org>
>> =A0 */
>>
>> -#ifndef _UDA1380_H
>> -#define _UDA1380_H
>> -
>
> Best practice would be to keep these with a different name.

uda1380.h is only a one-time private header file, but I won't say no
to best practice.

cheers
Philipp

From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH -next] ASoC: pandora: Add DAC regulator
	support
Date: Sat, 6 Feb 2010 19:33:08 +0200
Message-ID: <6ed0b2681002060933x38009b77r237db131ab172fee@mail.gmail.com>
References: <1265375612-9079-1-git-send-email-notasas@gmail.com>
	<1265378923.3177.11.camel@odin>
	<6ed0b2681002050629p1d38c19m19d1a124ddce307a@mail.gmail.com>
	<20100205172031.GA31523@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f223.google.com (mail-fx0-f223.google.com
	[209.85.220.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A7FB244D1
	for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2010 18:33:09 +0100 (CET)
Received: by fxm23 with SMTP id 23so2149045fxm.22
	for <alsa-devel@alsa-project.org>; Sat, 06 Feb 2010 09:33:08 -0800 (PST)
In-Reply-To: <20100205172031.GA31523@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 5, 2010 at 7:20 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Feb 05, 2010 at 04:29:53PM +0200, Grazvydas Ignotas wrote:
>
>> Uh, I meant "no audible improvement". However I've just checked the
>> DAC datasheet again and it requires 1ms delay between turning on/off
>> the supply and switching /PD pin (connected to
>> OMAP3_PANDORA_DAC_POWER_GPIO). Even though I hear no difference,
>> adding the delays back just in case. Updated patch attached.
>
> Which step of the powerup is the one that generates the pop? =A0As Liam
> says if you can mute the DAC while powering up might help if that's
> possible, though looking I don't think it is.

It's on powerdown, there is a faint pop. It appears its the amp (final
part in the path), I tried to toggle it while playing /dev/zero
manually and it always pops on powerdown. On powerup there is a small
sound cutoff too, probably because of amp capacitors charging, but we
decided to leave it instead of halting every sound playing program
until the amp gets ready.

>
>> From 72cdf36e432a9929baff8841df979f13492dc813 Mon Sep 17 00:00:00 2001
>> From: Grazvydas Ignotas <notasas@gmail.com>
>> Date: Fri, 5 Feb 2010 12:57:37 +0200
>> Subject: [PATCH -next] ASoC: pandora: Add DAC regulator support
>
> Please don't append patches to messages like this, it makes them harder
> to apply since the e-mail text ends up as part of the commit message as
> does the patch header.
>
> Applied, thanks.

noted, thanks.

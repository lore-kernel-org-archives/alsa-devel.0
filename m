From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 10/16] arm: ux500: Add support for MSP
	I2S-devices
Date: Wed, 14 Mar 2012 10:39:03 +0100
Message-ID: <CACRpkdaO7LByWy3HyoOnio6O9d6nKO-g0UNGEaNujcpXVJ+LsQ@mail.gmail.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-11-git-send-email-ola.o.lilja@stericsson.com>
	<20120313214034.GH3177@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BC16D1041E0
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 10:39:05 +0100 (CET)
Received: by ghbg19 with SMTP id g19so1595725ghb.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 02:39:03 -0700 (PDT)
In-Reply-To: <20120313214034.GH3177@opensource.wolfsonmicro.com>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 13, 2012 at 10:40 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Mar 13, 2012 at 04:11:37PM +0100, Ola Lilja wrote:
>
>> =A0arch/arm/mach-ux500/board-mop500-msp.c | =A0194 +++++++++++++++++++++=
+++++++++++
>> =A0arch/arm/mach-ux500/board-mop500.c =A0 =A0 | =A0 =A07 +-
>> =A0arch/arm/mach-ux500/board-mop500.h =A0 =A0 | =A0 =A01 +
>
> Perhaps this is somehow idiomatic for the port but why is this in what
> looks like a board specific rather than SoC specific file?

Basically because it includes GPIO's which are board-specific.

But with some cleverness I guess it'd be possible to split just
the board-dependent stuff (i.e. GPIO) to board-mop500-msp.c
and all SoC-specific stuff into say cpu-db8500-msp.c or
even cpu-dbx500-msp.c if it's generic across all families
of DBx500.

FOr short term, since the midterm plan is to use device tree
for the whole shebang (I guess).

Yours,
Linus Walleij

From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/8] arm: ux500: Add support for MSP
	I2S-devices
Date: Tue, 24 Apr 2012 10:29:08 +0200
Message-ID: <CACRpkdZZaXGOqz3RROhuciwWceq44aDyRwOJLt5XqMxN4o+adg@mail.gmail.com>
References: <1334914379-27445-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 05FF510448E
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2012 10:29:09 +0200 (CEST)
Received: by ghbg19 with SMTP id g19so155289ghb.38
	for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2012 01:29:09 -0700 (PDT)
In-Reply-To: <1334914379-27445-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 20, 2012 at 11:32 AM, Ola Lilja <ola.o.lilja@stericsson.com> wrote:

> Create devices for the MSP-blocks (MSP0, MSP1, MSP2 and MSP3)
> and associate it with the correct clocks in the clock-framework.
>
> Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>

This one looks like a separate ux500 piece so I've applied to
to myc branch where I'm currently accumulationg some pin and
GPIO stuff (since it interacts with the pin business).

It seems to compile fine and all :)

Yours,
Linus Walleij

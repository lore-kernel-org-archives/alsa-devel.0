From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [topic/asoc][PATCH] ASoC: Fix DSP formats in
	SSM2602 audio codec
Date: Mon, 22 Dec 2008 21:05:45 +0200
Message-ID: <bd7b27490812221105g434e82e3s11e71b06e59410c8@mail.gmail.com>
References: <1229936253-5115-1-git-send-email-jarkko.nikula@nokia.com>
	<20081222144551.GA30743@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20])
	by alsa0.perex.cz (Postfix) with ESMTP id A162E103817
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 20:05:46 +0100 (CET)
Received: by bwz13 with SMTP id 13so6209394bwz.8
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 11:05:45 -0800 (PST)
In-Reply-To: <20081222144551.GA30743@rakim.wolfsonmicro.main>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@nokia.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 22, 2008 at 4:45 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, Dec 22, 2008 at 10:57:33AM +0200, Jarkko Nikula wrote:
> > Thanks to Troy Kisky <troy.kisky@boundarydevices.com> for noticing.
>
> > - DSP_A format has 1-bit data delay which corresponds to SSM6202 submode
> 2
> > - DSP_B has 0-bit data delay which corresponds to submode 1
> > - Currently driver sets them opposite so swap the submode setting
>
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> > Cc: Cliff Cai <cliff.cai@analog.com>
>
> Presumably this means that the Blackfin I2S driver also needs to be
> updated (probably just replacing DSP_A with DSP_B by the looks of it)?
> Though since the SSM6206 machine driver uses I2S it shouldn't matter too
> much if they're out of sync temporarily.
>

That was my first impression as well, but then I noticed that
bf5xx-ad73311.c machine driver is using DSP_A and AD73311 looks like it's
hard coded for DSP_A. Hopefully bf5xx-i2s and ssm2602 are still compatible
with each other if using DSP_A :-)


Jarkko

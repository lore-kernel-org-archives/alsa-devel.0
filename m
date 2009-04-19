From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH] ASoC: pxa-ssp: Don't use SSCR0_SerClkDiv
	and SSCR0_SCR
Date: Sun, 19 Apr 2009 17:03:27 +0200
Message-ID: <74d0deb30904190803i4518711epa867f97a0757a66f@mail.gmail.com>
References: <1239961178-19122-1-git-send-email-philipp.zabel@gmail.com>
	<20090417102257.GA10992@sirena.org.uk>
	<f17812d70904190701i5cea465anb9a982c33142f0df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f166.google.com (mail-ew0-f166.google.com
	[209.85.219.166])
	by alsa0.perex.cz (Postfix) with ESMTP id BB8FC24447
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Apr 2009 17:03:28 +0200 (CEST)
Received: by ewy10 with SMTP id 10so1560438ewy.32
	for <alsa-devel@alsa-project.org>; Sun, 19 Apr 2009 08:03:28 -0700 (PDT)
In-Reply-To: <f17812d70904190701i5cea465anb9a982c33142f0df@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 19, 2009 at 4:01 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Fri, Apr 17, 2009 at 6:22 PM, Mark Brown <broonie@sirena.org.uk> wrote:
>> On Fri, Apr 17, 2009 at 11:39:38AM +0200, Philipp Zabel wrote:
>>
>>> To me, using ssp_dev seems to be cleaner, as all the places where
>>> ssp_set_scr is called, we already have an ssp_dev *ssp = priv->dev.ssp
>>> set up, which allows us to call ssp_set_scr(ssp, ...) instead of
>>> ssp_set_scr(&priv->dev, ...). Same for ssp_get_scr.
>>
>> Yeah, the combination of ssp_dev and ssp_device is icky in general and
>> largely historical as a result of a partially done transition of the
>> driver to ssp_device.
>>
>
> I'm working on that clean up. A lot of historical and dependency issues
> indeed.

Glad to hear that. I think once SSP is cleaned up, the single USB
gadget controller driver is the only problem left for kernels
supporting both PXA25x/27x at the same time.

> And the patch looks OK. The condition of cpu_is_pxa25x() might not
> be necessary though, ssp->type == PXA25x_SSP already implies that
> and is more specific.

Thanks. The idea was that the compiler can remove the PXA25x_SSP
branch for kernels without PXA25x support this way.
I guess the savings are negligible here, but it shouldn't hurt
PXA25x-only kernels either.

regards
Philipp

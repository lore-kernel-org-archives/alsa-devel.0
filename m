From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] ASoC: fsl-ssi: Support for
	SND_SOC_DAIFMT_CBM_CFS
Date: Fri, 12 Sep 2014 19:37:25 +0200
Message-ID: <CAOf5uwnv8exb33Lz4qHV2PjQSGOWXjncmVAs9rs5ZeX4AGweAg@mail.gmail.com>
References: <1407164887-22703-1-git-send-email-fabio.falzoi84@gmail.com>
 <20140807174547.GQ17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id B6BDD265538
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 19:37:26 +0200 (CEST)
Received: by mail-wg0-f47.google.com with SMTP id y10so1069891wgg.18
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 10:37:25 -0700 (PDT)
In-Reply-To: <20140807174547.GQ17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Angelo Adamo <adamo.a60@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Fabio Falzoi <fabio.falzoi84@gmail.com>, Markus Pargmann <mpa@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Mark

On Thu, Aug 7, 2014 at 7:45 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Aug 04, 2014 at 05:08:07PM +0200, Fabio Falzoi wrote:
>> Add SND_SOC_DAIFMT_CBM_CFS support for Freescale architecture.
>> Successfully tested on i.MX 6Quad Wandboard and UDOO boards connected to
>> the pcm1792a codec.
>> In CBM_CFS mode, when using a sample size of 16 bits, we cannot use
>> CCSR_SSI_SCR_I2S_MODE_MASTER since we get a frame sync every 16 bits.
>
> Applied, thanks.

where do you apply it (I mean branch)?

Michael

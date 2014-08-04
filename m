From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] ASoC: fsl-ssi: Support for
	SND_SOC_DAIFMT_CBM_CFS
Date: Mon, 4 Aug 2014 17:29:12 +0200
Message-ID: <CAOf5uwkz-ZpNTo8A9MDooNKeF6tSnC8Yvj4_gm3rTCD5ANMdmQ@mail.gmail.com>
References: <1407164887-22703-1-git-send-email-fabio.falzoi84@gmail.com>
 <CAOMZO5D4OXxG346LZjGOCGjzoAZSz0N97XnWmUE09OYTDid-YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id C73AB261683
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 17:29:13 +0200 (CEST)
Received: by mail-wg0-f50.google.com with SMTP id n12so7899696wgh.33
 for <alsa-devel@alsa-project.org>; Mon, 04 Aug 2014 08:29:13 -0700 (PDT)
In-Reply-To: <CAOMZO5D4OXxG346LZjGOCGjzoAZSz0N97XnWmUE09OYTDid-YQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Angelo Adamo <adamo.a60@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Fabio Falzoi <fabio.falzoi84@gmail.com>, Markus Pargmann <mpa@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Fabio

On Mon, Aug 4, 2014 at 5:27 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Aug 4, 2014 at 12:08 PM, Fabio Falzoi <fabio.falzoi84@gmail.com> wrote:
>> Add SND_SOC_DAIFMT_CBM_CFS support for Freescale architecture.
>> Successfully tested on i.MX 6Quad Wandboard and UDOO boards connected to
>> the pcm1792a codec.
>
> Great, do you plan to submit the audio support into imx6q-udoo.dts?
>
> Thanks

udoo is not based on pcm1792a but on ac97 codec. I have seen somewhere
the driver I can cleanup and let it go. We have solded the pcm1792a on wandboard
and udoo ;) and on pandaboard es :D.

Michael

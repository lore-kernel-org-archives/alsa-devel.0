From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-ssi: Support for
	SND_SOC_DAIFMT_CBM_CFS
Date: Mon, 4 Aug 2014 12:51:57 -0300
Message-ID: <CAOMZO5BEZOYCwyvGaWPje+=bKHsfOWJ6Qxjnka3kYyk2GBK-uw@mail.gmail.com>
References: <1407164887-22703-1-git-send-email-fabio.falzoi84@gmail.com>
 <CAOMZO5D4OXxG346LZjGOCGjzoAZSz0N97XnWmUE09OYTDid-YQ@mail.gmail.com>
 <CAOf5uwkz-ZpNTo8A9MDooNKeF6tSnC8Yvj4_gm3rTCD5ANMdmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f43.google.com (mail-la0-f43.google.com
 [209.85.215.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D4A22261683
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 17:51:58 +0200 (CEST)
Received: by mail-la0-f43.google.com with SMTP id hr17so5642572lab.30
 for <alsa-devel@alsa-project.org>; Mon, 04 Aug 2014 08:51:57 -0700 (PDT)
In-Reply-To: <CAOf5uwkz-ZpNTo8A9MDooNKeF6tSnC8Yvj4_gm3rTCD5ANMdmQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Angelo Adamo <adamo.a60@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Fabio Falzoi <fabio.falzoi84@gmail.com>, Markus Pargmann <mpa@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 4, 2014 at 12:29 PM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:

> udoo is not based on pcm1792a but on ac97 codec. I have seen somewhere
> the driver I can cleanup and let it go. We have solded the pcm1792a on wandboard
> and udoo ;) and on pandaboard es :D.

Ah, good point :-)

Yes, Udoo has the vt1613 codec
(https://github.com/UDOOboard/Kernel_Unico/blob/master/sound/soc/codecs/vt1613.c
), which has not been upstreamed yet.

Thanks

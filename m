From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Tue, 7 Aug 2012 12:00:14 +0000
Message-ID: <5021034D.9080307@freescale.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <CAOZdJXUmgD+GjuvdLMVErYRs7tsGXOxWROi6YGDvf0yHSOBA_w@mail.gmail.com>
 <CA+7tXigKNQM2ci1Qxc8BjUFyQhNURGvAx=wD0CEim8izMGtU1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id C3D76265EC2
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 13:30:34 +0200 (CEST)
In-Reply-To: <CA+7tXigKNQM2ci1Qxc8BjUFyQhNURGvAx=wD0CEim8izMGtU1w@mail.gmail.com>
Content-Language: en-US
Content-ID: <1CCFEEB2D775AC4091B0173447DB2BE9@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Estevam Fabio-R49496 <r49496@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "gcembed@gmail.com" <gcembed@gmail.com>
List-Id: alsa-devel@alsa-project.org

Trent Piepho wrote:
> It depends on the codec connected to the I2S.  We have SSI that works
> in mono mode, using a modified driver.  Our codec allows mono playback
> by only using the samples on the left channel.

I would *love* to see that driver.

> There is the race issue in that playback and record must both match
> mono and stereo and ALSA doesn't handle substreams with constraints
> that depend on other substreams in a race free manner.

Isn't that only a problem if both streams are opened literally 
simultaneously?  I would assume that most apps will open one stream at a time.

-- 
Timur Tabi
Linux kernel developer at Freescale

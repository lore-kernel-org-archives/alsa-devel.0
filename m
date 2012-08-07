From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Tue, 7 Aug 2012 09:26:34 -0500
Message-ID: <5021259A.60105@freescale.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <CAOZdJXUmgD+GjuvdLMVErYRs7tsGXOxWROi6YGDvf0yHSOBA_w@mail
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BD61265F2E
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 18:13:44 +0200 (CEST)
In-Reply-To: <20120807132611.GF16861@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Estevam Fabio-R49496 <r49496@freescale.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Trent Piepho <tpiepho@gmail.com>, Fabio Estevam <festevam@gmail.com>, "gcembed@gmail.com" <gcembed@gmail.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>> > It depends on the codec connected to the I2S.  We have SSI that works
>> > in mono mode, using a modified driver.  Our codec allows mono playback
>> > by only using the samples on the left channel.
> This is extremely common.

Wouldn't this require the I2S controller to inject dummy data into the
right channel?

-- 
Timur Tabi
Linux kernel developer at Freescale

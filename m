From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Tue, 7 Aug 2012 16:57:12 +0100
Message-ID: <20120807155712.GP16861@opensource.wolfsonmicro.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <5021259A.60105@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 40305265029
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 17:27:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5021259A.60105@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Estevam Fabio-R49496 <r49496@freescale.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Trent Piepho <tpiepho@gmail.com>, Fabio Estevam <festevam@gmail.com>, "gcembed@gmail.com" <gcembed@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 07, 2012 at 09:26:34AM -0500, Timur Tabi wrote:
> Mark Brown wrote:
> >> > It depends on the codec connected to the I2S.  We have SSI that works
> >> > in mono mode, using a modified driver.  Our codec allows mono playback
> >> > by only using the samples on the left channel.

> > This is extremely common.

> Wouldn't this require the I2S controller to inject dummy data into the
> right channel?

Yes, generally the hardware just won't send anything on any empty bit
clocks (or will ignore data that happens to be sent when it's not
interested on the other end).

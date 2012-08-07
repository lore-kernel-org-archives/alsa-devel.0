From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Tue, 7 Aug 2012 14:26:12 +0100
Message-ID: <20120807132611.GF16861@opensource.wolfsonmicro.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <CAOZdJXUmgD+GjuvdLMVErYRs7tsGXOxWROi6YGDvf0yHSOBA_w@mail.gmail.com>
 <CA+7tXigKNQM2ci1Qxc8BjUFyQhNURGvAx=wD0CEim8izMGtU1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BDF43265F51
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 18:01:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CA+7tXigKNQM2ci1Qxc8BjUFyQhNURGvAx=wD0CEim8izMGtU1w@mail.gmail.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Estevam Fabio-R49496 <r49496@freescale.com>, Tabi Timur-B04825 <B04825@freescale.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "gcembed@gmail.com" <gcembed@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 07, 2012 at 01:39:26AM -0400, Trent Piepho wrote:

Don't top post!

> It depends on the codec connected to the I2S.  We have SSI that works
> in mono mode, using a modified driver.  Our codec allows mono playback
> by only using the samples on the left channel.

This is extremely common.

From: Estevam Fabio-R49496 <r49496@freescale.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Do not read registers
 prior to turning on the supplies
Date: Fri, 31 May 2013 05:09:52 +0000
Message-ID: <86D15885F63D1143A519F161FB828EAF265F56@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1369749858-21579-1-git-send-email-fabio.estevam@freescale.com>
 <20130528143255.GK3660@sirena.org.uk>,<201305310036.11681.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 9859026538B
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 07:10:18 +0200 (CEST)
In-Reply-To: <201305310036.11681.marex@denx.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Marek,

(Sorry for the top-posting here)

There is a delay of 23 seconds, which is 1 second for each sgtl500- register write.

This is an I2C issue and we have already talked about this on the linux-arm-kernel list.

Alexandre Belloni also sees this 1 second on another I2C device connected to mx28.

Regards,

Fabio Estevam
________________________________________
From: Marek Vasut [marex@denx.de]
Sent: Thursday, May 30, 2013 5:36 PM
To: alsa-devel@alsa-project.org
Cc: Mark Brown; Estevam Fabio-R49496
Subject: Re: [alsa-devel] [PATCH] ASoC: sgtl5000: Do not read registers prior to turning on the supplies

Hi Mark, Fabio,

> On Tue, May 28, 2013 at 11:04:18AM -0300, Fabio Estevam wrote:
> > Commit b871f1ad (ASoC: sgtl5000: Read SGTL5000_CHIP_ID in i2c_probe())
> > placed the code for reading the codec revision prior to turning on the
> > power supplies.
> >
> > Even though this works on some systems that always have the codec power
> > supplies enabled, this is not correct, so revert this commit.
>
> It seems like a better fix for this is to just enable the supplies while
> doing the device identification?

This patch does kinda fix it for me, but the system takes quite some time to
init the soundcard now (a few seconds). After reverting these two patches, the
soundcard works just fine (like before):

    ASoC: sgtl5000: Fix driver probe after reset
    ASoC: sgtl5000: Read SGTL5000_CHIP_ID in i2c_probe()

Best regards,
Marek Vasut

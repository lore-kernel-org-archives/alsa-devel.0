From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/3] Add support for Cirrus Logic
 CS47L24 and WM1831 codecs
Date: Mon, 19 Oct 2015 16:04:33 +0100
Message-ID: <1445267073.3536.32.camel@rf-debian.wolfsonmicro.main>
References: <1445264027-7357-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <CAG5mAdxCPdPXbieWUTph0WeboQcRNX5hXwzQiGqouartK2M9SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E09312604D1
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 17:04:42 +0200 (CEST)
In-Reply-To: <CAG5mAdxCPdPXbieWUTph0WeboQcRNX5hXwzQiGqouartK2M9SA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: devicetree@vger.kernel.org, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-10-19 at 07:52 -0700, Caleb Crome wrote:
> (Accidentally sent HTML format last time, so re-sending...)
> 
> Does anybody have support written for the CS53L30 4 channel ADC ?
> 
> 
> Thanks,
>  -Caleb
> 

You'd be more likely to get a reply to that if you started a new thread
that included in the email title the part number of the device you are
interested in. It not reasonable to assume that someone who knows about
the CS53L30 would expect to find a discussion of it under a thread about
a different device.

> On Mon, Oct 19, 2015 at 7:13 AM, Richard Fitzgerald
> <rf@opensource.wolfsonmicro.com> wrote:
> > mfd patch based on Lee Jones's for-next
> > gpio patch based on Linus Walleij's for-next
> > ASoC patch based on Mark Brown's for-next
> >
> > Lee/Mark - can one of you take all three patches (with maintainer acks) so
> > that the patch set is kept together?
> >
> > Richard Fitzgerald (3):
> >   mfd: arizona: Support Cirrus Logic CS47L24 and WM1831
> >   gpio: arizona: Support Cirrus Logic CS47L24 and WM1831
> >   ASoC: cs47l24: Add driver for Cirrus Logic CS47L24 and WM1831 codecs
> >
> >  Documentation/devicetree/bindings/mfd/arizona.txt |    4 +-
> >  drivers/gpio/gpio-arizona.c                       |    4 +
> >  drivers/mfd/Kconfig                               |   19 +-
> >  drivers/mfd/Makefile                              |    3 +
> >  drivers/mfd/arizona-core.c                        |   74 +-
> >  drivers/mfd/arizona-irq.c                         |   40 +-
> >  drivers/mfd/arizona-spi.c                         |    7 +
> >  drivers/mfd/arizona.h                             |    4 +
> >  drivers/mfd/cs47l24-tables.c                      | 1629 +++++++++++++++++++++
> >  include/linux/mfd/arizona/core.h                  |    3 +
> >  sound/soc/codecs/Kconfig                          |    8 +
> >  sound/soc/codecs/Makefile                         |    2 +
> >  sound/soc/codecs/cs47l24.c                        | 1148 +++++++++++++++
> >  sound/soc/codecs/cs47l24.h                        |   23 +
> >  14 files changed, 2942 insertions(+), 26 deletions(-)
> >  create mode 100644 drivers/mfd/cs47l24-tables.c
> >  create mode 100644 sound/soc/codecs/cs47l24.c
> >  create mode 100644 sound/soc/codecs/cs47l24.h
> >
> > --
> > 1.9.1
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

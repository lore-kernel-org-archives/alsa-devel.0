From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 3/8] mfd: arizona: Add support for WM8998 and WM1814
Date: Fri, 8 May 2015 10:11:45 +0100
Message-ID: <20150508091145.GA9991@opensource.wolfsonmicro.com>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com> <1430493319-23808-4-git-send-email-rf@opensource.wolfsonmicro.com> <20150507085238.GA16220@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150507085238.GA16220@x1>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 07, 2015 at 09:52:38AM +0100, Lee Jones wrote:
> On Fri, 01 May 2015, Richard Fitzgerald wrote:
> 
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > ---
> >  drivers/mfd/Kconfig                   |    6 +
> >  drivers/mfd/Makefile                  |    3 +
> >  drivers/mfd/arizona-core.c            |  105 ++-
> >  drivers/mfd/arizona-i2c.c             |    8 +
> >  drivers/mfd/arizona-irq.c             |    9 +
> >  drivers/mfd/arizona.h                 |    5 +
> >  drivers/mfd/wm8998-tables.c           | 1592 +++++++++++++++++++++++++++++++++
> >  include/linux/mfd/arizona/core.h      |    3 +
> >  include/linux/mfd/arizona/pdata.h     |    2 +
> >  include/linux/mfd/arizona/registers.h |  220 +++++
> >  10 files changed, 1945 insertions(+), 8 deletions(-)
> >  create mode 100644 drivers/mfd/wm8998-tables.c
> 
> How orthogonal is this patch?  Can I just take it?
> 
> For my own reference:
>   Acked-by: Lee Jones <lee.jones@linaro.org>


This patches code added by patch 1 "mfd: arizona: Split INx_MODE into two fields" so you'll
need to take that one as well. But if you are ok with that change too then yes it's ok to
take both of them into mfd.


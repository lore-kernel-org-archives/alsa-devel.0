From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re:
 =?iso-8859-1?q?No_sound_captured_with_SGTL5000_on_i?=
 =?iso-8859-1?q?=2EMX6_in_I=B2S_master_mode?=
Date: Thu, 18 Sep 2014 11:39:11 -0700
Message-ID: <20140918183910.GF6432@Asurada>
References: <CAL8zT=jw4QQSzoq_8d0j-SXYEWzsNgz279dhDzjTHHr-jutP=Q@mail.gmail.com>
 <CAOf5uw=R0oHGDyFhueepoftfDb_d4vccO_751apBLg7S3gzGjg@mail.gmail.com>
 <CAL8zT=gcYkCRE9TU+2w+qBDtM+gYKqr-0KRDy7UxQXJ0P3LutQ@mail.gmail.com>
 <CAL8zT=igU9F=MZ0dQSgqgkq-T=PV-jbXAZeYAaMDs1ot_1MjCg@mail.gmail.com>
 <20140918170524.GA6080@Asurada>
 <CAOMZO5AqtNm3kwndUYszAuMfJ4CMOz4pwZRmE+04cEDtz98agg@mail.gmail.com>
 <20140918174935.GB6432@Asurada>
 <CAOMZO5AXN4p01=oGCydHUm6sPdt5NRNXO+4EOKQ1T7ZKUwVfMw@mail.gmail.com>
 <20140918180742.GC6432@Asurada>
 <CAOMZO5AvWecqimJkZcwysvsmPiq8Fa2Hm_XppCH3E1+vyjVzFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 32C6326558F
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 20:39:16 +0200 (CEST)
Received: by mail-pd0-f174.google.com with SMTP id v10so1953089pde.5
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 11:39:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AvWecqimJkZcwysvsmPiq8Fa2Hm_XppCH3E1+vyjVzFQ@mail.gmail.com>
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
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Michael Trimarchi <michael@amarulasolutions.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 18, 2014 at 03:14:08PM -0300, Fabio Estevam wrote:
> On Thu, Sep 18, 2014 at 3:07 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > On Thu, Sep 18, 2014 at 02:58:06PM -0300, Fabio Estevam wrote:
> >> > So that's why I put the swapping code in the fsl-asoc-card based on
> >> > CBx_CFx configurations.
> >>
> >> Correct, fsl-asoc-card is a nice approach. Good job!
> >
> > I plan to replace imx-sgtl5000 and imx-wm8962 with it as long as
> > people are happy about the new driver. Would you like to help me
> > testing it on sgtl5000 side when you have time? Because I only
> > have a board with WM8962.
> 
> Yes, I can test it on a imx53-qsb, which has sgtl5000. Just Cc me when
> you have the patch available.

It actually is merged into broonie/for-next and even linux-next I think.
I'll later send a patch to Shawn's tree for imx_v6_v7_defconfig changes
after next merge window's done.

Thank you
Nicolin

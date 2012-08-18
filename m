From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: Lockups reading from i.MX51 SSI registers
Date: Sat, 18 Aug 2012 08:31:28 +0200
Message-ID: <1345271488.3694.1.camel@lovely>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
 <20120810195638.GF1451@pengutronix.de>
 <20120810201456.GL25520@pengutronix.de>
 <20120810210647.GG1451@pengutronix.de>
 <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
 <20120817222738.GH18871@opensource.wolfsonmicro.com>
 <CAOMZO5BgeW_z-zf3Auw6RCJg1o5L=DqWdVeF+0Xb_W=6hZJMnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 33D23264FA9
 for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2012 08:01:46 +0200 (CEST)
Received: by wibhq4 with SMTP id hq4so1843398wib.2
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2012 23:31:32 -0700 (PDT)
In-Reply-To: <CAOMZO5BgeW_z-zf3Auw6RCJg1o5L=DqWdVeF+0Xb_W=6hZJMnQ@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <kernel@pengutronix.de>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-08-17 at 20:35 -0300, Fabio Estevam wrote:
> On Fri, Aug 17, 2012 at 7:27 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Fri, Aug 17, 2012 at 04:08:47PM -0300, Fabio Estevam wrote:
> >
> >> Also, for the playback to work you need to install the SDMA firmware.
> >
> > This is deadlocking during boot, I'm getting nowhere near trying
> > playback.
> 
> Are you running a dt or non-dt kernel? In case of a dt kernel, can you
> share the dts file?

I suppose Mark means an i.MX35 not an i.MX51.

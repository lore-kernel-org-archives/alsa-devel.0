From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH V2] ASoC - Add support for upto 16 channels
 on OMAP MCBSP
Date: Sun, 08 Nov 2009 20:27:01 +0000
Message-ID: <1257712022.15162.2.camel@vega>
References: <1257454808.3576.397.camel@odin>
	<20091106202400.a0ded9c3.jhnikula@gmail.com>
	<6ed0b2680911071211g311e6399va88ff7daff7b8ed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 82FAA245FB
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 21:28:41 +0100 (CET)
Received: by ewy21 with SMTP id 21so9200834ewy.32
	for <alsa-devel@alsa-project.org>; Sun, 08 Nov 2009 12:28:40 -0800 (PST)
In-Reply-To: <6ed0b2680911071211g311e6399va88ff7daff7b8ed1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>, Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, 2009-11-07 at 22:11 +0200, Grazvydas Ignotas wrote:
> On Fri, Nov 6, 2009 at 8:24 PM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> > On Thu, 05 Nov 2009 21:00:08 +0000
> > Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> >
> >> From: Graeme Gregory <gg@slimlogic.co.uk>
> >>
> >> This patch increases the number of supported audio channels from 4
> >> to 16 and has been sponsored by Shotspotter Inc. It also fixes a
> >> FSYNC rate calculation bug when McBSP is FSYNC master.
> >>
> > I would not call it as bug but more like an implementation
> > restriction :-)
> >
> > But as the patch now requires that machine driver using OMAP as a
> > master must provide the sample rate generator input clock frequency, I
> > would like to hear how it will work on Pandora.
> >
> > Grazvydas: are you able to test is the Pandora still playing after applying
> > patch [1] to omap-mcbsp.c and my patch below to omap3pandora.c?
> >
> > I made an assumption that input clock frequency on Pandora is
> > 8 * 32 * sample_rate.
> 
> Seems to be working fine, tried playing several different sample rates
> and also recording path. FYI pandora has TWL4030 256FS clock connected
> to OMAP's CLKS pin.
> 
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>

Jarkko, Peter,

Any chance we could have your Ack before applying.

Thanks

Liam

From: Ian Lartey <ian@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Initial WM8741 CODEC driver
Date: Sat, 31 Jul 2010 00:31:08 +0100
Message-ID: <1280532668.2130.155.camel@Tapajos>
References: <1280508308.2130.148.camel@Tapajos> <1280510321.3059.36.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC6981037F5
	for <alsa-devel@alsa-project.org>;
	Sat, 31 Jul 2010 01:31:15 +0200 (CEST)
In-Reply-To: <1280510321.3059.36.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-07-30 at 18:18 +0100, Liam Girdwood wrote:
> Hi Ian,

Hi Liam,

> 
> On Fri, 2010-07-30 at 17:45 +0100, Ian Lartey wrote:
> > The WM8741 is a very high performance stereo DAC designed for audio
> > applications such as professional recording systems, A/V receivers and
> > high specification CD, DVD and home theatre systems. The device
> > supports PCM data input word lengths from 16 to 32-bits and sampling
> > rates up to 192kHz. The WM8741 also supports DSD bit-stream data
> > format, in both direct DSD and PCM-converted DSD modes.
> > 
> > TODO: Expand wm8741_set_dai_sysclk and rate_constraint members to
> > allow for all supported sample rate / Master Clock frequency
> > combinations.
> > Fully enable control of supplies.
> > 
> > 
> > Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
> > ---
> >  sound/soc/codecs/Kconfig  |    4 +
> >  sound/soc/codecs/Makefile |    2 +
> >  sound/soc/codecs/wm8741.c |  579
> > +++++++++++++++++++++++++++++++++++++++++++++
> >  sound/soc/codecs/wm8741.h |  214 +++++++++++++++++
> 
> Looks like your mailer has mangled this patch. 
> 
> Could you fix your mailer and resend.

A correction  is on the way.

> 
> Thanks
> 
> Liam 

Thanks,
       Ian.

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc,
	codec: Add SGTL5000 codec support to asoc
Date: Thu, 9 Dec 2010 12:15:14 +0000
Message-ID: <20101209121514.GC4469@rakim.wolfsonmicro.main>
References: <1291773989-22747-1-git-send-email-zhaoming.zeng@freescale.com>
	<20101208121155.GC16418@rakim.wolfsonmicro.main>
	<20101208192235.GA24928@ubuntu.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AC749103C80
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 13:15:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101208192235.GA24928@ubuntu.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zhaoming.zeng@freescale.com>
Cc: s.hauer@pengutronix.de, festevam@gmail.com, alsa-devel@alsa-project.org, arnaud.patard@rtp-net.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 09, 2010 at 03:22:35AM +0800, Zeng Zhaoming wrote:
> On Wed 2010-12-08 05:11:55, Mark Brown wrote:
> > On Wed, Dec 08, 2010 at 10:06:29AM +0800, zhaoming.zeng@freescale.com

> > > +	sgtl5000_set_bias_level(codec, codec->suspend_bias_level);

> > The CODEC will never be in any state above STANDBY at suspend.

> Is there any documentation describe the state machine? 

Not outside the source code.

> > > +	msleep(1);

> > This delay looks like it's in the wrong place?

> The SGTL5000 has an internal reset that is deasserted 8 SYS_MCLK cycles after 
> all power rails have been brought up. After this time communication can start.
> 
> So I think delay 1ms is safe for the next operations.

It needs to be tied much more clearly to the enables, then - that's not
clear at the minute, especially given that there's no code in the same
function that interacts with the hardware.

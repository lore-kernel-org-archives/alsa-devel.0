From: Liam Girdwood <lrg@ti.com>
Subject: Re: FW: [PATCH v3] ASoC: Add support for TI LM49453
 Audio codec
Date: Wed, 08 Feb 2012 10:57:30 +0000
Message-ID: <1328698650.3955.13.camel@odin>
References: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
	<4F323BF5.4010309@ti.com>  <1328692723.3955.4.camel@odin>
	<1328693854.21099.5.camel@vkoul-udesk3> <1328694877.3955.9.camel@odin>
	<1328697415.21099.8.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75]) by alsa0.perex.cz (Postfix) with ESMTP id 46AF62414C
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 11:57:35 +0100 (CET)
Received: by mail-ww0-f47.google.com with SMTP id ds11so282652wgb.16
	for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2012 02:57:32 -0800 (PST)
In-Reply-To: <1328697415.21099.8.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, M R Swami Reddy <MR.Swami.Reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-08 at 16:06 +0530, Vinod Koul wrote:
> On Wed, 2012-02-08 at 09:54 +0000, Liam Girdwood wrote:
> > Atm, the machine driver would have to enable any system clocks before
> > the codec driver could use them. 
> But how would machine driver know _when_?
> 

The machine driver gets all the PCM ops that the codec driver does and
is responsible for configuring CODEC PLLs and clocks (usually in it's
hw_params()).

> We want to dynamical turn off this clock when not is use and turn on
> only when codec is using. So I was thinking of turning this ON in
> codecs .set_bias_level callback, but how to propagate this into machine
> driver?
> 

It's usually done in the machine driver hw_params() since at this point
we know the rate, format etc that can have a bearing on the clock
configuration. You could switch it OFF in machine hw_free().

Liam

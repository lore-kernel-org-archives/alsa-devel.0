From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: dapm - Add DAPM for
	always	active DAC or ADC
Date: Tue, 24 Mar 2009 16:15:10 +0000
Message-ID: <20090324161510.GD5990@sirena.org.uk>
References: <49C8D8B0.8030807@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 41578103800
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 17:15:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49C8D8B0.8030807@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, '?????????' <kyungmin.park@samsung.com>, ????????? <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 24, 2009 at 09:57:20PM +0900, Joonyoung Shim wrote:
> This patch supports DAPM widget for always active DAC or ADC regardless
> of stream. This widgets will be used for voice call at TWL4030 codec.

> TWL4030 codec use the digital signal for voice call, so it needs DAC and
> ADC to change signal to digital or analog, however currently DAC and ADC
> widgets cannot support voice call because they are activated only when
> playback or capture is executed.

What's actually needed here is proper path management in the digital
domain.  Powering components on all the time is clearly suboptimal since
it consumes power when the bypass paths aren't in use, potentially
including power from other components 

This is something that's planned in for the core (there are devices out
there with more complex digital routing needs than can be solved with
this sort of configuration) but I can't give you a specific schedule for
it.

What I'd suggest doing for now is providing a direct analog link from
the ADC input to the DAC output for DAPM and then hooking in using
events on the widgets to manage the power of the DAC and ADC manually.
When the core gains support for digital routing this can be replaced.
Alternatively, if there is no integration with record or playback
required then there's no reason to represent them as DACs and ADCs, they
could be done as some other path element that DAPM does know about.

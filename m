From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: Add pinctrl PM to components of
	active DAIs
Date: Tue, 29 Oct 2013 10:06:34 +0800
Message-ID: <20131029020633.GA8386@MrMyself>
References: <1382695544-20946-1-git-send-email-b42378@freescale.com>
 <20131028164405.GK13643@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 68BCB2652BE
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 03:11:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131028164405.GK13643@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 28, 2013 at 09:44:05AM -0700, Mark Brown wrote:
> > +	for (i = 0; i < card->num_rtd; i++) {
> > +		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
> > +		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> > +		pinctrl_pm_select_default_state(cpu_dai->dev);
> > +	}
> > +
> 
> This is going to put the pins into the default state during resume,
> that'll mean that if we're resuming a device which wasn't in use over
> suspend it'll be left in the default state after resume instead of in
> the idle state.
> 
> I'd expect the selection of the default state to be part of starting an
> audio stream and to only do something to active streams on suspend and
> resume.

You're right. I'll refine it soon.

Thank you,
Nicolin Chen

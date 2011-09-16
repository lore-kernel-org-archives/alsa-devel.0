From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 17:26:31 +0100
Message-ID: <20110916162630.GB23727@opensource.wolfsonmicro.com>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>
	<s5hwrd8jy68.wl%tiwai@suse.de> <4E736F9B.6080206@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4F712433D
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 18:26:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E736F9B.6080206@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 10:47:39AM -0500, Timur Tabi wrote:

> Yes, I was concerned about that.  So should I be calling one of the
> snd_pcm_hw_constraint_xxx functions in the codec's .startup function?  That
> would require ASoC to call the machine driver's .startup function *before*
> calling the codec driver's .startup function, since the machine driver's
> .startup function is where I call the codec to tell it what the mclk frequency is.

This isn't good for systems which can dynamically configure the clocks
based on the sample rate, they will wish to reconfigure things after the
user selected the sample rate in hw_params().  I've said several times
that this is the reason we don't actually advertise rates based on the
current rates.

Machine drivers are currently best placed to set constraints if the
clocking is limited.

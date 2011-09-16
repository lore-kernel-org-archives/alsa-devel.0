From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 10:47:39 -0500
Message-ID: <4E736F9B.6080206@freescale.com>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>
	<s5hwrd8jy68.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 989F710380E
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 17:48:03 +0200 (CEST)
In-Reply-To: <s5hwrd8jy68.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> It's not optimal from some aspects.  Basically this should be resolved
> in hw_constraints, not in hw_params, so that the configurator can find
> the possible rates.  Otherwise you have no idea what rate would be
> accepted.

Yes, I was concerned about that.  So should I be calling one of the
snd_pcm_hw_constraint_xxx functions in the codec's .startup function?  That
would require ASoC to call the machine driver's .startup function *before*
calling the codec driver's .startup function, since the machine driver's
.startup function is where I call the codec to tell it what the mclk frequency is.

-- 
Timur Tabi
Linux kernel developer at Freescale

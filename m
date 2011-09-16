From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 18:27:14 +0200
Message-ID: <4E7378E2.9050200@metafoo.de>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>	<s5hwrd8jy68.wl%tiwai@suse.de>
	<4E736F9B.6080206@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 51EAE24340
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 18:27:55 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 09/16/2011 05:47 PM, Timur Tabi wrote:
> Takashi Iwai wrote:
> 
>> It's not optimal from some aspects.  Basically this should be resolved
>> in hw_constraints, not in hw_params, so that the configurator can find
>> the possible rates.  Otherwise you have no idea what rate would be
>> accepted.
> 
> Yes, I was concerned about that.  So should I be calling one of the
> snd_pcm_hw_constraint_xxx functions in the codec's .startup function?  That
> would require ASoC to call the machine driver's .startup function *before*
> calling the codec driver's .startup function, since the machine driver's
> .startup function is where I call the codec to tell it what the mclk frequency is.
> 

You mentioned in an earlyer mail that you can switch the sysclk rate at
runtime. So setting the constraints based on the current sysclk rate won't
really work. I think you need some mechanism to specify the supported rates on
a per machine driver basis.

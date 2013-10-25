From: Nicolin Chen <b42378@freescale.com>
Subject: Re: Is that reasonable to support pinctrl PM in ASoC
	core?
Date: Fri, 25 Oct 2013 18:00:51 +0800
Message-ID: <20131025100050.GF8385@MrMyself>
References: <20131024110743.GD8385@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D763265517
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 12:11:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131024110743.GD8385@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 24, 2013 at 07:07:43PM +0800, Nicolin Chen wrote:
> Hi all,
> 
> It's quite popular that more drivers are using pinctrl PM, for example:
> (Documentation/devicetree/bindings/arm/primecell.txt). Just like what
> runtime PM does, it would de-active and en-active pin group depending
> on whether it's being used or not.
> 
> And I think this pinctrl PM might be also beneficial to cpu dai drivers
> since they might have actual pins, and they can hypnotize/wake them up
> along with runtime PM:
> 
> @@ -183,6 +183,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
> 	struct snd_soc_dai_driver *codec_dai_drv = codec_dai->driver;
> 	int ret = 0;
> 
> +       pinctrl_pm_select_default_state(cpu_dai->dev);
> 	pm_runtime_get_sync(cpu_dai->dev);
> 	pm_runtime_get_sync(codec_dai->dev);
> 	pm_runtime_get_sync(platform->dev);
> 
> 		       
> As pinctrl PM is also reference counted and would return 0 if there
> is no pinctrl settings, this would not break current ASoC subsystem
> and any cpu dai driver.

This was a mistake that pinctrl PM seems to be not reference counting.
So I have to correct it here.

And I'm sorry if I misguided anyone.

Nicolin Chen


> 
> So I just want to ask if it's reasonable to add it. Or another one:
> is there anything similar to sleep pins? Although I've searched the
> whole ./sound directory, it seems no drivers under it is using this
> pinctrl PM.
> 
> Best regards,
> Nicolin Chen
> 

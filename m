From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio
	Interface driver.
Date: Wed, 20 Nov 2013 03:37:45 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828AE980@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101085904.GC28401@MrMyself>
 <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131104043338.GA2345@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 by alsa0.perex.cz (Postfix) with ESMTP id B248C261A24
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 04:37:49 +0100 (CET)
In-Reply-To: <20131104043338.GA2345@MrMyself>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guangyu Chen <guangyu.chen@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "timur@tabi.org" <timur@tabi.org>, Huan Wang <Huan.Wang@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Shawn Guo <Shawn.Guo@freescale.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "broonie@kernel.org" <broonie@kernel.org>, Zhengxiong Jin <Jason.Jin@freescale.com>
List-Id: alsa-devel@alsa-project.org

 
> The udelay just doesn't make sense to what you are talking about.
> 
> Does SAI really need 10us delay between two register-updating?
> 

No, this is not must be.

> We basically use udelay only if the IP hardware actually needs it: some
> IP needs time to boot itself up after doing software reset for example.
> But it doesn't look reasonable to me by using udelay to make sure "the
> last enabled".
> 
> And from the 'Synchronous mode' you just provided, there're another issue:
> 
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		tcsr |= FSL_SAI_CSR_TERE;
> +		rcsr |= FSL_SAI_CSR_TERE;
> +		writel(rcsr, sai->base + FSL_SAI_RCSR);
> +		udelay(10);
> +		writel(tcsr, sai->base + FSL_SAI_TCSR);
> +		break;
> +
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		if (!(dai->playback_active || dai->capture_active)) {
> +			tcsr &= ~FSL_SAI_CSR_TERE;
> +			rcsr &= ~FSL_SAI_CSR_TERE;
> +		}
> +		writel(rcsr, sai->base + FSL_SAI_RCSR);
> +		udelay(10);
> +		writel(tcsr, sai->base + FSL_SAI_TCSR);
> +		break;
> 
> ISSUE 1: You might make sure transmitter is the last enabled.
> 	 However, it's not the first disabled. Is this okay?
> 

Yes, this is just programming mistake. I'll revise it.

In this case the transmitter should be the last enabled and the first disabled.


> ISSUE 2: There are two cases listed in 'Synchronous mode'.
> 	 However, your driver doesn't take care of them.
> 	 The SAI's synchronous mode looks like more flexible
> 	 than SSI's. The driver needs to be more sophisticated
> 	 so that it can handle multiple cases when TX/RX clocks
> 	 are controlled by either TX or RX, and surely, the
> 	 asynchronous mode as well.
> 

Because in Vybrid the transmitter bit clock and frame sync are to be used by both the transmitter and receiver, and only this case can be used here, so now I only handle this case.

> 
> And there's another personal tip: I think you can first try to focus on
> this SAI driver and pend the others. There might be two many things you
> need to refine if you are doing them at the same time.
> 

I'll implement them later if needed.


--
Best Regards,
Xiubo

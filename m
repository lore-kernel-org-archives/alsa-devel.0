From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
 fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 10:13:05 -0500
Message-ID: <48528E81.2050901@freescale.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>	
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>	
	<9e4733910806122016q4e10b56atc2fb9c91e129d6cb@mail.gmail.com>	
	<9e4733910806122036g5b8d86f6wed526f29377a065d@mail.gmail.com>	
	<48526566.8080400@freescale.com>	
	<20080613150427.GA32377@rakim.wolfsonmicro.main>
	<9e4733910806130810y24e6a04bh12eed5a26d0a79c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id ADBC6103803
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 17:13:09 +0200 (CEST)
In-Reply-To: <9e4733910806130810y24e6a04bh12eed5a26d0a79c4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:

> My system works like you describe. We have an external clock
> generator. It needs to be set up in the fabric code.

But can the clock frequency change during runtime?  The current ASoC interface
can handle that.

> Isn't the parameter needed for codecs like AC97 where they supply the
> clock back to the CPU? Timur's device tree is the one with a codec
> clock rate. Are there other parameters the system might need to set
> into a codec?

The direction of the clock.  That's why I have "i2s-slave" in the SSI nodes.

-- 
Timur Tabi
Linux kernel developer at Freescale

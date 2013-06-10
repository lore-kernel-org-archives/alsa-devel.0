From: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: Re: [PATCH] ASoC: wm8962: Restore device state after
 reset in runtime resume
Date: Mon, 10 Jun 2013 11:54:18 +0000
Message-ID: <E31481825E4C03459FC878EE97CB2EFD02FE491C@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1370619797-17503-1-git-send-email-broonie@linaro.org>
 <20130608053457.GE19153@MrMyself>,<20130610094826.GN31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 43B14261281
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 13:54:23 +0200 (CEST)
In-Reply-To: <20130610094826.GN31367@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Fri, Jun 10,  Mark Brown wrote:
> Again this is to fix interactions with hardware control modes.  Since
> we're coming out of suspend mode where the device may well have been
> powered down we can be confident that nothing is actually using the
> PLLs.

I see your point. Then I think I'm okay with this patch. Please apply this to
the manline, it's really helpful.
Tested-by: Nicolin Chen <b42378@freescale.com>

And sir, I'm sorry if I push you. But I'm not sure about my patch:
([PATCH V5] ASoC: fsl: add imx-wm8962 machine driver)

Is there anything essential I need to improve?
Please find that thread and append your comments as before.

Thank you.
Nicolin Chen

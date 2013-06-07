From: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: Re: [PATCH] ASoC: WM8962: Set CLKREG_OVD if GP5_FN is
 not its reset value
Date: Fri, 7 Jun 2013 15:33:31 +0000
Message-ID: <E31481825E4C03459FC878EE97CB2EFD02FDA184@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1370607258-4750-1-git-send-email-b42378@freescale.com>,
 <20130607143905.GT31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A4B122610B7
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 17:34:04 +0200 (CEST)
In-Reply-To: <20130607143905.GT31367@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


On Fri, Jun 07, 2013,  Mark Brown wrote:

> Please use subject lines appropriate for the thing you're changing.

I'm sorry. I'll pay attention to it next time.

> You're missing a whole batch of handling of device reset here - look at
> how we handle things on power on.

Are you talking about the initial code in wm8962_probe()?
But after wm8962_runtime_resume(), register Clocking2 will be reset to its
default value without OVD-setting and won't be recovered after regcache_sync()
due to volatile_reg.
If I'm wrong about it, pls tell me. I'll be happy if this codec driver hasn't this issue.

Thank you.

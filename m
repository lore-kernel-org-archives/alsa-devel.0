From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: use snd_soc_register_card
 to register the card
Date: Tue, 11 Sep 2012 00:27:04 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B7080532B9@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1347314576-13832-1-git-send-email-timur@freescale.com>
 <1347314576-13832-2-git-send-email-timur@freescale.com>
 <20120911001330.GD30699@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 by alsa0.perex.cz (Postfix) with ESMTP id AE380264EF6
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 02:27:07 +0200 (CEST)
In-Reply-To: <20120911001330.GD30699@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <ED521BBBB428B54397990BDE2B5633B4@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> This should've been a separate patch...  if we we're going to do this we
> really should be doing it for all cards, not just this one, though it'd
> be better to either remove or fix the logging itself.

Ok, I'll split it, but I do agree that it should be fixed in ASoC itself. 
  I just don't know how to do that.

I do admit that my change is a band-aid.

-- 
Timur Tabi
Linux kernel developer at Freescale

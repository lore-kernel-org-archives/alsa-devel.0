From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: ssm4567: Add driver for Analog
 Devices SSM4567 amplifier
Date: Fri, 26 Sep 2014 22:42:20 +0200
Message-ID: <5425CFAC.6080607@metafoo.de>
References: <1411747721-38619-1-git-send-email-anatol.pomozov@gmail.com>	<54259EC9.3060109@metafoo.de>
 <CAOMFOmUOzO1M_1TKPommxuj9G8d42_DxQMwF7KVcK=8G022EBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-130.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 321C12604EA
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 22:42:11 +0200 (CEST)
In-Reply-To: <CAOMFOmUOzO1M_1TKPommxuj9G8d42_DxQMwF7KVcK=8G022EBw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/26/2014 10:38 PM, Anatol Pomozov wrote:
> I've fixed the items you mentioned.
>
> One difference I spotted between your and mine patches is that you
> don't call regcache_cache_only(regmap) before powering down the
> device. Is it because I2C alive in power down mode? I guess I need to
> remove regcache_cache_only() then.
>

Yes, the interface should be alive, unless of course you disable the 
regulator. But having the regcache_cache_only() should not hurt, except that 
we need to resync the registers on power on, which can cause small 
additional delays.

- Lars

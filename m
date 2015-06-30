From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH] ASoC: wm8960: update pll and clock setting
 function
Date: Tue, 30 Jun 2015 16:54:09 +0800
Message-ID: <20150630085347.GA22709@shlinux2>
References: <5630bd343217e8fa895c5d133497f50739417453.1435316484.git.zidan.wang@freescale.com>
 <20150629094412.GH6321@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0125.outbound.protection.outlook.com [65.55.169.125])
 by alsa0.perex.cz (Postfix) with ESMTP id DE76D260410
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 12:02:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150629094412.GH6321@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 29, 2015 at 10:44:12AM +0100, Charles Keepax wrote:
> On Fri, Jun 26, 2015 at 07:09:22PM +0800, Zidan Wang wrote:
> > When using snd_soc_dai_set_pll to set pll in machine driver, we
> > should set pll in and pll out freq and ensure 5 < PLLN < 13,
> > otherwise set pll will be failed. In order to support more
> > formats and sample rates for a certain MCLK, if snd_soc_dai_set_pll
> > failed, it will calculate a available pll out freq and set the pll
> > again.
> > 
> > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> > ---
> 
> I think this need a little more explaination on how this is
> expected to work. From looking at the code what it looks like
> what happens is you can set a PLL frequency through set_pll but
> then if that frequency doesn't support the sample rate requested
> through hw_params it will be changed. This makes me a little
> nervous, as something explicitly requested is being overwritten
> automatically.
> 
>From RM, we should ensure 5 < PLLN < 13. When i using snd_soc_dai_set_pll
to set pll frequency, it's hard for me to get a common pll out frequency.
Sometimes, when codec MCLK or sample rate changed, the pll out frequency
also should be changed, otherwise set_pll function will be failed.

I made it to auto select pll frequency when snd_soc_dai_set_pll failed, so that
it can support more sample rate, and don't need to set different pll out
frequency for different sample rate and different MCLK.

> Would it perhaps be better to allow the auto selection of the
> PLL frequency only when things haven't been manually set, or
> provide some setting that indicates auto mode?
> 
> Thanks,
> Charles

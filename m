From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 3/3] ASoC: simple-card: add support for
 clock divider setup
Date: Sat, 23 Jun 2018 20:41:27 +0200
Message-ID: <b006a926-09ff-59e0-2b88-6f15e3e714e9@zonque.org>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-4-daniel@zonque.org>
 <20180529113509.GE23509@sirena.org.uk>
 <d6b9da97-8c71-ccfb-07e4-353620396a31@zonque.org>
 <20180530091011.GA6920@sirena.org.uk>
 <ace99dbd-3480-9ac3-e5b8-4ddae73bba10@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id C4E772675CA
 for <alsa-devel@alsa-project.org>; Sat, 23 Jun 2018 20:41:29 +0200 (CEST)
In-Reply-To: <ace99dbd-3480-9ac3-e5b8-4ddae73bba10@zonque.org>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On Wednesday, May 30, 2018 11:12 AM, Daniel Mack wrote:
> On Wednesday, May 30, 2018 11:10 AM, Mark Brown wrote:
>> On Tue, May 29, 2018 at 10:29:10PM +0200, Daniel Mack wrote:
>>> On Tuesday, May 29, 2018 01:35 PM, Mark Brown wrote:
>>
>>>> Why do we have anything that actually needs this?  The devices with a
>>>> set_clkdiv() operation are pretty legacy at this point and most of them
>>>> should just be figuring out the dividers for themselves anyway.
>>
>>> The PXA platform CPU DAI still has it, and grepping also reveals some
>>> Freescale and Samsung platforms.
>>
>> PXA is definitely very legacy, as are some of the Samsung and Freescale
>> ones - PXA in particular hasn't had much love in years.
> 
> Yes, I'm currently preparing a larger series of cleanups that I'll send
> for 4.18. I hope I can also tackle the clkdiv/pll things with that.

I'd like to get some of this done for 4.19, but for that, I'd need 
Robert's patch that addresses DMA compat issues in your tree.

Not sure if you've followed the thread titled '[PATCH v3 09/14] ASoC: 
pxa: remove the dmaengine compat need' - could you chime in there?


Thanks,
Daniel

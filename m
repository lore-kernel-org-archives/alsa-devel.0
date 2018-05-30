From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 3/3] ASoC: simple-card: add support for
 clock divider setup
Date: Wed, 30 May 2018 11:12:11 +0200
Message-ID: <ace99dbd-3480-9ac3-e5b8-4ddae73bba10@zonque.org>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-4-daniel@zonque.org>
 <20180529113509.GE23509@sirena.org.uk>
 <d6b9da97-8c71-ccfb-07e4-353620396a31@zonque.org>
 <20180530091011.GA6920@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D1DE266F88
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 11:12:15 +0200 (CEST)
In-Reply-To: <20180530091011.GA6920@sirena.org.uk>
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

On Wednesday, May 30, 2018 11:10 AM, Mark Brown wrote:
> On Tue, May 29, 2018 at 10:29:10PM +0200, Daniel Mack wrote:
>> On Tuesday, May 29, 2018 01:35 PM, Mark Brown wrote:
> 
>>> Why do we have anything that actually needs this?  The devices with a
>>> set_clkdiv() operation are pretty legacy at this point and most of them
>>> should just be figuring out the dividers for themselves anyway.
> 
>> The PXA platform CPU DAI still has it, and grepping also reveals some
>> Freescale and Samsung platforms.
> 
> PXA is definitely very legacy, as are some of the Samsung and Freescale
> ones - PXA in particular hasn't had much love in years.

Yes, I'm currently preparing a larger series of cleanups that I'll send 
for 4.18. I hope I can also tackle the clkdiv/pll things with that.


Thanks,
Daniel

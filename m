From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 3/3] ASoC: simple-card: add support for
 clock divider setup
Date: Tue, 29 May 2018 22:29:10 +0200
Message-ID: <d6b9da97-8c71-ccfb-07e4-353620396a31@zonque.org>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-4-daniel@zonque.org>
 <20180529113509.GE23509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 99091266F88
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 22:29:11 +0200 (CEST)
In-Reply-To: <20180529113509.GE23509@sirena.org.uk>
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

On Tuesday, May 29, 2018 01:35 PM, Mark Brown wrote:
> On Mon, May 28, 2018 at 09:35:03PM +0200, Daniel Mack wrote:
>> Add support to call into snd_soc_dai_set_clkdiv() for both CPU and codec
>> DAIs from simple-card's hw_params().
> 
>> This allows platforms to set hardware-specific values without providing an
>> own machine driver.
> 
> Why do we have anything that actually needs this?  The devices with a
> set_clkdiv() operation are pretty legacy at this point and most of them
> should just be figuring out the dividers for themselves anyway.

The PXA platform CPU DAI still has it, and grepping also reveals some 
Freescale and Samsung platforms.

If that's considered legacy, we shouldn't add bindings for it of course. 
I can look into the PXA driver and see if it can auto-detect the 
dividers itself. It won't be straight forward though as the clocking 
setup also depends on configurations such as TDM slots, external vs. 
internal clocks etc. Meh.


Thanks,
Daniel

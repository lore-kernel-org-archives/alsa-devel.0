From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: Re: [RFC V2 1/2] ASoC: img: Add binding document for
 Pistachio audio card
Date: Thu, 28 Jan 2016 14:17:37 +0000
Message-ID: <56AA2301.9070604@imgtec.com>
References: <1453818867-16322-1-git-send-email-Damien.Horsley@imgtec.com>
 <1453818867-16322-2-git-send-email-Damien.Horsley@imgtec.com>
 <20160127145756.GR6042@sirena.org.uk> <56A8DFBC.6070007@imgtec.com>
 <20160127160057.GA25316@sirena.org.uk> <56A8FAA5.1000907@imgtec.com>
 <20160127201457.GC25316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id DB88326047B
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 15:17:42 +0100 (CET)
In-Reply-To: <20160127201457.GC25316@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, James Hartley <james.hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

On 27/01/16 20:14, Mark Brown wrote:
> On Wed, Jan 27, 2016 at 05:13:09PM +0000, Damien Horsley wrote:
> 
>> audio_pll is referenced exclusively by the card device
> 
> That one *may* be plausible.
> 
>> i2s_mclk and dac_mclk can also be referenced by other devices. The i2s
>> out controller references i2s_mclk, and codec devices can reference
>> i2s_mclk/dac_mclk dependent on their system clock requirements
> 
> The clock API copes perfectly happily with this.
> 
>> without a reference to i2s_mclk and dac_mclk in the card driver, it
>> would not be possible to control the divisors and gates for these clocks
>> in the following cases:
> 
>> Simplistic codecs that do not have drivers
> 
>> Codec drivers that do not call clk_set_rate and clk_enable/clk_disable
> 
> Nonsense, if there is no driver or the driver doesn't do what you want
> then fix that.  Don't bodge things at the wrong abstraction layer, that
> just creates problems later on when someone comes along and does things
> properly or tries to use the device tree outside of your particular
> implementation (eg, when working with a differnet OS).
> 

Okay. If it can be expected that the codec driver will call these then
the references will not be required in the card driver for the codecs.

The i2s out controller also uses i2s_mclk, and calls clk_set_rate in
hw_params at present. Would creating a set_sysclk callback for the i2s
out controller, then calling snd_soc_dai_set_sysclk on the cpu dai in
addition to the codec dais in the card driver be the correct way to
manage this?

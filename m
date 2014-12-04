From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH 3/5] ASoC: dwc: Iterate over all channels
Date: Thu, 04 Dec 2014 09:13:01 +0000
Message-ID: <5480259D.6040106@arm.com>
References: <547F3CA5.2010500@arm.com>	<20141203172928.GD7712@sirena.org.uk>
 <CAA7nrthuG_4837JArAmmEkcBqfqRRUM5rzyZ1UcH3TqhfF79bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C983260549
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 10:13:03 +0100 (CET)
In-Reply-To: <CAA7nrthuG_4837JArAmmEkcBqfqRRUM5rzyZ1UcH3TqhfF79bg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: rajeev kumar <rajeevkumar.linux@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 12/04/14 06:55, rajeev kumar wrote:
> On Wed, Dec 3, 2014 at 10:59 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Wed, Dec 03, 2014 at 04:39:01PM +0000, Andrew Jackson wrote:
>>
>>> +     /* Iterate over set of channels - independently controlled.
>>> +      */
>>> +     do {
>>> +             if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>>> +                     i2s_write_reg(dev->i2s_base, TCR(ch_reg),
>>> +                                   xfer_resolution);
>>> +                     i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
>>> +                     irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
>>> +                     i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
>>> +                     i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
>>> +             } else {
>>> +                     i2s_write_reg(dev->i2s_base, RCR(ch_reg),
>>> +                                   xfer_resolution);
>>> +                     i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
>>> +                     irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
>>> +                     i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
>>> +                     i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
>>> +             }
>>> +     } while (ch_reg-- > 0);
>>
>> The normal way to write an iteration would be with a for loop - why are
>> we not doing that?
>>
>> Also I see that you've not sent these as a single thread - please use
>> --thread.
> 
> designware i2s has individual register for channel support. It is like
> TCR(0), TCR(1) and so on.. So a macro is defined to capture these
> please check below #define
> 
> #define TCR(x)      (0x40 * x + 0x034)
> 
> and the same is true for capture also. So there is no need for
> iteration. Only writing to the particular register will do the work.

However params_channels returns the number of channels that the device needs to configure.  So, for example, when there are four channels two sets of channel registers need to be programmed.


	Andrew
> 
> ~Rajeev
> 

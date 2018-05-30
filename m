From: Daniel Mack <daniel@zonque.org>
Subject: Re: Remove clkdiv and pll setters from pxa dais
Date: Wed, 30 May 2018 11:47:15 +0200
Message-ID: <47e32456-c603-1c9c-b6ef-3c98f000caf9@zonque.org>
References: <ca4efb05-36d3-1571-6336-394b75ecc843@zonque.org>
 <20180530092445.GC6920@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 22D7A2676B2
 for <alsa-devel@alsa-project.org>; Wed, 30 May 2018 11:47:16 +0200 (CEST)
In-Reply-To: <20180530092445.GC6920@sirena.org.uk>
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
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday, May 30, 2018 11:24 AM, Mark Brown wrote:
> On Wed, May 30, 2018 at 10:35:25AM +0200, Daniel Mack wrote:
> 
>> For instance, code for Zylonite does this:
> 
>>          /* Add 1 to the width for the leading clock cycle */
>>          pll_out = rate * (width + 1) * 8;
> 
>> The commit which introduced these lines dates back to 2009 and was done by
>> you, Mark. Can you remember what the reason for this was? I've never seen
>> sample frames with 17 bits :) This is a setup that we can't generically
>> describe through .hw_params() or .dai_fmt() in the cpu dai, correct?
> 
> I think it's copied from somewhere else probably, it looks like there's
> a bit of code motion going on.  I bet it was just for I2S, keeping the
> extra clock cycle for the initial rising edge in the frame but not
> actually required.

Hmm, okay. You happen to still have access to that board for regression 
tests?

>> So for both 22050 and 44100, the base frequency and all dividers are the
>> same, which can't be right. I assume these rates have never been used. I'll
>> ignore this and implement the table in the datasheet which should do the
>> right thing. Philipp?
> 
> That looks buggy, yeah.  I doubt anyone ever used 22.05kHz.

AFAIU, it's rather the 44.1 rate that looks wrong. But okay, we'll see.

>> What we need, however, is a way to describe whether the dai is mclk master
>> or slave. Would we add a DT propery for that?
> 
> That might be sensible, though the MCLK isn't really part of the DAI.

Well, the DAI may well be the producer of the MCLK. If there's only a 
master/slave mode to decide, we could set that property on the machine 
side as well, in the subnode of simple-card for instance (similar to 
'bitclock-master' and 'frame-master'), but then the question is which 
callback to use for propagating that master/slave setting to the cpu 
dai. We will, however, need such a callback anyway for non-DT boards, as 
those won't go away anytime soon. Could we squeeze that into the 
SND_SOC_DAIFMT_ mask? Not sure which options would be acceptable.


Thanks,
Daniel

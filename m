From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 13:14:08 -0600
Message-ID: <4282752b-80fd-fe13-69a2-6814f5b85ee4@linux.intel.com>
References: <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <4b358258-d7ae-d82e-cd58-d4b9e3b6f148@linux.intel.com>
 <20181217173930.GF27909@sirena.org.uk>
 <273cb3d8-7cd6-867a-ebb4-22217f88e0a8@linux.intel.com>
 <20181217190248.GI27909@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id CD4C2267AFC
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 20:14:09 +0100 (CET)
In-Reply-To: <20181217190248.GI27909@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Dimitris Papavasiliou <dpapavas@gmail.com>
List-Id: alsa-devel@alsa-project.org


On 12/17/18 1:02 PM, Mark Brown wrote:
> On Mon, Dec 17, 2018 at 12:08:36PM -0600, Pierre-Louis Bossart wrote:
>> On 12/17/18 11:39 AM, Mark Brown wrote:
>>> That looks a lot like the CODEC should be exporting a GPIO driver so the
>>> machine driver doesn't actually need the regmap?  The only register
>>> touched is _GPIO_CONTROL_1.
>> I am not sure what you meant by 'exporting a GPIO driver' (mostly because I
>> am not familiar with any GPIO framework) but indeed the local oscillator
>> choice is controlled by a single register accessible through regmap - and
>> changes to that register should only happen when the device is a specific
>> state to prevent click/pops.
> The GPIO framework provides a fairly simple view of GPIOs - from a user
> point of view it's just getting or setting the value of a line.  It
> looks like the register you're controlling isn't actually controlling a
> chip feature directly but rather is setting a GPIO on the chip which
> controls an external clock generator.  I could be misparsing things,
> though.  I did glance at the pcm512x datasheet and didn't see pins or
> anything that looked like an oscillator but I could've missed something.
You are correct, there are two variants of the Hifiberry DAC+, the 'PRO' 
version with two oscillators on board (SoC configured as bitclock and 
fsync slave) and the regular without (all clocks provided by the SoC in 
that case). It's indeed a GPIO control of an external component, not an 
on-chip capability.
>
>> The machine driver should use clk_set_rate() and not directly handle regmap
>> or codec stuff. If it does, or if the clock framework isn't relevant here
>> then we can simplify all this as suggested in
>> https://patchwork.kernel.org/patch/10444387/. What I was trying to do with
>> the github update is to keep the clock framework, tie it closer with the
>> codec parts with a state variable that prevents wild changes without going
>> back to a 'safe' idle state (similar idea as PulseAudio clock changes, which
>> can only happen when the PCM is not opened and used).
> Right, I think bringing in the clock framework more is good -
> effectively all I'm suggesting is changing the control interface used to
> set the clock to add an indirection through gpiolib so you don't need to
> pass the raw register map around.
this looks elegant indeed, will look into it. I'll have to learn more on 
gpios :-)

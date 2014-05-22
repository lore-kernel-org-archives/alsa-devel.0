From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] ASoC: max98090: Add master clock handling
Date: Thu, 22 May 2014 16:24:55 -0600
Message-ID: <537E7937.2010408@wwwdotorg.org>
References: <1400750228-13750-1-git-send-email-tushar.behera@linaro.org> <1400750228-13750-2-git-send-email-tushar.behera@linaro.org> <537E1D0A.6020303@wwwdotorg.org> <20140522173403.GL12304@sirena.org.uk> <537E38FF.9000407@wwwdotorg.org> <20140522181948.GP12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140522181948.GP12304@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tushar Behera <tushar.behera@linaro.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, tiwai@suse.de, perex@perex.cz, dianders@chromium.org, jerry.wong@maximintegrated.com
List-Id: alsa-devel@alsa-project.org

On 05/22/2014 12:19 PM, Mark Brown wrote:
> On Thu, May 22, 2014 at 11:50:55AM -0600, Stephen Warren wrote:
> 
>> I think we should nail down exactly what set_sysclk() means. Since it
>> takes an explicit MCLK clock rate (rather than e.g. sample rate) right
>> now, surely it's a notification of what the clock /is/, not a request
>> for the CODEC to set up its input clock. If we expect the CODEC to go to
> 
> It really should be that from a device model/clock API point of view and
> it certainly is with the patch proposed, the fact that it happens not to
> have been is just a product of the poor clock support in Linux than
> anything else.
> 
>> the clock driver and request an MCLK for itself (e.g. based on sample
>> rate), surely that should happen from some function besides
>> set_sysclk(), with different semantics e.g. hw_params().
> 
> I'm not sure where you see the CODEC going off and deciding the MCLK
> rate itself here?  Essentially all that's happening here is that
> set_sysclk() is behaving like the clock API does and setting its own
> rate to what it was explicitly asked to set, including bouncing that
> request up the chain.

If set_sysclk() is never allowed to do anything other than forward the
value it receives to the clock API, I'm much less concerned, althoguh
still a bit.

My main worry is that this patch opens the door for set_sysclk() to
perform some kind of calculation to determine the MCLK rate. Right now,
this patch doesn't do that, but there's nothing obvious from the code
that no CODEC is allowed to do that. After all, sysclk has a parameter
to indicate *which* clock in the CODEC to set. Some CODEC driver author
might write something where the machine driver tells the CODEC driver
the desired rate of some CODEC-internal PLL, from which set_sysclk()
calculates what it needs for MCLK, and then goes off and requests that
value from the clock API.

Ignoring that, I'm still not sure that the CODEC driver setting the MCLK
rate is appropriate. If we have 1 MCLK output from an SoC, connected to
2 different CODECs, why wouldn't the overall machine driver call
clk_set_rate() on that clock, and then notify the two CODEC drivers of
that rate. Making each CODEC's set_sysclk() call clk_set_rate() on the
same clock with the same value seems redundant, albeit it should work
out fine since they both request the same rate.

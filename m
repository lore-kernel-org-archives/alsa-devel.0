From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: dapm: Use SND_SOC_DAPM_INIT_REG_VAL in SND_SOC_DAPM_MUX
Date: Fri, 22 Nov 2013 11:35:09 -0700
Message-ID: <528FA3DD.8030507@wwwdotorg.org>
References: <1385141358-21956-1-git-send-email-swarren@wwwdotorg.org> <20131122183216.GP14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20131122183216.GP14725@sirena.org.uk>
Sender: stable-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, ac100@lists.launchpad.net, Stephen Warren <swarren@nvidia.com>, stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On 11/22/2013 11:32 AM, Mark Brown wrote:
> On Fri, Nov 22, 2013 at 10:29:18AM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>> 
>> SND_SOC_DAPM_MUX() doesn't currently initialize the .mask field.
>> This results in the mux never affecting HW, since no bits are
>> ever set or cleared. Fix SND_SOC_DAPM_MUX() to use
>> SND_SOC_DAPM_INIT_REG_VAL() to set up the reg, shift, on_val, and
>> off_val fields like almost all other SND_SOC_xxx() macros. It
>> looks like this was a "typo" in the fixed commit linked below.
> 
> Hrm.  Why has nobody else noticed this?  I've been doing plenty of 
> testing that involved changing muxes...  The patch and reasoning
> makes sense but I can't immediately see why any of the testing I've
> been doing recently would've worked without it since it all relies
> on muxes being configured to make any noise.

I think it's not the mux values/routing that matter, but the mux power
gating.

Also, if HW were to power up with muxes powered, then never changing
the power gate wouldn't have any effect (aside from increased power
consumption). In my case, the mux isn't powered by default, so I saw
an issue.

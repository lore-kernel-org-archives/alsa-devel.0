From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: Add support for multi register mux
Date: Thu, 20 Mar 2014 12:20:17 -0600
Message-ID: <532B3161.6080808@wwwdotorg.org>
References: <1395186692-11735-1-git-send-email-aruns@nvidia.com> <20140318235941.GT11706@sirena.org.uk> <781A12BB53C15A4BB37291FDE08C03F3A05CB21E46@HQMAIL02.nvidia.com> <20140320114829.GC11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140320114829.GC11706@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Arun Shamanna Lakshmi <aruns@nvidia.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Songhee Baek <sbaek@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On 03/20/2014 05:48 AM, Mark Brown wrote:
> On Wed, Mar 19, 2014 at 04:44:00PM -0700, Arun Shamanna Lakshmi wrote:
> 
> Don't top post and fix your mailer to word wrap within paragraphs, your
> mail is very hard to read.
> 
>> If each bit of a 32 bit register maps to an input of a mux, then with
>> the current 'soc_enum' structure we cannot have more than 64 inputs
>> for the mux (because of reg and reg2 only).
> 
> What makes you say that?  We currently have devices in mainline which
> have well over 32 inputs to muxes.

I think their register layout is different.

I found a number of large muxes where the register stores a 'integer'
indicating which mux input to select, e.g. Arizona, WM2200, etc. In this
case, an N-bit register could support up to 2^N inputs.

However, the registers in the Tegra AHUB use 1 bit position per input,
and require you to set one single bit at a time. Hence, an N bit
register (or string of registers) can support up to N inputs. In more
recent Tegra chips, we have at least >32 inputs and I think Arun was
saying even >64 inputs. That requires 2 or 3 or more .reg fields in
struct soc_enum.

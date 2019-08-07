From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: fix regmap dependencies and align
 with other serial links
Date: Wed, 7 Aug 2019 13:17:20 -0500
Message-ID: <5a7473a2-83c0-1a09-0cab-31fcc5b21302@linux.intel.com>
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0g5Hk9JYLvRXfLk5-o=n_RVPKtWD=QONpiimCWyQOFELQ@mail.gmail.com>
 <52a2cb0c-92a6-59d5-72da-832edd6481f3@linux.intel.com>
 <20190807175646.GK4048@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190807175646.GK4048@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, jank@cadence.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

> 
>> Vinod, Mark, any feedback?
> 
>> There will be a set of SoundWire codec drivers provided upstream soonish and
>> we'll get a number of kbuild errors without this patch.
> 
> I think I'm missing context here, I've basically been zoning out all the
> soundwire stuff - the patch series are huge and generate a bunch of
> discusion.  Is the patch below the full thing?  I don't see any obvious
> problems.

Here's a bit of context:

This patch is really independent from the 40-odd fixes I pushed about 10 
days ago. I provided an initial version back in April ('[PATCH v2 2/2] 
regmap: soundwire: fix Kconfig select/depend issue') during the first 
batch of updates. At the time, the suggested solution for the 
compilation issues was not agreed on, so the build errors remained - not 
a big deal they only show-up with codec drivers that were not upstreamed 
so far. It took me a while to come back to it but that was the first in 
my TODO list after my Summer break and now that we are almost ready to 
upstream those codec drivers it's a good time to revisit this issue.

Your initial feedback was:

"This now makes _SOUNDWIRE different to all the other bus types; if this
is a good change then surely the same thing should be done for all the
other bus types. "

and

"Alignment is a requirement.  If you want to optimize
this then it'd be better to optimize all the bus types rather than just
having the one weird bus type that does something different for no
documented reason."

I don't have the knowledge or means to test what I suggested initially 
for the other buses, and the optimization was minimal anyways, so this 
patch takes the path of least resistance and aligns with others.

if there are no objections it's probably easier to push this patch 
through the SoundWire tree, with the relevant Acks.

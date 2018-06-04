From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH] ASoC: pcm512x: enable set_sysclk
	callback
Date: Mon, 4 Jun 2018 08:48:40 -0500
Message-ID: <a933ad0d-70a8-b046-a0a0-3bdf5fb07d2e@linux.intel.com>
References: <20180601212643.20101-1-pierre-louis.bossart@linux.intel.com>
 <20180604104029.GA7536@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 36F32267A6C
 for <alsa-devel@alsa-project.org>; Mon,  4 Jun 2018 15:48:43 +0200 (CEST)
In-Reply-To: <20180604104029.GA7536@sirena.org.uk>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

On 6/4/18 5:40 AM, Mark Brown wrote:
> On Fri, Jun 01, 2018 at 04:26:43PM -0500, Pierre-Louis Bossart wrote:
>> For codec master mode, the current pcm512x code relies on the clock API.
> 
>> Simple boards such as Hifiberry DAC+ PRO rely on 2 local oscillators
>> to generate 44.1 or 48kHz multiples, with the clock selection being
>> handled by the machine driver toggling GPIOS.
> 
>> The RaspberryPi kernel exposes a "hifiberry,dacpro-clk" clock driver
>> which does nothing but tell the codec driver what rate is set by the
>> machine driver [1][2]
> 
>> This patch suggests an alternate fallback solution to let the codec
>> driver know what the sysclk is based on the existing .set_sysclk
>> callback.
> 
> I'm not seeing a great advantage in this - we want to have more adoption
> of standard APIs for clocking rather than less.  As that Pi board shows
> it's easy to create static clocks in the clock API so why not just do
> that?

What I find odd is the selection between the two static clocks. I have 
nothing against the clock API, I just find that the Pi solution isn't 
terribly elegant. The machine driver selects the 44.1 or 48kHz 
oscillator by configuring GPIO using registers exposed by the codec 
driver, the clock API implementation does nothing related to hardware, 
so we have three entities involved to flip 2 GPIOs.

And even if I use this solution, I still don't know how to tell the 
codec driver which sclk to use in an ACPI environment (this is to enable 
HiFiberry cards on Up/Up^2). At the moment the code does
pcm512x->sclk = devm_clk_get(dev, NULL);
and I don't have a moral equivalent for ACPI. I can add information for 
the codec driver to get from the DSDT, I'd need however a agreed 
solution based on _DSD or some property, and the thread with AMD on 
their 'mclk_name' topic for DA7219 didn't go anywhere, did it?

Bottom line there is an 'easy' solution for this specific case and a 
more complicated one but potentially more generic based on the clock API 
- hence the RFC.

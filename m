From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt5659: Add mclk controls
Date: Wed, 10 Aug 2016 12:31:28 -0500
Message-ID: <c794d543-a57a-aad6-1b62-4d101a79cdd3@linux.intel.com>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
 <20160728155732.GG11806@sirena.org.uk> <20160728181419.GA4742@Asurada-Nvidia>
 <20160728185510.GK11806@sirena.org.uk> <20160729161521.GL9681@localhost>
 <20160729163933.GJ10376@sirena.org.uk>
 <c649c3fe-b111-56a8-275e-d967a961dd41@linux.intel.com>
 <20160810170632.GL9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EE858266810
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 19:31:36 +0200 (CEST)
In-Reply-To: <20160810170632.GL9347@sirena.org.uk>
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
Cc: mark.rutland@arm.com, oder_chiou@realtek.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Darren Hart <dvhart@linux.intel.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, robh+dt@kernel.org, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

On 8/10/16 12:06 PM, Mark Brown wrote:
> On Wed, Aug 10, 2016 at 08:57:28AM -0500, Pierre-Louis Bossart wrote:
>
>> Without going into a debate on x86 v. the clock API or the merits of a patch
>> that has already been applied, I am pretty confused on who's supposed to
>> manage the mclk between the machine and codec driver.
>
>> So on a DAPM transition the clock is enabled. Fine.
>> What's not clear here is that the codec driver doesn't know what rates are
>> supported by the SOC/chipset. The machine driver is typically the one doing
>> calls such as
>
> This should really be being propagated through the clock tree by the
> clock API rather than open coded - for a lot of things it'll just boil
> down to a clk_set_rate() at the edge of the clock tree.  Any constraints
> should also be applied through the clock API, though in a lot of cases
> the devices are simple enough that it should be a fairly mechanical
> process.
>
>> so the summary is that we have two ways of doing the same thing - turning
>> the mclk on when it's needed - and I wonder if doing this in the codec is
>> really the right solution? Again this is not a question on the merits of the
>> clk API/framework but whether we can have a single point of control instead
>> of two pieces of code doing the same thing in two drivers.
>> If I am missing something I am all ears.
>
> We've got two ways of doing this at the minute partly because
> historically things have been open coded in the machine drivers due to
> the lack of a clock API, now we have one we can use we should be using
> it consistently to set rates.  Where the machine driver needs to do
> things dynamically it really ought to be able to express the constraints
> it's trying to set through the clock API, if we can't do things we need
> we should improve the clock API.  This will mean that we don't have to
> reinvent the wheel when we're doing things with clocks, we have
> consistent interfaces to all parts of the clock tree and other bits of
> the system will get reuse from anything we've learned about
> implementation.

If we want to be consistent then we need to have a framework that 
handles both the SOC clock sources and the codec internal clock tree 
(including dividers and switches)
I wonder if what you are hinting at is the codec driver modeling its 
internal PLL/clock tree with the clock API?
If we have the clock API requesting the mclk only, and the rest of the 
codec configuration is done by the machine driver there is no real 
progress I can see.

>
> The CODEC clearly has *some* idea of what's going on here, and
> especially for simpler CODECs the code to drive the clocking should be
> fairly easy to generalize as there's few options.  From a clock API
> point of view the CODEC really ought to be the one requesting the clocks
> that go into it, though there's nothing that says it has to only use its
> own information to do that.

I don't get the last part, how would the codec use information it 
doesn't own or have access to?
At any rate, I am only trying to define the problem statement, probably 
something to talk about at the Audio Miniconference.

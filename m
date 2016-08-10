From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5659: Add mclk controls
Date: Wed, 10 Aug 2016 16:59:03 -0500
Message-ID: <ff13c01a-a3f5-b11f-c342-926e98f64be3@linux.intel.com>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
 <20160728155732.GG11806@sirena.org.uk> <20160728181419.GA4742@Asurada-Nvidia>
 <20160728185510.GK11806@sirena.org.uk> <20160729161521.GL9681@localhost>
 <20160729163933.GJ10376@sirena.org.uk>
 <c649c3fe-b111-56a8-275e-d967a961dd41@linux.intel.com>
 <20160810170632.GL9347@sirena.org.uk>
 <c794d543-a57a-aad6-1b62-4d101a79cdd3@linux.intel.com>
 <20160810175243.GN9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160810175243.GN9347@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, mark.rutland@arm.com, oder_chiou@realtek.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Darren Hart <dvhart@linux.intel.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, robh+dt@kernel.org, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

On 8/10/16 12:52 PM, Mark Brown wrote:
> On Wed, Aug 10, 2016 at 12:31:28PM -0500, Pierre-Louis Bossart wrote:
>
>> If we want to be consistent then we need to have a framework that handles
>> both the SOC clock sources and the codec internal clock tree (including
>> dividers and switches)
>> I wonder if what you are hinting at is the codec driver modeling its
>> internal PLL/clock tree with the clock API?
>
> I'm not just hinting at that, I've openly stated it quite a few times
> now!  :P  For the simpler CODECs it's kind of marginal if you need to
> bother but for anything more complex (even things with PLLs) it seems
> like the way forwards.

interesting, thanks for the precision. I must admit I missed this 
concept completely and I didn't see any codec vendors work in this 
direction so far. Ironically the x86 part may be the most straightforward...

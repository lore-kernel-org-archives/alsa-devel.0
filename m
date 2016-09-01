From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] clk: x86: Add Atom PMC platform clocks
Date: Thu, 1 Sep 2016 18:32:44 -0500
Message-ID: <9df1be06-8415-8cff-9468-0c4938f6e0fc@linux.intel.com>
References: <1471459276-11517-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20160831003722.GH12510@codeaurora.org>
 <7c15a844-1351-f1ac-2ad0-3c41455fcc2e@linux.intel.com>
 <20160831170858.GA6560@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20160831170858.GA6560@sirena.org.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, irina.tirdea@intel.com, tiwai@suse.de, mturquette@baylibre.com, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 8/31/16 12:08 PM, Mark Brown wrote:
> On Tue, Aug 30, 2016 at 08:35:55PM -0500, Pierre-Louis Bossart wrote:
>> On 8/30/16 7:37 PM, Stephen Boyd wrote:
>
>>> It's sad that this can't be compiled on any platform. Has there
>>> been any move towards making this into a regmap provider so that
>>> this clk driver can use cross platform regmap APIs instead? Or
>
>> it's not clear to me what cross-platform goals you are hinting at and what
>> the concern is. We can add more framework stuff and make the code more
>> elegant but at the end of the day we will write in a very limited set of
>> registers (2 for audio - on/off and 19.2/25MHz selection) and the use of
>> this functionality is restricted to Baytrail and Cherrytrail.
>
> If code can be compiled on a wide range of platforms then that means
> that it's much easier to get build coverage of the code.  This is
> helpful for anyone doing any kind of cross tree updates - things like
> updating APIs for example.  The fewer configurations they have to touch
> to get everything built the easier it is for them.

ok, we can add a dummy pmc_write/read for non atom platforms so that 
changes in the clock framework API can be handled without configuration.
Using regmap to hide the IPC requests to the PCM seems a bit 
over-engineered - we are talking about 2 registers per clock - and bring 
limited benefits.

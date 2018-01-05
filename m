From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v6 07/14] regmap: Add SoundWire bus support
Date: Fri, 5 Jan 2018 11:22:15 -0600
Message-ID: <98480de5-cd6b-845f-df1d-c9593596055f@linux.intel.com>
References: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
 <1513230585-13882-8-git-send-email-vinod.koul@intel.com>
 <20180105170421.GE9076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180105170421.GE9076@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 1/5/18 11:04 AM, Mark Brown wrote:
> On Thu, Dec 14, 2017 at 11:19:38AM +0530, Vinod Koul wrote:
> 
>> +	/* SoundWire register address are contiguous */
>> +	if (config->reg_stride != 0)
>> +		return -ENOTSUPP;
> 
> That doesn't mean the chip hasn't decided not to use half the addresses
> for some reason - this isn't something the bus should be enforcing.

Good point. The contiguous requirement is valid only for normative 
registers, where the device has no choice but to follow the standard. 
For the imp-def part where regmap would typically be used, then indeed 
there is no restriction, chip implementers can do whatever they want.
I have a vague memory that regmap was only intended to be used for this 
latter case, but Vinod and team should clarify this.

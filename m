From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 2/2] regmap: soundwire: fix Kconfig select/depend issue
Date: Mon, 6 May 2019 10:28:35 -0500
Message-ID: <9f63f0dc-e4ce-bcdc-bee4-d12ebd3aa369@linux.intel.com>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
 <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
 <20190503043957.GA14916@sirena.org.uk>
 <535dfeac-77d8-1307-0329-33b8f2675bbd@linux.intel.com>
 <20190506044012.GM14916@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190506044012.GM14916@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 5/5/19 11:40 PM, Mark Brown wrote:
> On Fri, May 03, 2019 at 09:32:53AM -0500, Pierre-Louis Bossart wrote:
> 
>> As I mentioned it'll compile the bus even if there is no user for it, but
>> it's your call: alignment or optimization.
> 
> You can have both.  Alignment is a requirement.  If you want to optimize
> this then it'd be better to optimize all the bus types rather than just
> having the one weird bus type that does something different for no
> documented reason.

Fine, I'll align if this is the requirement.
Thanks for the feedback.

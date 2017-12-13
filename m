From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 10/15] soundwire: Add sysfs for SoundWire DisCo
 properties
Date: Wed, 13 Dec 2017 08:31:35 -0600
Message-ID: <dcb3c56b-e290-7017-b797-9bcc6f1132f0@linux.intel.com>
References: <1512575231-4154-1-git-send-email-vinod.koul@intel.com>
 <1512575231-4154-11-git-send-email-vinod.koul@intel.com>
 <20171213091537.GA6269@kroah.com> <20171213095430.GO18649@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171213095430.GO18649@localhost>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Mark <broonie@kernel.org>, Takashi <tiwai@suse.de>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org



On 12/13/2017 03:54 AM, Vinod Koul wrote:
>
>>> + * Base file is:
>>> + *		properties
>>> + *		|---- interface-revision
>>> + *		|---- master-count
>>> + *		|---- link-N
>>> + *		      |---- clock-stop-modes
>>> + *		      |---- max-clock-frequency
>>> + *		      |---- clock-frequencies
>>> + *		      |---- default-frame-rows
>>> + *		      |---- default-frame-cols
>>> + *		      |---- dynamic-frame-shape
>>> + *		      |---- command-error-threshold
>>> + */
>> Why nest them so deep?  Anyway, that's not really an issue I guess, it's
>> your ABI, not mine :)
> well it gives us a hierarchical view. We have N links...
The property definitions follows the MIPI DisCo spec, there's no real 
creativity here.
That said, Vinod you need to remove the master-count - as discussed on 
the other patch where this property is read this is not relevant for a 
master if you don't have a representation of a controller.

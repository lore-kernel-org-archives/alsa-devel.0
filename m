From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH 00/17] soundwire: fixes for 5.4
Date: Wed, 21 Aug 2019 09:03:27 -0500
Message-ID: <8ec1bed6-af4d-4be1-93b6-273ee27ce5e4@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
 <20190821090742.GI12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821090742.GI12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, Blauciak@gmail-pop.l.google.com, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, Slawomir <slawomir.blauciak@intel.com>
List-Id: alsa-devel@alsa-project.org



On 8/21/19 4:07 AM, Vinod Koul wrote:
> On 05-08-19, 19:55, Pierre-Louis Bossart wrote:
>> This series provides an update on the initial RFC. Debugfs and Intel
>> updates will be provided in follow-up patches. The order of patches
>> was changed since the RFC so detailed change logs are provided below.
> 
> Applied all except 14, which didnt apply, thanks

yes, that's a miss, there was a debugfs line that created a dependency 
with the other patches that were not applied because of the lack of 
alignment between soundwire/fixes and soundwire/next.
Will resubmit.

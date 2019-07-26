From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [RFC PATCH 00/40] soundwire: updates for 5.4
Date: Fri, 26 Jul 2019 13:14:04 +0200
Message-ID: <6d268dd6-5f1a-e1f4-b0be-c3b978f89cb1@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
List-Id: alsa-devel@alsa-project.org

On 2019-07-26 01:39, Pierre-Louis Bossart wrote:
> The existing upstream code allows for SoundWire devices to be
> enumerated and managed by the bus, but streaming is not currently
> supported.
> 
> Bard Liao, Rander Wang and I did quite a bit of integration/validation
> work to close this gap and we now have SoundWire streaming + basic
> power managemement on Intel CometLake and IceLake reference
> boards. These changes are still preliminary and should not be merged
> as is, but it's time to start reviews. While the number of patches is
> quite large, each of the changes is quite small.
> 
> SOF driver changes will be submitted shortly as well but are still
> being validated.
> 
> ClockStop modes and synchronized playback on
> multiple links are not supported for now and will likely be part of
> the next cycle (dependencies on codec drivers and multi-cpu DAI
> support).
> 
> Acknowledgements: This work would not have been possible without the
> support of Slawomir Blauciak and Tomasz Lauda on the SOF side,
> currently being reviewed, see
> https://github.com/thesofproject/sof/pull/1638
> 
> Comments and feedback welcome!

Hello Pierre,

This patchset is pretty large - I'd suggest dividing next RFC into 
segments: debugfs, info, power-management, basic flow corrections and 
frame shape calculator.
Some commits have no messages and others lack additional info - tried to 
provide feedback wherever I could, though, especially for the last one, 
it would be vital to post additional info so in-depth feedback can be 
provided.

Maybe nothing for calculator will come up, maybe something will. In 
general I remember it being an essential part of SDW and one where many 
bugs where found during the initial verification phase.

Thanks for your contribution and have a good day!
Czarek

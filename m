From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 0/3] soundwire: debugfs support for 5.4
Date: Fri, 16 Aug 2019 06:13:46 -0500
Message-ID: <9f4789b2-66bd-4b17-2b13-934348a18691@linux.intel.com>
References: <20190812235942.7120-1-pierre-louis.bossart@linux.intel.com>
 <20190816094308.GA12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816094308.GA12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com
List-Id: alsa-devel@alsa-project.org



On 8/16/19 4:43 AM, Vinod Koul wrote:
> On 12-08-19, 18:59, Pierre-Louis Bossart wrote:
>> This patchset enables debugfs support and corrects all the feedback
>> provided on an earlier RFC ('soundwire: updates for 5.4')
>>
>> There is one remaining hard-coded value in intel.c that will need to
>> be fixed in a follow-up patchset not specific to debugfs: we need to
>> remove hard-coded Intel-specific configurations from cadence_master.c
>> (PDI offsets, etc).
>>
>> Changes since v1 (Feedback from GKH)
>> Handle debugfs in a more self-contained way (no dentry as return or parameter)
>> Used CONFIG_DEBUG_FS in structures and code to make it easier to
>> remove if need be.
>> No functional change for register dumps.
>>
>> Changes since RFC (Feedback from GKH, Vinod, Guennadi, Cezary, Sanyog):
>> removed error checks
>> used DEFINE_SHOW_ATTRIBUTE and seq_file
>> fixed copyright dates
>> fixed SPDX license info to use GPL2.0 only
>> fixed Makefile to include debugfs only if CONFIG_DEBUG_FS is selected
>> used static inlines for fallback compilation
>> removed intermediate variables
>> removed hard-coded constants in loops (used registers offsets and
>> hardware capabilities)
>> squashed patch 3
> 
> These looks good but failed to apply. Please rebase on soundwire-next
> and resend

Could you do us a favor and make sure your soundwire/fixes branch is 
actually merged in soundwire/next? in this case the Makefile is changed 
in soundwire/fixes and not in next.
If you use git am --3way things work fine and the conflict is resolved.

Applying: soundwire: add debugfs support
Using index info to reconstruct a base tree...
M	drivers/soundwire/Makefile
M	include/linux/soundwire/sdw.h
Falling back to patching base and 3-way merge...
Auto-merging include/linux/soundwire/sdw.h
Auto-merging drivers/soundwire/Makefile
Applying: soundwire: cadence_master: add debugfs register dump
Applying: soundwire: intel: add debugfs register dump

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 0/5] soundwire: code cleanup
Date: Fri, 19 Apr 2019 12:07:38 -0500
Message-ID: <bb335979-61de-e2d7-d1b4-8e29e2beda49@linux.intel.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190414100417.GH28103@vkoul-mobl>
 <df6040ba-ab69-ae64-a27f-236e8ac95c14@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9950DF801D9
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 19:07:42 +0200 (CEST)
In-Reply-To: <df6040ba-ab69-ae64-a27f-236e8ac95c14@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com
List-Id: alsa-devel@alsa-project.org



On 4/15/19 7:57 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 4/14/19 5:04 AM, Vinod Koul wrote:
>> On 10-04-19, 22:16, Pierre-Louis Bossart wrote:
>>> SoundWire support will be provided in Linux with the Sound Open
>>> Firmware (SOF) on Intel platforms. Before we start adding the missing
>>> pieces, there are a number of warnings and style issues reported by
>>> checkpatch, cppcheck and Coccinelle that need to be cleaned-up.
>>
>> Applied, 1, 3 and 4 (5 looked good but didnt apply)
> 
> this applies on top of Mark Brown's for-next tree. This should be the 
> reference really for SoundWire work, if we start having another tree 
> with deltas it's really counter productive. I already have dependencies 
> on acpi...

Vinod, can you please double-check why patch 5 didn't work for you. I 
tried on Mark and Linus' trees and no issues, see below.

$ git reset --hard v5.1-rc5
HEAD is now at dc4060a5dc25 Linux 5.1-rc5

$ git am ~/Downloads/alsa/39/\[PATCH\ v3\ *.eml
Applying: soundwire: intel: fix inversion in devm_kcalloc parameters
Applying: soundwire: fix style issues
Applying: soundwire: bus: remove useless initializations
Applying: soundwire: stream: remove useless initialization of local variable
Applying: soundwire: add missing newlines in dynamic debug logs

$ git reset --hard broonie/for-next
HEAD is now at 84fdefca04a7 Merge branch 'asoc-5.2' into asoc-next

$ git am ~/Downloads/alsa/39/\[PATCH\ v3\ *.eml
Applying: soundwire: intel: fix inversion in devm_kcalloc parameters
Applying: soundwire: fix style issues
Applying: soundwire: bus: remove useless initializations
Applying: soundwire: stream: remove useless initialization of local variable
Applying: soundwire: add missing newlines in dynamic debug logs

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v3 0/4] soundwire: debugfs support for 5.4
Date: Fri, 23 Aug 2019 10:34:58 -0500
Message-ID: <cbf39078-1ef2-f05b-e2d7-b4695299e56b@linux.intel.com>
References: <20190821185821.12690-1-pierre-louis.bossart@linux.intel.com>
 <20190823063404.GB2672@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190823063404.GB2672@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>, Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



On 8/23/19 1:34 AM, Vinod Koul wrote:
> On 21-08-19, 13:58, Pierre-Louis Bossart wrote:
>> This patchset enables debugfs support and corrects all the feedback
>> provided on an earlier RFC ('soundwire: updates for 5.4')
>>
>> There is one remaining hard-coded value in intel.c that will need to
>> be fixed in a follow-up patchset not specific to debugfs: we need to
>> remove hard-coded Intel-specific configurations from cadence_master.c
>> (PDI offsets, etc).
> 
> Applied all (i did hand edit of patch 4 to resolve dependency), thanks

Thanks for the edit, appreciate not having to resend a series.

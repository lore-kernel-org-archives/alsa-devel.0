From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-lib] [PATCH] pcm: add set and get methods
 for no-rewind flag
Date: Wed, 31 Jan 2018 01:21:54 +0100
Message-ID: <b0aa94e1-7a54-2d9a-2e66-44ad65915a6e@linux.intel.com>
References: <1517304808-16649-1-git-send-email-sriramx.periyasamy@intel.com>
 <e9508663-98ce-0c5f-0306-412bdb3ba122@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E0A70267503
 for <alsa-devel@alsa-project.org>; Wed, 31 Jan 2018 01:21:58 +0100 (CET)
In-Reply-To: <e9508663-98ce-0c5f-0306-412bdb3ba122@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
Cc: Patches Audio <patches.audio@intel.com>, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

On 1/30/18 11:42 AM, Takashi Sakamoto wrote:
> Hi,
> 
> On Jan 30 2018 18:33, Sriram Periyasamy wrote:
>> From: Ramesh Babu <ramesh.babu@intel.com>
>>
>> Add functions to set/get no-rewind flag
>>
>> Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
>> Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
>> ---
>>   include/pcm.h          |  2 ++
>>   include/sound/asound.h |  1 +
>>   src/pcm/pcm.c          | 40 ++++++++++++++++++++++++++++++++++++++++
>>   src/pcm/pcm_local.h    |  1 +
>>   4 files changed, 44 insertions(+)
> 
> For this new flag, I post my comment to your work for kernel land[1].
> Please refer to it.
> 
> [1]
> http://mailman.alsa-project.org/pipermail/alsa-devel/2018-January/131336.html

I believed we missed your feedback, thanks for providing the pointer.

You wrote
"In my opinion, when drivers
return appropriate values at implementations of
"struct snd_pcm_ops.pointer" and "struct snd_pcm_ops.ack", your aim is
satisfied. In short, you can let ALSA PCM core to handle
rewinding/forwarding requests from userland for zero number of handled
frames in result. So the 'SNDRV_PCM_HW_PARAMS_NO_REWINDS' flag is
useless"

You may have missed that the hardware needs to know when the stream is 
opened if rewinds will be done or not. It's a contract between 
application and driver, just like the NO_IRQ mode, not a dynamic choice. 
If we enable the hardware capabilities and the application does a 
rewind, then it will be a true error with the stream having to be 
closed. That's not really desirable, is it?


> 
> Regards
> 
> 
> Takashi Sakamoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

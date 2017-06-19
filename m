From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH] ALSA: pcm: introduce ACK_APPLPTR flag
 and bump up interface version to v2.0.14
Date: Mon, 19 Jun 2017 21:54:12 +0900
Message-ID: <3444ebef-ffaa-1fe1-139d-a49e553b2d2e@sakamocchi.jp>
References: <20170618164921.9881-1-o-takashi@sakamocchi.jp>
 <s5hvantmdfu.wl-tiwai@suse.de> <s5hshixmcze.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 052AB266C24
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 14:54:15 +0200 (CEST)
In-Reply-To: <s5hshixmcze.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: vinod.koul@intel.com, clemens@ladisch.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Jun 19 2017 02:17, Takashi Iwai wrote:
> On Sun, 18 Jun 2017 19:08:05 +0200,
> Takashi Iwai wrote:
>>
>> On Sun, 18 Jun 2017 18:49:18 +0200,
>> Takashi Sakamoto wrote:
>>>
>>> Hi,
>>>
>>> This patchset includes commits for both kernel/user land for an issue
>>> addressed in this message thread[1].
>>>
>>> In a development period for v4.13, it's clear that there's a type of
>>> devices which demand userspace applications to change their behaviour.
>>> These devices can take care of application-side pointer on PCM buffer
>>> for their data transmission. As a result, these devices achieve some
>>> advantages. For these devices, drivers need to get feedback about
>>> current position of the pointer from applications when they
>>> queue/dequeue PCM frames on the buffer.
>>>
>>> ALSA PCM core partly assist the above design. The core can call a
>>> handler in driver side when applications operate PCM frames by
>>> ioctl(2) with SNDRV_PCM_IOCTL_[READ|WRITE][N|I] command. However,
>>> when operating for mapped PCM buffer, it can't assist applications
>>> for the above design. In this scenario, applications should call
>>> ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR after handle any PCM frames on
>>> the buffer.
>>>
>>> This patchset bumps up interface version with new info flag to
>>> notify the above change to user land developers. This patchset is
>>> written with below ideas:
>>>
>>> 1. Stuffs in user land can tell their assists for the above design
>>>     to kernel land by using hw_param flag. When they don't assist,
>>>     they see on hw_params data that mmap operation is not supported.
>>> 2. Drivers can acknowledge the above flag. When registering
>>>     appropriate PCM rules in advance, they can calculate values for
>>>     each parameters in both cases that stuffs in user land can/cannot
>>>     assist it. This is useful for packet-oriented drivers to judge
>>>     utilizing any interrupt context for packetization.
>>> 3. This is device-specific issue, independently of platform
>>>     architecture. On x86/ppc/alpha platforms, status/control data of
>>>     PCM substream is still available in process' VMA of application via
>>>     page frame mapping.
>>>
>>> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/121438.html
>>>
>>> For kernel land:
>>> Takashi Sakamoto (1):
>>>    ALSA: pcm: introduce ACK_APPLPTR flag and bump up interface version to
>>>      2.0.14
>>>
>>>   include/uapi/sound/asound.h | 11 ++++++++++-
>>>   sound/core/pcm_native.c     | 25 +++++++++++++++++++++++++
>>>   2 files changed, 35 insertions(+), 1 deletion(-)
>>>
>>> For user land:
>>> Takashi Sakamoto (2):
>>>    ALSA: pcm: introduce ACK_APPLPTR flag and bump up interface version to
>>>      2.0.14
>>>    pcm: add support for interface version 2.0.14
>>>
>>>   include/sound/asound.h | 11 ++++++++++-
>>>   src/pcm/pcm_hw.c       | 43 +++++++++++++++++++++++++++++++++++++------
>>>   2 files changed, 47 insertions(+), 7 deletions(-)
>>
>> Well, these mandate both kernel and user-side changes, so if you run
>> the old applications with old alsa-lib, it can't work, right?
> 
> I see now that you achieved it by dropping the whole mmap.

Just for drivers/hardwares with the new flag. I won't disable page frame 
mapping of control/status data indiscriminately for drivers with .ack 
callback.

> This is a very big concern from the performance POV.  It merely kills
> the whole merit of adding the appl_ptr notification (e.g. PA switches
> to a completely different mode), so this is likely no-go, sorry.

Old stuffs were not programmed to assist the new devices/drivers. It's 
quite natural to get a constrain to its working mode for several 
drivers/devices.

I focus on describing hardware/driver capabilities in interface for user 
land reasonably, instead of introducing them ex post facto.

...Well, I've already done for my proposal to this issue. Nothing left. 
I think you can understand what I insists for this issue and my concerns 
about your patch.

If you updates change log in the patch and post it, I'm willing to 
review it. I don't oppose it so hard (I understand the intention 
correctly), however it's important to pay enough attention to interfaces 
for applications. If the new stuffs bring changes to interface and 
applications get affects, we, developers for kernel land, should record 
and explain about it.


Regards

Takashi Sakamoto

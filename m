From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 7/7] ALSA: usb: take startup delay into
	account
Date: Tue, 4 Oct 2016 02:31:47 +0900
Message-ID: <9078cb95-5d56-c46f-2da1-43d7e9f0937e@sakamocchi.jp>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
 <1475239410-16548-8-git-send-email-subhransu.s.prusty@intel.com>
 <bcf3ecf2-04ba-8b4b-2659-aeea4c25f09b@sakamocchi.jp>
 <5bd1695b-4425-34a7-923e-894f01889117@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 60E0C26697F
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 19:31:51 +0200 (CEST)
In-Reply-To: <5bd1695b-4425-34a7-923e-894f01889117@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Louis,

On Oct 4 2016 00:08, Pierre-Louis Bossart wrote:
> On 10/3/16 1:46 AM, Takashi Sakamoto wrote:
>> Hi,
>>
>> On Sep 30 2016 21:43, Subhransu S. Prusty wrote:
>>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>
>>> For playback usages, the endpoints are started before the prepare
>>> step,
>>
>> As long as I understand, in ALSA USB audio device class driver,
>> submitting URBs starts at .prepare called by PCM core. So not before it
>> as long as the 'prepare step' means .prepare call.
> 
> The comment should have said 'started during the prepare step', you're
> right.

OK. Thanks for your confirmation.

We have the similar design in drivers with IEC 61883-1/6 packet
streaming engine for Audio and Music units on IEEE 1394 bus (locates in
sound/firewire/*). This is the reason I have interests in this patchset.

>>> and valid audio data will be rendered with a delay that
>>> cannot be recovered.
>>> Worst-case the initial delay due to buffering of empty URBS can
>>> be up to 12ms
>>
>> I thinks the aim of this patch is to add proper delay to current
>> calculation of estimated delay, due to the URBs accumulated between
>> .prepare and .trigger call. If so, it's better to explain about it in
>> the comment so that the other developers such as me can follow this
>> improvement.
> 
> Yes indeed. will fix but as replied to Takashi Iwai there are wider
> questions on why endpoints can't be linked and why the start times can't
> be set by the class driver.

>From me, an additional question.

There's no guarantee that applications call ioctl() with
SNDRV_PCM_IOCTL_START within 12 msec after ioctl() with
SNDRV_PCM_IOCTL_PREPARE. In this case, more URBs might be sumitted by
usb_submit_urb/snd_complete_urb() cycle, as long as I understand. So
it's quite rough to compute based on MAX_URBS (=12).

I think it better to use actual time (monotonic time or something
suitable) to compute the additional delay between .prepare and .trigger
calls. Or calculate queued packet between the two calls, then compute
the delay.


Thanks

Takashi Sakamoto

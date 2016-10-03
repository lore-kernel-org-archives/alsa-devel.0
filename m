From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 7/7] ALSA: usb: take startup delay into
 account
Date: Mon, 3 Oct 2016 10:08:50 -0500
Message-ID: <5bd1695b-4425-34a7-923e-894f01889117@linux.intel.com>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
 <1475239410-16548-8-git-send-email-subhransu.s.prusty@intel.com>
 <bcf3ecf2-04ba-8b4b-2659-aeea4c25f09b@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EEA7266BD4
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 17:08:47 +0200 (CEST)
In-Reply-To: <bcf3ecf2-04ba-8b4b-2659-aeea4c25f09b@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 10/3/16 1:46 AM, Takashi Sakamoto wrote:
> Hi,
>
> On Sep 30 2016 21:43, Subhransu S. Prusty wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> For playback usages, the endpoints are started before the prepare
>> step,
>
> As long as I understand, in ALSA USB audio device class driver,
> submitting URBs starts at .prepare called by PCM core. So not before it
> as long as the 'prepare step' means .prepare call.

The comment should have said 'started during the prepare step', you're 
right.

>
>> and valid audio data will be rendered with a delay that
>> cannot be recovered.
>> Worst-case the initial delay due to buffering of empty URBS can
>> be up to 12ms
>
> I thinks the aim of this patch is to add proper delay to current
> calculation of estimated delay, due to the URBs accumulated between
> .prepare and .trigger call. If so, it's better to explain about it in
> the comment so that the other developers such as me can follow this
> improvement.

Yes indeed. will fix but as replied to Takashi Iwai there are wider 
questions on why endpoints can't be linked and why the start times can't 
be set by the class driver.

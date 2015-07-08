From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/4] ALSA: core: let low-level driver
 or	userspace disable rewinds
Date: Wed, 08 Jul 2015 18:58:48 +0200
Message-ID: <559D56C8.8030605@linux.intel.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-2-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hmvz6hgrn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D0A26264F09
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 18:58:51 +0200 (CEST)
In-Reply-To: <s5hmvz6hgrn.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> Add new hw_params flag to explicitly tell driver that rewinds
>> will never be used. This can be used by low-level driver to
>> optimize DMA operations and reduce power consumption.
>> Use this flag only when data written in ring buffer will
>> never be invalidated, e.g. any update of appl_ptr is final.
>>
>> Caveat: there is currently no way to query capabilities without
>> opening a pcm stream, so applications might need to serially
>> open all exposed devices, check what they support by looking at
>> hw_params->info and close them (this is what PulseAudio does so
>> might not be an issue)
>
> The forward should also fail with such hardware, no?

The way I understand the forward is just an update of the application 
pointer without writing/reading new data, so that works. The hardware 
will just use whatever is in the ring buffer. It's weird but it would work.

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ALSA: hda/ca0132 - Update latency based
 on DSP state.
Date: Fri, 05 Apr 2013 16:24:11 -0500
Message-ID: <515F40FB.4010907@linux.intel.com>
References: <1365108909-13587-1-git-send-email-dgreid@chromium.org>
 <s5hehep4jt9.wl%tiwai@suse.de> <515EE730.6080705@linux.intel.com>
 <s5h4nfl2ea5.wl%tiwai@suse.de> <515EFBCA.9060101@linux.intel.com>
 <CAEUnVG7iLokj+biNXfrppp_z_toDCNPww-Y4QJXU3voC2a-FHg@mail.gmail.com>
 <515F07DA.1040608@linux.intel.com>
 <CAEUnVG4Zu63G+aYm+v90aFwnmW3oHnJGr4VOsK_fd2FBrgY7BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BDCE26262B
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 23:24:14 +0200 (CEST)
In-Reply-To: <CAEUnVG4Zu63G+aYm+v90aFwnmW3oHnJGr4VOsK_fd2FBrgY7BA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Is the 'audio' timestamp the one calculated in snd_pcm_update_hw_ptr0,
> based on either the hardware or the delay (INFO_HAS_WALL_CLOCK)?

Yes, correct.

>> In other words, if you add the codec delay, it's fine but it needs to be
>> accounted for in a symmetrical manner, otherwise the audio timestamp and the
>> delay will be off by a fixed amount. Correcting the wallclock value and
>> substracting the codec delay in azx_get_wallclk() would realign accounting
>> methods.
>
> Would this problem manifest on systems that don't support wall clock?
> Because the time based on delay will contain the codec delay?

If wall clock is supported, audio timestamp doesn't account for codec delay
If Wall clock is not suported, audio timestamp does account for codec 
delay with your patches.

> There are two distinct use cases:
>
> Wanting to know how the audio clock is drifting with respect to the
> system clock. (don't care about codec delay)
> Wanting to know when a sample will be rendered for AEC or A/V sync.
> (codec delay critical)
>
> Can we keep them from affecting one another?  This seems possible if
> the timestamp and delay are reported separately.

My suggestion is that the audio timestamp always accounts for codec 
delays, which will allow you to track drift and track rendering time. 
Btw for capture wallclocks are disabled for now since we don't really 
know how to use them for digital inputs, and we really need to have a 
consistent behavior for capture and playback.
-Pierre

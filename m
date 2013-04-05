From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH v2] ALSA: hda/ca0132 - Update latency based
 on DSP state.
Date: Fri, 5 Apr 2013 11:13:42 -0700
Message-ID: <CAEUnVG4Zu63G+aYm+v90aFwnmW3oHnJGr4VOsK_fd2FBrgY7BA@mail.gmail.com>
References: <1365108909-13587-1-git-send-email-dgreid@chromium.org>
 <s5hehep4jt9.wl%tiwai@suse.de> <515EE730.6080705@linux.intel.com>
 <s5h4nfl2ea5.wl%tiwai@suse.de> <515EFBCA.9060101@linux.intel.com>
 <CAEUnVG7iLokj+biNXfrppp_z_toDCNPww-Y4QJXU3voC2a-FHg@mail.gmail.com>
 <515F07DA.1040608@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A16C261B3E
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 20:14:04 +0200 (CEST)
Received: by mail-bk0-f48.google.com with SMTP id jf3so2247539bkc.35
 for <alsa-devel@alsa-project.org>; Fri, 05 Apr 2013 11:14:03 -0700 (PDT)
In-Reply-To: <515F07DA.1040608@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 5, 2013 at 10:20 AM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>> Thanks for the explanation Pierre, but I'm still a little confused.
>>
>> Does the timestamp represent the time the last sample was put in the
>> buffer or the time the last sample was rendered to the bus?
>>
>> Is the "current time" meant to be the timestamp that the next sample
>> sent will be rendered?  (timestamp + delay)
>
>
> When you query with snd_pcm_status(), you get all sort of information,
> including 2 timestamps. The 'regular' timestamp is just the system time
> (tsc) and the 'audio' timestamp is the time as reported by the audio
> hardware. This can be inferred by reading sample counters (# of samples
> pushed on the serial link) or wallclock counters, the wallclock is
> essentially identical but gives you a higher degree of precision. The audio
> time really needs to be taken at the last possible stage, not when you write
> into a buffer.
> The two timestamps can be used to find out what the drift is between the two
> time references (eg in PulseAudio)

I think I'm starting to understand this.  To go just a little bit deeper:

Is the 'audio' timestamp the one calculated in snd_pcm_update_hw_ptr0,
based on either the hardware or the delay (INFO_HAS_WALL_CLOCK)?

> In other words, if you add the codec delay, it's fine but it needs to be
> accounted for in a symmetrical manner, otherwise the audio timestamp and the
> delay will be off by a fixed amount. Correcting the wallclock value and
> substracting the codec delay in azx_get_wallclk() would realign accounting
> methods.

Would this problem manifest on systems that don't support wall clock?
Because the time based on delay will contain the codec delay?

There are two distinct use cases:

Wanting to know how the audio clock is drifting with respect to the
system clock. (don't care about codec delay)
Wanting to know when a sample will be rendered for AEC or A/V sync.
(codec delay critical)

Can we keep them from affecting one another?  This seems possible if
the timestamp and delay are reported separately.

> -Pierre
>

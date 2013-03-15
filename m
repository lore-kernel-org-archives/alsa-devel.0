From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 0/4] ALSA: Updates for the CA0132 codec
Date: Thu, 14 Mar 2013 17:34:34 -0700
Message-ID: <CAEUnVG6r+Ov9c2aMwUhpBgDsj8A4vPnsA4WA3nzyvnEPR=0T2A@mail.gmail.com>
References: <1360377105-2480-1-git-send-email-ian_minett@creativelabs.com>
 <s5ha9rczba1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f46.google.com (mail-ee0-f46.google.com [74.125.83.46])
 by alsa0.perex.cz (Postfix) with ESMTP id F26FC26161F
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 01:34:55 +0100 (CET)
Received: by mail-ee0-f46.google.com with SMTP id e49so1319146eek.5
 for <alsa-devel@alsa-project.org>; Thu, 14 Mar 2013 17:34:55 -0700 (PDT)
In-Reply-To: <s5ha9rczba1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 10, 2013 at 2:57 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Hi Ian,
>
> At Fri, 8 Feb 2013 18:31:41 -0800,
> Ian Minett wrote:
>>
>> From: Ian Minett <ian_minett@creativelabs.com>
>>
>> Hi,
>>
>> This series contains the following updates to CA0132:
>>
>> 1: Add firmware loading for the SpeakerEQ DSP effect.
>> 2: Improve DSP transfer timeout calculations.
>> 3: Add stream and effect latency monitoring routines
>> 4: Update hp unsolicited event handler to manage queued work.
>
> Thanks, I took the one now but leave others.  See my reply to each.
>
>>
>> These were based on the latest sound.git, but please let me know if
>> they should be against sound-unstable tree instead.
>
> sound.git tree for-next branch would be the place to look at.
> If I start a new branch for ca0132, I'll let you know.
>
>
> But, before going further: as I already mailed you, I could get a test
> board and started testing.  The result wasn't good.  At the first time
> the driver loads, the DSP loading fails always.  When the driver is
> reloaded after that, it's working.  So, something is still pretty
> fragile.

I tried this today and I can't get it to work.  It is failing in
snd_hda_lock_devices called from azx_load_dsp_prepare.  The DSP is
loaded from ca0132_init which is called as the result of open/resume.
Both the check for open control files and attached substreams are
failing. How can that be avoided?

Thanks,

Dylan

>
> I checked the code, and fixed a few overlooked things.  Now I wonder
> why dma_reset() must be called at each DSP chunk load.  It reallocates
> the whole buffer, and I see no reason.  It seems working even if I
> comment it out.  Could you clarify?
>
> Another thing I noticed is that I got a short burst noise at the very
> first playback.  After that, the driver starts working well.
> Is it some uninitialized buffer or so?
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

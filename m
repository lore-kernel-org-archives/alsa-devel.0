From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ALSA: hda - Apply codec delay to wallclock.
Date: Mon, 8 Apr 2013 17:05:35 -0700
Message-ID: <CAEUnVG6LT+v8ne7UVTrsaihiMoEbHvOO8yAibbh-pnCHvgf-Bg@mail.gmail.com>
References: <1365207724-6288-1-git-send-email-dgreid@chromium.org>
 <5162F0D0.7050402@linux.intel.com> <s5hy5ctx9po.wl%tiwai@suse.de>
 <CAEUnVG5Q05mtQSs=2=rMspUfMRYm8gS3G+FQRLZTWQq=Aap_rQ@mail.gmail.com>
 <5163549F.1050304@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f179.google.com (mail-ea0-f179.google.com
 [209.85.215.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FE06265D26
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 02:05:56 +0200 (CEST)
Received: by mail-ea0-f179.google.com with SMTP id f15so2523948eak.10
 for <alsa-devel@alsa-project.org>; Mon, 08 Apr 2013 17:05:56 -0700 (PDT)
In-Reply-To: <5163549F.1050304@linux.intel.com>
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

On Mon, Apr 8, 2013 at 4:37 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>> Of course you're right.  That's annoying, it will have to convert from
>> ms to frames (in get_delay) then to ns here.  Converting from frames
>> to ns here is a better idea, but for this particular codec, all I have
>> is ms resolution.
>
>
> This is odd, looks completely arbitrary...

It does, I'll change this patch to convert from frames to ns, and
check to see if the codec vendor can supply more accurate DSP latency
numbers.

>
>
>> Pierre,
>> What should the capture timestamp represent?  When the sample hits the
>> A-to-D or when it is read out of the buffer?
>
>
> When the samples hit A-to-D, as close as possible to the input (or the
> serial link if the codec doesn't report delay)

OK, the codec latency will be subtracted from both the playback and
capture times.

Thanks for the clarifications!

-dg

> -Pierre
>

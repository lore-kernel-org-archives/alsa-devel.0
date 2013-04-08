From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ALSA: hda - Apply codec delay to wallclock.
Date: Mon, 8 Apr 2013 09:56:47 -0700
Message-ID: <CAEUnVG5Q05mtQSs=2=rMspUfMRYm8gS3G+FQRLZTWQq=Aap_rQ@mail.gmail.com>
References: <1365207724-6288-1-git-send-email-dgreid@chromium.org>
 <5162F0D0.7050402@linux.intel.com> <s5hy5ctx9po.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f176.google.com (mail-ea0-f176.google.com
 [209.85.215.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 543B3265CC9
 for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2013 18:57:08 +0200 (CEST)
Received: by mail-ea0-f176.google.com with SMTP id h10so2360454eaj.7
 for <alsa-devel@alsa-project.org>; Mon, 08 Apr 2013 09:57:08 -0700 (PDT)
In-Reply-To: <s5hy5ctx9po.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 8, 2013 at 9:34 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 08 Apr 2013 11:31:12 -0500,
> Pierre-Louis Bossart wrote:
>>
>>
>> > +   if (hinfo->ops.get_delay) {
>> > +           codec_nsec =
>> > +                   hinfo->ops.get_delay(hinfo, codec, substream) * 1000000;
>> > +           if (stream == SNDRV_PCM_STREAM_CAPTURE)
>> > +                   nsec = (nsec > codec_nsec) ? nsec - codec_nsec : 0;
>> > +           else if (stream == SNDRV_PCM_STREAM_PLAYBACK)
>> > +                   nsec += codec_nsec;
>>
>> Can the .get_delay be modified to provide a better resolution than a ms?
>> If you already convert to time, microseconds would seem like a better
>> fit? Your codec seems to report frames (ie 20.83 us).
>
> Actually the patch must be wrong -- get_delay returns the delay in
> frame (sample) unit.

Of course you're right.  That's annoying, it will have to convert from
ms to frames (in get_delay) then to ns here.  Converting from frames
to ns here is a better idea, but for this particular codec, all I have
is ms resolution.

Pierre,
What should the capture timestamp represent?  When the sample hits the
A-to-D or when it is read out of the buffer?

Thanks,

-dg

>
>
> Takashi

Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E9AC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Mar 2022 19:30:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F05951738;
	Wed, 16 Mar 2022 20:29:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F05951738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647459010;
	bh=+t940QOnCV7ypuj4FVA7RnUF8oBpODqPzrfW1Al7tck=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jEsvYm7k/wb5ceWNaKbAP+5A+gFSQbYrTktkqJKtLI4OZpx1SH175IzSkvWF7Msx7
	 XiJURPckFc6nKQsWnWGj2DHYKgDIZH0j94fYd4DxkHR4wr5jvyluXmHYIa1Ee6Sx8o
	 +/ddS2rq2ETQaXcI/p9cB1NDR3krKSokm7hErFLc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BA2BF80153;
	Wed, 16 Mar 2022 20:29:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9907EF8019D; Wed, 16 Mar 2022 20:29:16 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FEB9F80095
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2022 20:29:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FEB9F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.b="UM0MNayj"
Received: by mail-lf1-x129.google.com with SMTP id bt26so5474360lfb.3
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2022 12:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kXm3aPGa6kumOLc0BpQgk8B33A75Ce44sP5rN5yEc48=;
 b=UM0MNayjkbqgfu1XWtyQYDhdQX7mfqFrOqJ5oTFXnVWReMsB2OW0NJS9z0mNjhhG7T
 N2kjjSIYqHXhSCpdeX1kH9/ZaHtGOMLhLlpsRan74z8rXHQzlg/+zNFykJGOa5jH7x5Y
 O3ezJcxIGCKF6PpACvz1gCAsDUwBPb8o3fyzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kXm3aPGa6kumOLc0BpQgk8B33A75Ce44sP5rN5yEc48=;
 b=11BQF+1bvUrC48ESsM9BjYpBBRlGsz2DbBDwr/LFfZJ3n1Gk53X39G8yrT+5NH05J1
 HW8gZLtz5hD6GQQ6X8869vZcnbQXfBUWYYANnLkBU9sRB88OPXZwCca7yRk5xq8FdDrk
 23J5fj85BfFnZSMV9l0mpAuSicu9c9Jttqy7fuUs8jTOEc8u6XP6rMgkqlKBVzFCOCjq
 jeOXACxVJvPJRO2S3ckv7g/EC7Wk8FDfe1sc9raKBV6Iy26XcOdzJEkTF98QpeOnzApc
 ThQk9K7MesluXbFzD5DyIQefVCj2gSbj1MfC+ZyUyuATDX78CC8XVLritDshNA3GU6R6
 pZHQ==
X-Gm-Message-State: AOAM531lm9+WDBnEHuNKsjdcsLFmq+2q2udeTkqYKvH3AXysLEOBLFPk
 tND178IzAlxdHBh8P92mVCrzstCwDhTXvXpgxcM=
X-Google-Smtp-Source: ABdhPJzGQBCSGAALK4TBTxa7SuSnBjjJo2spvWLCvzKV11APXr9KnVEjKqW1Fi3fsSA3KH20jdM8AA==
X-Received: by 2002:a05:6512:158d:b0:448:b751:2da0 with SMTP id
 bp13-20020a056512158d00b00448b7512da0mr652716lfb.371.1647458945813; 
 Wed, 16 Mar 2022 12:29:05 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com.
 [209.85.208.182]) by smtp.gmail.com with ESMTPSA id
 a1-20020a056512390100b004483b717210sm250685lfu.79.2022.03.16.12.29.03
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Mar 2022 12:29:03 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id s25so4482190lji.5
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2022 12:29:03 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr671918ljc.506.1647458942587; Wed, 16
 Mar 2022 12:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000085b1b305da5a66f3@google.com>
In-Reply-To: <00000000000085b1b305da5a66f3@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 16 Mar 2022 12:28:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLNbf7viXP74K59jK=sRkg6mUbj0i3qpQvy9_2S4Lbtg@mail.gmail.com>
Message-ID: <CAHk-=wjLNbf7viXP74K59jK=sRkg6mUbj0i3qpQvy9_2S4Lbtg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in snd_pcm_plugin_alloc (2)
To: syzbot <syzbot+72732c532ac1454eeee9@syzkaller.appspotmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
 Willy Tarreau <w@1wt.eu>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Mar 16, 2022 at 11:51 AM syzbot
<syzbot+72732c532ac1454eeee9@syzkaller.appspotmail.com> wrote:
>
> WARNING: CPU: 1 PID: 3761 at mm/util.c:591 kvmalloc_node+0x121/0x130 mm/util.c:591
>  snd_pcm_plugin_alloc+0x570/0x770 sound/core/oss/pcm_plugin.c:71
>  snd_pcm_plug_alloc+0x20d/0x310 sound/core/oss/pcm_plugin.c:118
>  snd_pcm_oss_change_params_locked+0x19db/0x3bf0 sound/core/oss/pcm_oss.c:1041
>  snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1104 [inline]
>  snd_pcm_oss_get_active_substream+0x164/0x1c0 sound/core/oss/pcm_oss.c:1121
>  snd_pcm_oss_get_rate sound/core/oss/pcm_oss.c:1778 [inline]
>  snd_pcm_oss_set_rate sound/core/oss/pcm_oss.c:1770 [inline]
>  snd_pcm_oss_ioctl+0x144f/0x3430 sound/core/oss/pcm_oss.c:2632

Well, that looks like a real bug in the sound subsystem, and the
warning is appropriate.

It looks like

        size = frames * format->channels * width;

can overflow 32 bits, and this is presumably user-triggerable with
snd_pcm_oss_ioctl().

Maybe there's some range check at an upper layer that is supposed to
catch this, but I'm not seeing it.

I think the simple fix is to do

        size = array3_size(frames, format->channels, width);

instead, which clamps the values at the maximum size_t.

Then you can trivially check for that overflow value (SIZE_MAX), but
you can - and probably should - just check for some sane value.
INT_MAX comes to mind, since that's what the allocation routine will
warn about.

But you can also say "Ok, I have now used the 'array_size()' function
to make sure any overflow will clamp to a very high value, so I know
I'll get an allocation failure, and I'd rather just make the allocator
do the size checking, so I'll add __GFP_NOWARN at allocation time and
just return -ENOMEM when that fails".

But that __GFP_NOWARN is *ONLY* acceptable if you have actually made
sure that "yes, all my size calculations have checked for overflow
and/or done that SIZE_MAX clamping".

Alternatively, you can just do each multiplication carefully, and use
"check_mul_overflow()" by hand, but it's a lot more inconvenient and
the end result tends to look horrible. There's a reason we have those
"array_size()" and "array3_size()" helpers.

There is also some very odd and suspicious-looking code in
snd_pcm_oss_change_params_locked():

        oss_period_size *= oss_frame_size;

        oss_buffer_size = oss_period_size * runtime->oss.periods;
        if (oss_buffer_size < 0) {
                err = -EINVAL;
                goto failure;
        }

which seems to think that checking the end result for being negative
is how you check for overflow. But that's actually after the
snd_pcm_plug_alloc() call.

It looks like all of this should use "check_mul_overflow()", but it
presumably also wants fixing (and also would like to use the
'array_size()' helpers, but note that those take a 'size_t', so you do
want to check for negative values *before* if you allow zeroes
anywhere else)

If you don't mind "multiplying by zero will hide a negative
intermediate value", you can pass in 'ssize_t' arguments, do the
multiplication as unsigned, put the result in a 'ssize_t' value, and
just check for a negative result.

That would seem to be acceptable here, and that
snd_pcm_oss_change_params_locked() code could also just be

        oss_period_size = array_size(oss_period_size, oss_frame_size);
        oss_buffer_size = array_size(oss_period_size, runtime->oss.periods);
        if (oss_buffer_size < 0) {
                ...

but I would suggest checking for a zero result too, because that can
hide the sub-parts having been some invalid crazy values that can also
cause problems later.

Takashi?

                 Linus

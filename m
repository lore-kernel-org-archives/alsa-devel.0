From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ALSA: sh: aica: Convert timers to use timer_setup()
Date: Thu, 5 Oct 2017 10:17:16 -0700
Message-ID: <CAGXu5jJsq3Nbu5hZc5S=PCG+2LiH+n7NMZ3xv=e5nhEwcjrRtA@mail.gmail.com>
References: <20171005005336.GA23796@beast> <s5h60but8pb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h60but8pb.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>, Bhumika Goyal <bhumirks@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 4, 2017 at 11:22 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 05 Oct 2017 02:53:36 +0200,
> Kees Cook wrote:
>>
>> In preparation for unconditionally passing the struct timer_list pointer to
>> all timer callbacks, switch to using the new timer_setup() and from_timer()
>> to pass the timer pointer explicitly. This requires adding a pointer to
>> hold the timer's target substream, as there won't be a way to pass this in
>> the future.
>>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Takashi Iwai <tiwai@suse.com>
>> Cc: Bhumika Goyal <bhumirks@gmail.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: alsa-devel@alsa-project.org
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> This requires commit 686fef928bba ("timer: Prepare to change timer
>> callback argument type") in v4.14-rc3, but should be otherwise
>> stand-alone.
>
> The conversions look straightforward, so I'm going to apply it (and
> other two you posted).  But now I wonder why only three were chosen.
> Will you keep working on the rest usages in sound/*, or would you
> expect us doing the rest?

Hi, thanks for applying them!

I'm working my way through the "non-trivial" changes first. I have a
coccinelle script that will do a mass-conversion of the common cases.
It's possible that those changes cover the other usages in sound/* or
that I haven't made my way through the others yet (it's a very long
list). I wouldn't object to other people helping with the conversions,
of course. :)

-Kees

-- 
Kees Cook
Pixel Security

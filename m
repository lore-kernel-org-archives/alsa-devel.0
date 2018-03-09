From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ASoC: soc-core: Add missing NULL check
Date: Fri, 9 Mar 2018 10:45:16 -0800
Message-ID: <CAGXu5jJo2JVXKV+nieGwzH0XOPpzzo4DmYy0L05iZD6wwO1vGg@mail.gmail.com>
References: <20180308200653.GA47801@beast> <20180309125050.GD5252@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309125050.GD5252@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Pavel Machek <pavel@ucw.cz>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 9, 2018 at 4:50 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Mar 08, 2018 at 12:06:53PM -0800, Kees Cook wrote:
>
>> If a codec is not attached to the sound soc, a NULL deref is possible as a
>> regular user in /sys.
>
> I can't parse this, sorry.  What is the "sound soc"?

SoC's sound component? I'm not sure either. :) I was just sending the
patch that I mentioned from the thread where Pavel mentioned this
Oops.

Pavel, can you isolate the specific file that is causing the oops?
(Maybe this patch should be a WARN() instead of silent return 0, since
we still don't want to crash, but it should be considered a bug...)

>
>> +++ b/sound/soc/soc-core.c
>> @@ -137,6 +137,9 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf,
>>       size_t total = 0;
>>       loff_t p = 0;
>>
>> +     if (!codec || !codec->driver)
>> +             return 0;
>> +
>
> How are we managing to create a sysfs file for a CODEC which doesn't
> have a CODEC struct associated with it?  That is obviously nonsensical
> and suggests we've got some more serious problem going on here - if
> there's no CODEC those sysfs attributes simply shouldn't be there.

No idea! Hopefully Pavel has more details...

-Kees

-- 
Kees Cook
Pixel Security

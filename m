From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH -next] soc: fix wm0010.c printk format warning
Date: Thu, 6 Sep 2012 02:22:22 +0200
Message-ID: <CA+icZUWKMrRoNL-vBpnAPPCdnJXRnOjJuQW9m7nJ3emjyOVOZQ@mail.gmail.com>
References: <20120905161230.3bab1de6d4c8c8e466c3b0df@canb.auug.org.au>
	<5047DF49.6070502@xenotime.net>
	<20120906000612.GO10580@opensource.wolfsonmicro.com>
	<5047EA1C.7080608@xenotime.net>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <5047EA1C.7080608@xenotime.net>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 6, 2012 at 2:11 AM, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On 09/05/2012 05:06 PM, Mark Brown wrote:
>
>> On Wed, Sep 05, 2012 at 04:24:57PM -0700, Randy Dunlap wrote:
>>> From: Randy Dunlap <rdunlap@xenotime.net>
>>>
>>> Fix printk format warning:
>>
>> Somone already sent this.  As ever please try to use subject lines
>> appropriate for the subsystem.  Please also consider who you're CCing -
>
>
> Unfortunately the MAINTAINERS file does not tell me what to include
> in the $subject line for the subsystem.
> What would you like to see there, please?  Maybe ASoC?
>

git log --oneline sound/soc/codecs/wm0010.c

Label looks like "ASoC: wm0010:"... (ASoC kills my shift key, I would
like to see all labels lower-case).

>> there's no need to copy -next on things like this which aren't
>
>
> I have always done a reply-to-all for linux-next patches, so after
> a few years someone days Don't Do That (IYO).
>

Then maintainers should check compiler-warnings in their area - regularly?

$ grep warning: v3.6.0-rc4-next20120905-1-iniza-generic/deb-pkg.log |
grep 'sound/soc' | wc -l
10

I agree that breakage and regressions should be dealt with higher
priority... Such patches like this should be welcome, anyway.

>> integration issues for example, if we start doing that then it'd get
>> drowned in noise from all the development.
>
>
> Agreed, many of us are already drowning from 1000+ emails per day.
> (seriously)
>

Spam will one day eliminate Email, it's perverted.

- Sedat -

> --
> ~Randy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-next" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

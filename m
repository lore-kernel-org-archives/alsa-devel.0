From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] ASoC: soc-dapm: Fix comparison of pointers
Date: Fri, 12 Dec 2014 14:43:27 +0100
Message-ID: <87h9x10yrk.fsf@rasmusvillemoes.dk>
References: <1418162021-32229-1-git-send-email-linux@rasmusvillemoes.dk>
	<20141212132109.GH11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141212132109.GH11764@sirena.org.uk> (Mark Brown's message of
	"Fri, 12 Dec 2014 13:21:09 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 12 2014, Mark Brown <broonie@kernel.org> wrote:

> On Tue, Dec 09, 2014 at 10:53:41PM +0100, Rasmus Villemoes wrote:
>
>>  	if (a->reg != b->reg)
>>  		return a->reg - b->reg;
>> -	if (a->dapm != b->dapm)
>> -		return (unsigned long)a->dapm - (unsigned long)b->dapm;
>> +	if (a->dapm < b->dapm)
>> +		return -1;
>> +	if (a->dapm > b->dapm)
>> +		return 1;
>
> If we're worrying about standards conformance type stuff here this is
> also buggy since it's out of spec to compare pointers that are not part
> of the same array like this.  Casting to uintptr_t is a better fix here.

I'm not worrying about standards conformance. Casting pointers to and
from [unsigned] long is done everywhere in the kernel, and that's
fine. But subtracting ints or longs and using the sign of the result for
comparison is simply wrong. See acbbe6fbb2 (kcmp: fix standard
comparison bug) for the long story. In this case the narrowing (when
BITS_PER_LONG==64) of the result from long to int just makes it even
more wrong.

Rasmus

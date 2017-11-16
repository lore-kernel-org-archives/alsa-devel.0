From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: ALSA: nm256: Fine-tuning for three function implementations
Date: Thu, 16 Nov 2017 20:30:24 +0100
Message-ID: <24f8c777-1eb4-e7e7-9371-79f32700c9dc@users.sourceforge.net>
References: <d98a2685-ddf9-1cba-839a-d12c5ff8d3ba@users.sourceforge.net>
 <s5hefoy16xg.wl-tiwai@suse.de>
 <dfa99045-f213-3dad-b1f4-2e90eb38ddbd@users.sourceforge.net>
 <s5h7euq9hqt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <s5h7euq9hqt.wl-tiwai@suse.de>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

>> There is a general source code transformation pattern involved.
>> So I find that it is systematic.
>>
>> But I did not dare to develop a script variant for the semantic patch
>> language (Coccinelle software) which can handle all special use cases
>> as a few of them are already demonstrated in this tiny patch series.
> 
> Then you're doing everything by hands,

I am navigating through possible changes around the pattern
“Use common error handling code” mostly manually so far.


> and can be wrong

Such a possibility remains as usual.


> -- that's the heart of the problem.

There might be related opportunities for further improvements.
Do you trust adjustments from an evolving tool more than
my concrete contributions?


> The risk is bigger than the merit by applying the patch.

I suggest to reconsider this view.

Would you dare to follow any of the presented arguments?


> So, just prove that your patch doesn't break anything.

Which kind of information would you find sufficient for a “prove”?


> Doesn't matter whether it's a test with real hardware
> or with systematic checks.

I assume that your development concerns matter more in this case.


> Once when it's confirmed, we can apply it.

I am curious if other contributors will become interested to confirm something.


> A very simple rule,

It might occasionally look simpler than it is in “special cases”.


> and this will be valid for most of other subsystems, too.

The response is also varying there as usual.

A few update suggestions from the discussed pattern were integrated
(also by you) already.
Would you like to continue with similar support in any ways?

Regards,
Markus

From: Nickolas Lloyd <ultrageek.lloyd@gmail.com>
Subject: Re: [PATCH] snd-hda-intel: Jack Mode changes for
	Sigmatel boards
Date: Mon, 25 May 2009 18:07:29 +0000
Message-ID: <4A1ADE61.2090702@gmail.com>
References: <4A13F91D.8010102@gmail.com> <s5hvdnp5wdv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 1192324469
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 02:58:06 +0200 (CEST)
Received: by gxk2 with SMTP id 2so6779568gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 17:58:06 -0700 (PDT)
In-Reply-To: <s5hvdnp5wdv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Matthew Ranostay <mranostay@embeddedalley.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Hi,
>
> sorry for the late review.  Some comments below.
>   
No worries.  I know you're busy, and I appreciate your time and help :)

>> +        i = 3;
>> +    else
>> +        i = 2;
>> +
>> +    uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
>> +    uinfo->value.enumerated.items = i;
>> +    uinfo->count = 1;
>> +    if (uinfo->value.enumerated.item >= i)
>> +        uinfo->value.enumerated.item = i-1;
>>     
>
> Didn't checkpatch.pl complain?  :)
>   
It didn't actually.  What should it have complained about, so I can fix it?
> Well, these two functions, stac92xx_vref_get() and stac92xx_get_vref()
> are too confusing.  We have to rename one of them, at least, or at best
> clean up a bit more.
I agree.  stac92xx_vref_get() and stac92xx_vref_set() are a pair, so
perhaps they should stay as they are, and stac92xx_get_vref() be renamed
to stac92xx_get_default_vref() or something?

>
> Hmm, this code flow is too complex and hackish to follow.
> There must be a better way.  For example, the complicated neted if
> checks can be put out to a function.  The compiler is clever enough to
> inline, and here is no critical code path for speed.
>
>
> Could you fix and repost please?
>
>
> thanks,
>
> Takashi
>
>   
I've added a function stac92xx_add_mic_jack_control() to take care of
the if's and add the control.  The code is much cleaner now IMO.  Is
this function name ok, and do you have any other thoughts?

I'll be posting the new patch soon so that you can actually look at that
as well.

Thanks,
Nick

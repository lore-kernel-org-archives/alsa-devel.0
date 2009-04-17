From: Peter-Jan Deweirdt <deweirdt@gmail.com>
Subject: Re: Cirrus Logic CS4207
Date: Fri, 17 Apr 2009 18:40:37 +0200
Message-ID: <1D8419C1-EDCD-4940-B498-C5FAA0959705@gmail.com>
References: <625B7AA8-CE98-4B12-A664-27A8B6599E7B@gmail.com>
	<s5hd4bbuyjh.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f166.google.com (mail-ew0-f166.google.com
	[209.85.219.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A6D5103809
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 18:40:39 +0200 (CEST)
Received: by ewy10 with SMTP id 10so1034374ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2009 09:40:39 -0700 (PDT)
In-Reply-To: <s5hd4bbuyjh.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I manged myself to change the patch for the kernel 2.6.29 but it seems  
that it's not working as it should.
And I don't want to change the patch everytime I need to update the  
kernel ;)

I'll check with the person that wrote the patch how we can submit it.

Regards Peter-Jan

On 17 Apr 2009, at 16:48, Takashi Iwai wrote:

> At Fri, 17 Apr 2009 10:33:47 +0200,
> Peter-Jan Deweirdt wrote:
>>
>> Hi,
>>
>> We are in the progress of developming a new platform and we are using
>> the audio chip CS4207 from Cirrus Logic (very new). I've noticed that
>> the audio is not working as it should.
>> I'm using the moblin menlow kernel and I'm able to see 1 playback
>> channel and 1 capture channel (which is not correct according to the
>> chip).
>>
>> I have retreived from our vendor a patch for the kernel (2.6.27.7)  
>> but
>> since the moblin kernel is based on the 2.6.29 I cannot use it, even
>> not verify if it's working.
>>
>> Would it be possible to look to the patch and maybe even integrate it
>> into a new build?
>> Or would it be possible to guide me trough so that the audio is
>> working properly?
>
> Changing this patch won't be too hard.  It's just a small rewrite
> of the codec hook-up part.
>
> But, for merging the patch, we need some formality, namely, a proper
> sign-off.  Could you get the sign-off of the original patch submitter?
> See $LINUX/Documentation/SubmittingPatches for details.
>
>
> thanks,
>
> Takashi

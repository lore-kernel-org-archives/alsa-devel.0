From: Viral Mehta <viral.mehta@einfochips.com>
Subject: Re: ALSA layer in Linux 2.6.18 and OSS
Date: Mon, 16 Feb 2009 16:55:59 +0530
Message-ID: <49994D47.10608@einfochips.com>
References: <49991BCE.40400@einfochips.com>
	<ad2655cb0902160304i33439a6fie7c029d918fe6af1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ahmedabad.einfochips.com (india.einfochips.com [203.88.139.151])
	by alsa0.perex.cz (Postfix) with ESMTP id E2DDD244B7
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 12:32:50 +0100 (CET)
In-Reply-To: <ad2655cb0902160304i33439a6fie7c029d918fe6af1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



James Courtier-Dutton wrote:
> 2009/2/16 Viral Mehta <viral.mehta@einfochips.com>:
>   
>> Hi All,
>>
>>
>> When I booted my kernel, I found that there was no "/dev/dsp" device and
>> so my application was not able to run. The application opens "/dev/dsp"
>> device first and then does other things.
>>
>>     
>
> /dev/dsp is the OSS API. So an install without OSS will not have /dev/dsp.
> An application that supports alsa will link to libasound.
> If you have an OSS application that you want to work with ALSA, you
> need to add the ALSA OSS emulation layer.

So, the last question.
Is it possible to write an application totally using ALSA user and 
kernel things (i.e., without having OSS emulation layer)?

In that case, if application will not open /dev/dsp then what ll it do ? 
Just pointers will be great for me.

And will it be possible to implement full-featured application which 
plays stereo and also provides equalizer and etc just by using ALSA ?
-- 
_____________________________________________________________________
Disclaimer: This e-mail message and all attachments transmitted with it
are intended solely for the use of the addressee and may contain legally
privileged and confidential information. If the reader of this message
is not the intended recipient, or an employee or agent responsible for
delivering this message to the intended recipient, you are hereby
notified that any dissemination, distribution, copying, or other use of
this message or its attachments is strictly prohibited. If you have
received this message in error, please notify the sender immediately by
replying to this message and please delete it from your computer. Any
views expressed in this message are those of the individual sender
unless otherwise stated.Company has taken enough precautions to prevent
the spread of viruses. However the company accepts no liability for any
damage caused by any virus transmitted by this email.
__________________________________________________________________________

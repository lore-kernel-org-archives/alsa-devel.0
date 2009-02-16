From: Viral Mehta <viral.mehta@einfochips.com>
Subject: Re: ALSA layer in Linux 2.6.18 and OSS
Date: Mon, 16 Feb 2009 16:27:06 +0530
Message-ID: <49994682.6010502@einfochips.com>
References: <49991BCE.40400@einfochips.com> <s5h63jairgn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ahmedabad.einfochips.com (india.einfochips.com [203.88.139.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D1DB24492
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 12:03:59 +0100 (CET)
In-Reply-To: <s5h63jairgn.wl%tiwai@suse.de>
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



Takashi Iwai wrote:
> At Mon, 16 Feb 2009 13:24:54 +0530,
> Viral Mehta wrote:
>   
>> Hi All,
>>
>> Next time, when I enabled few of the OSS options in kernel's config 
>> file. I was able to run my application. My question is I do not want OSS 
>> at all. I just need ALSA then in that case what I am doing wrong.
>>     
>
> Well, rather a real question is which app / subsystem accessing the
> OSS device and causes errors.
Thanks for quick response. Well, I myself am writing Audio Player 
application for some embedded device.
I generally used to write open("/dev/dsp") device and then do read/write 
of RAW data on that device and it used to work till now.
I was/am doing so and completely unaware of OSS/ALSA.
>   You can set up ALSA-only system in the
> kernel side.  
But then when I found while rebuilding kernel that there are two sound 
sub-system OSS and ALSA.
ALSA is a new one and OSS is deprecated. And so I thought to remove 
everything about OSS from Kernel.
> But if the user-space side requires the OSS API, it
> won't work.
>
>   
So, I guess my application is such that it wont work with ALSA-only-kernel.
But then on contrary, I think that opening a /dev/dsp and throwing data 
is a simple way AND what is so wrong in that and why ALSA-only-kernel 
cant understand that ?
> So,
> - if you want to remove all OSS-accessing apps, fix them
> or
> - build ALSA OSS *emulation* module so that they work both
> or
> - use aoss wrapper instead
>
>   









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

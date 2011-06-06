From: Greg Dietsche <gregory.dietsche@cuw.edu>
Subject: Re: [PATCH] wm8940: remove unecessary if statement
Date: Mon, 06 Jun 2011 07:45:47 -0500
Message-ID: <4DECCBFB.2020307@cuw.edu>
References: <1307321274-21858-1-git-send-email-Gregory.Dietsche@cuw.edu> <4DEC9E6B.8030505@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DEC9E6B.8030505@cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: perex@perex.cz, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, dp@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Jonathan,

On 06/06/2011 04:31 AM, Jonathan Cameron wrote:
> On 06/06/11 01:47, Greg Dietsche wrote:
>    
>> the code always returns ret regardless, so if(ret) check is unecessary.
>>      
> Good point, though please spell check your commit messages.
> unecessary ->  unnecessary
>    
oops! usually I'm the guy critiquing spelling :)
> Also if you want to do this sort of cleanup, please also fix the
> equivalent in wm8940_resume and wm8940_add_widgets.  Ack is for
> what is here, plus those if you do them.
>    
I will take a look at these, but it might be a few days. I used 
coccinelle to create this patch and my semantic patch wasn't 'smart' 
enough to find them.
> Just as an aside, there is no earthly point in cc'ing lkml for a
> simple cleanup like this. Just adds to already huge amount of noise!
>    
Thanks for all of your feedback. In your opinion, what is the best way 
for someone such as myself to send patches like these? I read in 
Documentation/SubmittingPatches "Unless you have a reason NOT to do so, 
CC linux-kernel@vger.kernel.org"

Also, for this embarrassing spelling problem... do I submit a new patch? :)

Thanks,
Greg

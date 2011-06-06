From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] wm8940: remove unecessary if statement
Date: Mon, 06 Jun 2011 14:05:53 +0100
Message-ID: <4DECD0B1.4010802@cam.ac.uk>
References: <1307321274-21858-1-git-send-email-Gregory.Dietsche@cuw.edu> <4DEC9E6B.8030505@cam.ac.uk> <4DECCBFB.2020307@cuw.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DECCBFB.2020307@cuw.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Dietsche <gregory.dietsche@cuw.edu>
Cc: perex@perex.cz, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, dp@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/06/11 13:45, Greg Dietsche wrote:
> Hi Jonathan,
> 
> On 06/06/2011 04:31 AM, Jonathan Cameron wrote:
>> On 06/06/11 01:47, Greg Dietsche wrote:
>>   
>>> the code always returns ret regardless, so if(ret) check is unecessary.
>>>      
>> Good point, though please spell check your commit messages.
>> unecessary ->  unnecessary
>>    
> oops! usually I'm the guy critiquing spelling :)
The advantage of reviewing patches in an email client that sticks wiggly
red lines under words it doesn't recognise (I'd never have noticed otherwise!)
>> Also if you want to do this sort of cleanup, please also fix the
>> equivalent in wm8940_resume and wm8940_add_widgets.  Ack is for
>> what is here, plus those if you do them.
>>    
> I will take a look at these, but it might be a few days. I used coccinelle to create this patch and my semantic patch wasn't 'smart' enough to find them.
>> Just as an aside, there is no earthly point in cc'ing lkml for a
>> simple cleanup like this. Just adds to already huge amount of noise!
>>    
> Thanks for all of your feedback. In your opinion, what is the best
> way for someone such as myself to send patches like these? I read in
> Documentation/SubmittingPatches "Unless you have a reason NOT to do
> so, CC linux-kernel@vger.kernel.org"

Fair enough.  The posting to lkml makes more sense now I know it came
out of coccinelle (I guess with a load of others? - if so convention would be
to put them all in a series cc'ing the relevant lists / maintainers for individual
patches in the series - that way everyone knows what is going on).

If it is an individual patch like this, then use apply common sense. It makes
no functional changes + is well within a subsystem with it's own active mailing
list.  It needs to be sent somewhere publicly, but in this case
I'd say alsa-devel is the right destination.  The only people who are even going
to read this are the subsystem maintainer, the driver author or the chronically
bored.

Also I think convention is to have the script somewhere (cover letter to that 
series perhaps?).  See the other series people have done with coccinelle and
how they handled this.
> 
> Also, for this embarrassing spelling problem... do I submit a new patch? :)
Probably easiest option, though maintainer might just fix it up for you
(best not to assume they will though).

Git history is full of typos, so I wouldn't worry too much (a good few
of them are mine for starters).
> Thanks,
> Greg
> 
> 

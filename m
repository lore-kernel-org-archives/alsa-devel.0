From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [TINYCOMPRESS][PATCH 1/1] compress: no need to	set
	metadata before calling next_track
Date: Thu, 6 Mar 2014 10:32:13 +0000
Message-ID: <20140306103213.GA8027@opensource.wolfsonmicro.com>
References: <20140226142829.GB2002@opensource.wolfsonmicro.com>
 <530F62CA.6080002@linux.intel.com>
 <20140303132547.GA20710@opensource.wolfsonmicro.com>
 <53149846.3040104@linux.intel.com>
 <20140303163653.GA8461@opensource.wolfsonmicro.com>
 <5314DA9E.40704@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D2A2626531D
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 11:32:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5314DA9E.40704@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: vinod.koul@intel.com, ckeepax@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, elaurent@google.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 03, 2014 at 01:40:14PM -0600, Pierre-Louis Bossart wrote:
>
>> Let me put it this way. These checks are unnecessary and are currently breaking what I'm working on, where I want to
>> chain the tracks together and use partial drain, but I haven't got any metadata to send. Working around these checks by
>> sending dummy metadata makes no sense. If I have to send a dummy ioctl() that does nothing to make the API work, then
>> the API is broken. A dummy metadata does nothing, so obviously it's not needed so there was no need to mandate it.
>
> I don't disagree that the API is being stretched beyond what we  
> envisioned when it was quickly extended for MP3/AAC. If we are going  
> further than what was planned and tested with those two formats let's  
> fix it since the assumptions we made may not carry over.
>

By "we" you mean Intel? I did consider cases other than what we were working on at the time, which is why I asked for 
next_track and partial_drain to be seperate functions though they weren't in Android - next_track is a legitimate operation 
but partial_drain was clearly a workaround for limitations elsewhere.
Unfortunately I missed the review of the gapless stuff (probably I was on vacation).


>> And having to switch between two different ways of playing audio makes no sense either - why can't I just implement
>> one way of playing audio and if there isn't any metadata for a particular track I don't need to send any?
>
> Because there are cases where you need to go through the regular  
> playback path to reinitialize things properly, see below.
>

"some cases" != "all cases".
The generic layer should not impose an error check on all cases if it's only releveant to some cases.

>> Also, I disagree that putting these checks in eases integration. It only eases integration if the checks are
>> sensible and useful, if they are not then it makes integration more difficult (as in this case where it makes the
>> integrator have to go to extra effort to send pointless dummy ioctls.) Checks should only go in at a framework level if they
>> are preventing a case that would break things or is logically impossible. It's not impossible to play chained tracks to
>> a DSP without any metadata.
>
> Chaining is only possible for elementary streams, not in the general  
> case if you may need to reinitialize the decoder based on header  
> information. Chaining may or may not be possible as well if the format  
> is only detected at run-time (e.g. AAC+ with SBR implicit signaling).
>

"some cases" != "all cases". See above.


> There is currently no way to know if the lowest levels support chained  
> playback for a specific format and if they support or require metadata.  
> The next_track/metadata scheme worked fine for MP3/AAC, if we extend the  
> use of this API i suggest we fix some misses rather than taking 
> shortcuts.
>

I agree, but I don't see anyone proposing shortcuts.

>>> we should provide information at the codec level on whether gapless is supported
>>
>> This is a bogus comment. Again, you are thinking only about gapless. This is an api for playing audio; gapless is one
>> thing that you might want to do but not the only thing. I agree with you that we should provide this info about the codec,
>> but this patch isn't about what the codec supports. Even if the codec supported gapless, that doesn't mean the
>> framework should force us to send metadata even when the firmware doesn't need it.
>
> It is totally about what the decoder implementation supports and no I am  
> not thinking about gapless only. There is currently nothing that tells  
> you next_track is supported and if metadata is supported/needed. 

> You are  
> making assumptions for your specific implementation that may or may not  
> be true in other cases. 

This is a ridiculous comment.
I'm proposing that an error check which assumes that the specific case it was relevant for applies to all implementations 
should be removed - how can that be described as "making assumptions for your specific implementation"? The whole point is 
that the code _currently_ makes an assumption based on the specific implementation it was written for, but it shouldn't.

> My suggestion is to add flags, e.g.
>
> #define COMPRESS_SUPPORTS_NEXT_TRACK      	 (1<<0)
> #define COMPRESS_SUPPORTS_METADATA               (1<<1)
> #define COMPRESS_REQUIRES_METADATA_ON_NEXT_TRACK (1<<2)
>
That way we have a consistent  
> behavior and you don't have to send information that isn't needed.
> -Pierre

These sort of additions should be considered carefully this time and not written around what's relevant to 
the two or three cases that we happen to be working on right now.

> and do the relevant tests in tinycompress. 

The kernel must do the relevant tests.
I wonder why we need to check everything twice - once in tinycompress and then again in the kernel. Why does tinycompress 
need to make an assumption about what the kernel errors checks are and pre-check them? If tinycompress has internal state 
that needs to be kept correct then fine, it needs to check to protect itself, but if it's just passing the request on to the 
kernel, the kernel will reject it if it's invalid.

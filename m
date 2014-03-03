From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [TINYCOMPRESS][PATCH 1/1] compress: no need to
	set	metadata before calling next_track
Date: Mon, 3 Mar 2014 16:36:53 +0000
Message-ID: <20140303163653.GA8461@opensource.wolfsonmicro.com>
References: <20140226142829.GB2002@opensource.wolfsonmicro.com>
 <530F62CA.6080002@linux.intel.com>
 <20140303132547.GA20710@opensource.wolfsonmicro.com>
 <53149846.3040104@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 77CC626564E
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 17:42:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <53149846.3040104@linux.intel.com>
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

On Mon, Mar 03, 2014 at 08:57:10AM -0600, Pierre-Louis Bossart wrote:
>
>> Any format, or any use-case, where we don't need to send metadata. I said "other formats do not
>> _necessarily_ require any additional metadata". I'm not saying that _no_ other format needs metadata,
>> just that it's not something that's always going to be mandatory. Also you shouldn't think only in
>> terms of gapless play, you can chain track together for other reasons than gapless (for example to
>> make best use of the DSP buffering and allow maximum host sleep time across multiple tracs) and still
>> want to be able to do partial drains to know when the DSP starts decoding the next track.
>
> My point was that it's way simpler to use regular playback if you don't  
> need the gapless functionality. I don't buy the argument on power  
> savings either, if the transition lasts 500ms with 3mn tracks, we are  
> talking about optimizing a state that represents 0.27% of the AP 
> activity.
>
>> Also there's no reason why the kernel should be enforcing this restriction - the core ALSA state
>> machine doesn't need the metadata so it should be left to the DSP driver and/or firmware to decide
>> whether metadata is mandatory in the current situation.
>
> The problem is that you removed checks at the kernel and tinycompress  
> levels, essentially moving error management to the HAL and firmware. I  
> would agree to the change at the kernel level but it makes sense to have  
> a common approach in tinycompress to make the integration work lighter.
>

You're focussing too much on thinking about gapless. The compressed API isn't just about gapless. And it isn't just 
about Android either.

Let me put it this way. These checks are unnecessary and are currently breaking what I'm working on, where I want to 
chain the tracks together and use partial drain, but I haven't got any metadata to send. Working around these checks by 
sending dummy metadata makes no sense. If I have to send a dummy ioctl() that does nothing to make the API work, then 
the API is broken. A dummy metadata does nothing, so obviously it's not needed so there was no need to mandate it.

And having to switch between two different ways of playing audio makes no sense either - why can't I just implement 
one way of playing audio and if there isn't any metadata for a particular track I don't need to send any?

Also, I disagree that putting these checks in eases integration. It only eases integration if the checks are 
sensible and useful, if they are not then it makes integration more difficult (as in this case where it makes the 
integrator have to go to extra effort to send pointless dummy ioctls.) Checks should only go in at a framework level if they 
are preventing a case that would break things or is logically impossible. It's not impossible to play chained tracks to 
a DSP without any metadata.

> we should provide information at the codec level on whether gapless is supported

This is a bogus comment. Again, you are thinking only about gapless. This is an api for playing audio; gapless is one 
thing that you might want to do but not the only thing. I agree with you that we should provide this info about the codec, 
but this patch isn't about what the codec supports. Even if the codec supported gapless, that doesn't mean the 
framework should force us to send metadata even when the firmware doesn't need it.

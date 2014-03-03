From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [TINYCOMPRESS][PATCH 1/1] compress: no need to	set
	metadata before calling next_track
Date: Mon, 3 Mar 2014 13:25:47 +0000
Message-ID: <20140303132547.GA20710@opensource.wolfsonmicro.com>
References: <20140226142829.GB2002@opensource.wolfsonmicro.com>
 <530F62CA.6080002@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DCA07265621
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 14:25:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <530F62CA.6080002@linux.intel.com>
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

On Thu, Feb 27, 2014 at 10:07:38AM -0600, Pierre-Louis Bossart wrote:
> On 2/26/14 8:29 AM, Richard Fitzgerald wrote:
>> The metadata is mainly for MP3 gapless playback, since
>> the MP3 audio stream does not contain enough information
>> to enable gapless. Other audio formats do not necessarily
>> require any additional metadata so we should allow next_track
>> to be called without any metadata.
>
> Metadata is required for both MP3 and AAC gapless playback. Can you  
> clarify what 'other formats' you are referring to? And rather than  
> removing the check that makes sense for these popular formats, why not  
> send metadata to set the # of samples to skip to zero?
> Thanks,
> -Pierre
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Any format, or any use-case, where we don't need to send metadata. I said "other formats do not 
_necessarily_ require any additional metadata". I'm not saying that _no_ other format needs metadata, 
just that it's not something that's always going to be mandatory. Also you shouldn't think only in 
terms of gapless play, you can chain track together for other reasons than gapless (for example to 
make best use of the DSP buffering and allow maximum host sleep time across multiple tracs) and still 
want to be able to do partial drains to know when the DSP starts decoding the next track.

It would be possible to send a dummy metadata, but why send dummy ioctls to make the API work 
when we could just remove the check that isn't needed?

Also there's no reason why the kernel should be enforcing this restriction - the core ALSA state 
machine doesn't need the metadata so it should be left to the DSP driver and/or firmware to decide 
whether metadata is mandatory in the current situation.

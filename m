From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [TINYCOMPRESS][PATCH 1/1] compress: no need to	set
	metadata before calling next_track
Date: Fri, 7 Mar 2014 14:32:59 +0000
Message-ID: <20140307143259.GA7431@opensource.wolfsonmicro.com>
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
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2ACB02659FD
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 15:33:04 +0100 (CET)
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

If you think about the current behaviour, it enforces that you must send some metadata, but it doesn't check what 
that metadata is. You can send totally the wrong metadata and it will be happy but that's no use to the codec. So, 
either the lower layers have to check that they get the metadata they need - which makes the framework check 
redundant. Or the codec needs to be robust against not receiving the metadata it needs - which makes the framework 
check unnecessary.

Also the current behviour is inconsistent, like you say the framework doesn't currently know what the codec actually 
supports. But in some cases (pause, metadata, next_track, partial_drain) it assumes it supports it and allowed. In
other cases (next_track without metadata, partial_drain without next_track) it assumes it doesn't support and denies.

The test isn't even consistent with the case it was designed for - it just denies next_track without metadata but 
there's no reason why the codec should crash and burn if it gets another MP3 track without some gapless metadata.

>
> It is totally about what the decoder implementation supports and no I am  
> not thinking about gapless only. There is currently nothing that tells  
> you next_track is supported and if metadata is supported/needed. You are  
> making assumptions for your specific implementation that may or may not  
> be true in other cases. My suggestion is to add flags, e.g.
>
> #define COMPRESS_SUPPORTS_NEXT_TRACK      	 (1<<0)
> #define COMPRESS_SUPPORTS_METADATA               (1<<1)
> #define COMPRESS_REQUIRES_METADATA_ON_NEXT_TRACK (1<<2)
>
> and do the relevant tests in tinycompress. That way we have a consistent  
> behavior and you don't have to send information that isn't needed.

However, it's not that simple for a number of reasons.

1. there's the problem mentioned above, there's not much point verifying that you're sending just any metadata, it's 
got to be the right metadata. But you can't reasonably check every possible metadata for every possible codec for 
every possible use case in the generic framework, or encode them all in flags. And so if the codec does need to 
check for the correct metadata it's going to have to check its specific case itself.

2. The required behaviour is not necessarily a fixed feature of the codec that can be defined by a static 'feature 
flag'. Whether you need a particular sequence or behaviour might depend on what the user application (or human user) 
was expecting rather than any requirements of the codec. Take MP3 - metadata before next track is only mandataory if 
you wanted gapless play, if you don't need gapless you can do without. Of course it's not all about 
the metadata-before-next_track case, I'm just using that as an example.

3. There's many possible combinations that might apply to different codecs. Using the metadata example again,
does the codec need metadata before any audio data, or just before next_track? Do I need to send any metadata before 
pause? Is metadata needed for every track? Are there one-off metadatas that are sent before any tracks? How many 
metadatas are needed? Does any of this depend on what's in the data stream (like metadata needed for certain 
sub-types and not others)?

Even operations we've assumed are always there could be optional. If you're not implementing a music player 
you might not need pause, or drain, or partial_drain.

So there are a lot of possible combinations of things that need checking and I think we need to be selective about 
which can sensibly be checked in the generic framework and which of them either need to be checked by the codec, or 
are too variable to have a simple if (!x) {return -EINVAL;} check.

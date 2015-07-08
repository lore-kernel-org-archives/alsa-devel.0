From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 0/4] better support for bursty DMA
	usages
Date: Wed, 08 Jul 2015 19:50:45 +0200
Message-ID: <559D62F5.8080201@linux.intel.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hk2uahgap.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id EB0C5265862
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 19:50:48 +0200 (CEST)
In-Reply-To: <s5hk2uahgap.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/8/15 4:31 PM, Takashi Iwai wrote:
> On Wed, 08 Jul 2015 12:10:32 +0200,
> Pierre-Louis Bossart wrote:
>>
>> Set of patches to fix issues with hw_ptr fuzziness [1] and increased buffering
>>   w/ DSPs
>>
>> 1. disable rewinds to allow for new HDaudio SPIB DMA functionality (fetch up to
>> the application pointer, rewinds not supported)
>> 2. report max in-flight bytes to avoid problems with stale data (late wake-ups,
>> rewinds)
>>
>> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093646.html
>>
>> TODO:
>> 1. fixes and alsa-lib updates (compile-tested only for now)
>> 2. get feedback
>> 3. if supported, set DMA buffering based on negotiation between driver and app (capabilities vs.
>> latency needs)
>
> Thanks for heading up.  I wanted to start working on this by myself,
> too, but it was pending due to the horribly hot summer days here :)

Thanks for the quick review Takashi, much appreciated. The work was done 
before the heat wave on my side...

> The new flag and the callback are fairly similar as what I had in my
> mind.  They look simple enough (although details need more discussion
> and evaulation).
>
> For the DMA burst thing, I'm not quite sure whether it's the best
> form, including its naming.  But I'd like to be neutral about this,
> and hopefully others will give opinion for this or give alternatives.

Yes, this is really a first draft to try and solve the problems 
mentioned multiple times by Arun and Alexander and help use the latest 
and greatest hardware. If others have comments we are all ears.

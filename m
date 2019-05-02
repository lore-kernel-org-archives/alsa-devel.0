From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/14] soundwire: more code cleanups
Date: Thu, 2 May 2019 10:42:30 -0500
Message-ID: <7929c54b-2b00-cbc3-4aa7-6966b0bf2259@linux.intel.com>
References: <20190502105930.9889-1-vkoul@kernel.org>
 <20190502151933.GA32285@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9698AF89693
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 17:42:33 +0200 (CEST)
In-Reply-To: <20190502151933.GA32285@kroah.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Greg KH <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org



On 5/2/19 10:19 AM, Greg KH wrote:
> On Thu, May 02, 2019 at 04:29:16PM +0530, Vinod Koul wrote:
>> After applying cleanup from Pierre, I realized few more things can be
>> cleaned up as well, so fixing these instance in the subsystem.
>>
>> Looks like bool is no longer encouraged, but I have skipped those and few
>> alignment as they caused code to look worse.
>>
>> Greg,
>> if you are okay I would like to add this as well (i know it is late, but
>> they are cosmetic changes and no logic ones, let me know and I can
>> send a updated PR)
> 
> This made no sense, as it was on top of Pierre's patches.
> 
> I've applied both his, and your, patch series to the tree now, hopefully
> this type of mess doesn't happen again in the future.
> 
> Please be a lot more specific as to what you expect me to do with a
> patch series, and what exactly it is for/against/after, as this was not
> obvious at all.
> 
> ugh, someone owes me a drink...
> 
> greg k-h

I'll be glad to buy a round at the next ELC.

I also boiled initially when I saw the Kconfig patch until I realized it 
was a different patch. Same for the SPDX files. It wasn't obvious from a 
quick review and I could have been the one sending a nasty email.

There are additional cleanups from Vinod that I saw but didn't fix as I 
wasn't sure they made the code readable (e.g. dev_dbg logs exceeding 80 
chars and newlines after loops), but I also missed others that are very 
much needed, so please add my Rvb tag for this 'more code cleanups' series.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thank you Vinod for the additional work. I am almost done with the 
sysfs/debugfs cleanups and should post that next week.

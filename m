From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/20] ASoC: rsnd: add Synchronous SRC and
 U/O error salvage support
Date: Thu, 08 Jan 2015 11:44:44 -0600
Message-ID: <54AEC20C.90706@linux.intel.com>
References: <877fyh9ilx.wl%kuninori.morimoto.gx@renesas.com>	<87h9wl7qlb.wl%kuninori.morimoto.gx@renesas.com>	<20141230171032.GQ17800@sirena.org.uk>	<874ms6rraj.wl%kuninori.morimoto.gx@renesas.com>	<20150106183319.GS2634@sirena.org.uk>
 <87a91vp6s8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2398E260474
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 18:44:52 +0100 (CET)
In-Reply-To: <87a91vp6s8.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Tim Cussins <timcussins@eml.cc>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 1/6/15 10:12 PM, Kuninori Morimoto wrote:
>
> Hi Mark
>
> Thank you for your feedback
>
>>> 2nd "dynamic" rate convert which is this patch is used as revision.
>>> I don't know detail of use case, but, according to HW team,
>>> sound clock has small accidental error.
>>> Because of this, if we used 48kHz sound in long term,
>>> but, the real sound can be 48001 Hz or 47999 Hz or something like that.
>>> So, if we use it without revision in long term, the sound will has
>>> small noise. This will be problem for TV or radio (?).
>>> Thus, sound player wants to revise it by "dynamic" rate convert.
>>> I guess DPCM is good match for "static" rate convert, but not good
>>> for "dynamic".
>>
>> In general it should be fine for anything - the driver for the SoC
>> shouldn't need to understand why the rates are being converted, it
>> should let the system integration worry about picking the rates.  That
>> way we can more easily make the frameworks smarter and get benefits over
>> all machines.
>>
>> Though having said that I'm a little confused as to what exactly this
>> control is intended for - am I right in thinking that what's actually
>> going on here is that something in userspace is measuring the actual
>> measured rate and feeding that information back to the DSP for
>> correction?  If that's the case that does seem reasonable but also like
>> we ought to have a general control interface for it.
>
> Yes, you are correct.
> Actually, I don't know detail of this userspace.
> (How does it measure actual rate)
> But, message actual rate -> feedback to SoC is the purpose.
> (if actual rate was slow -> clock up, actual rate was fast -> clock down)

This matches my definition of an asynchronous SRC. I really don't get 
what 'synchronous' means here, and it'd seem odd anyway to have 1Hz 
granularity for the updates?

> Is this "general control interface" means
> "implemented under framework, not drvier" ?
>
>> Adding Tim and Pierre since they might have views if my guess is
>> correct, I could be wrong though.

I'd be good to have a snd_pcm_set_rate() generic framework, but I wonder 
if it's practical. Hardware with ASRC or tunable PLLs isn't very common 
except in pro audio, stb, networking and automotive, and usually has 
specific M/N dividers or rates, I am not sure it can be done 
generically. Also most servo loops are implemented in firmware or in 
environments that don't use Linux, not sure how many people would 
benefit from such additions. At the same time people usually don't use 
ALSA in such environments because it doesn't do what they want, so it 
might be worth relooking at adjustable clocks, presentation timestamps, 
PCR, etc.

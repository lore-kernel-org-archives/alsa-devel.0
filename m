From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH RFC 5/9] ALSA: core: selection
 of	audio_tstamp type and accuracy reports
Date: Fri, 12 Dec 2014 09:20:56 -0600
Message-ID: <548B07D8.5030504@linux.intel.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1418077426-8309-6-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hsignmphw.wl-tiwai@suse.de> <5488827E.4030403@linux.intel.com>
 <s5hegs7mmki.wl-tiwai@suse.de> <s5hppbr6ze7.wl-tiwai@suse.de>
 <5488BF96.708@linux.intel.com> <s5hlhmf6szm.wl-tiwai@suse.de>
 <5488D188.5030402@linux.intel.com> <s5hiohi7muu.wl-tiwai@suse.de>
 <548A54C0.2050604@linux.intel.com> <s5h61dh6z77.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C7C19260669
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 16:20:59 +0100 (CET)
In-Reply-To: <s5h61dh6z77.wl-tiwai@suse.de>
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
Cc: Nick Stoughton <nstoughton@aether.com>, alsa-devel@alsa-project.org, Tim Cussins <timcussins@eml.cc>
List-Id: alsa-devel@alsa-project.org

On 12/12/14, 2:37 AM, Takashi Iwai wrote:
> At Thu, 11 Dec 2014 20:36:48 -0600,
> Pierre-Louis Bossart wrote:
>>
>>
>>>> if someone used alsa-lib with the .get_wall_clock(), the new user-space
>>>> code will provide the same results as today, no change (wall clock if
>>>> supported, hw_ptr otherwise). So the library compatibility is preserved.
>>>
>>> You can't assume that all users always upgrade alsa-lib.
>>> Users may use still the old alsa-lib with the new kernel.
>>>
>>>> I don't mind adding a compatible kernel behavior for HDAudio only, but
>>>> is this really necessary?
>>>
>>> Yes, the kernel is not allowed to give any regression, if we know it
>>> would.
>>
>> ok, will add a backwards-compatible mode. no problem.
>>
>>>> I added a set of INFO defines and the matching is_supported queries in
>>>> alsa-lib. I just did a pretty dumb copy/paste/edit there, maybe we can
>>>> refactor the code here with a single routine taking a type parameter.
>>>> feedback welcome there.
>>>
>>> Right.  But another concern is that this method will consume one INFO
>>> bit at each time the new tstamp type is extended.  This is another
>>> concern.  Exposing this information in another place would be better,
>>> IMO, if any better place is found...
>>
>> I asked about this one in late October... I mentioned that we are
>> running out of INFO (half already used) and AZX_CAPS (28 bits used)
>> fields, and for INFO it didn't seem like a big deal.
>
> The INFO bits are the public ABI and can't be changed later while
> AZX_DCAPS is the internal stuff we can change at any time.  So,
> defining a new stuff for SND_PCM_INFO must be done very carefully.
>
>
>> If adding more fields to the info field is viewed as problematic, the
>> only options I can think of are:
>> - reclaim a reserved word in hw_params, e.g. rename to info1 to do
>> something like this in alsa-lib:
>> 	return !!(params->info1 & SNDRV_PCM_INFO1_IS_THIS_HARDWARE_BROKEN)
>
> It's OK to just add a new hw_param_mask element.  Then we can handle
> up to 32 tstamp types and that should be enough.
>
> The question is whether hw_params is the best place.  Usually
> hw_params is the place to select the one configuration from multiple
> choices or space.  In this case, we don't choose only one, right?

I think we are not aligned here. I am only using the INFO fields as a 
means to report what the hardware can do, not for any selection. Then 
the actual selection of the timestamps is done as a dynamic 
configuration parameter for the STATUS ioctl. The hw_params is not a 
good candidate since it's frozen after the start, we do need to be able 
to query different timestamps dynamically.

>> - keep a 32 bit word but add a paging register in the msb to reuse lsbs.
>> Either way some more code will be required in both driver and library.
>
> Which word to reuse?  Could you elaborate?

Never mind, what I had in mind would require tons of changes in 
user-space code and would break the backwards compatibility if one used 
a new kernel and an older library.

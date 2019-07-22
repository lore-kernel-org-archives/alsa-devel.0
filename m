From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 0/5] ASoC: Intel: IPC framework updates
Date: Mon, 22 Jul 2019 22:21:35 +0200
Message-ID: <660350e5-86df-674e-d307-dd1e2bc0ee42@intel.com>
References: <20190720194532.23682-1-cezary.rojewski@intel.com>
 <58061248-786f-37f6-fc9f-cf18db242a75@linux.intel.com>
 <adf2fdc1-5155-062a-3ad2-c0acd7812707@intel.com>
 <26d588a8-510d-b818-54f1-865c3ab69fe5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8C01F8015B
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2019 22:21:48 +0200 (CEST)
In-Reply-To: <26d588a8-510d-b818-54f1-865c3ab69fe5@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 2019-07-22 21:05, Pierre-Louis Bossart wrote:
> 
> 
> On 7/22/19 1:32 PM, Cezary Rojewski wrote:
>> On 2019-07-22 18:02, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 7/20/19 2:45 PM, Cezary Rojewski wrote:
>>>> Existing IPC framework omits crucial part of the entire communication:
>>>> reply header. Some IPCs cannot function at all without the access to
>>>> said header. Update the sst-ipc with new sst_ipc_message structure to
>>>> represent both request and reply allowing reply-processing handlers to
>>>> save received responses.
>>>
>>> I don't get the idea at all.
>>
>> It's not "an idea", this is cAVS design. GET_PIPELINE_STATE, 
>> LARGE_CONFIG_GET and such define portion of their essential _payload_ 
>> within header instead of actual SRAM window. Some of these contain 
>> entire _payload_ within header instead - as already stated.
> 
> No one outside of your team has a clue what cAVS design means, so we'll 
> have to agree on what this really means, see below. seems to me like 
> 'header' refers to a hardware capability, not the data format.
> 
>>
>>> the DSP provides rx_data and a size. If there is a header at the 
>>> start of the IPC data in some cases, why can't you cast and extract 
>>> the header when it's needed for your SKL usages? Why does adding a 
>>> header make the IPC work better?
>>
>> This is cAVS solution we speak of, not an aDSP one. Not all IPCs have 
>> constant size defined here.
>> Moreover, define "size" - from architectural point of view this is 
>> *only* size an application is prepared to handle, it's usually 
>> overestimated. The actual size of _get_ is known only after reply is 
>> received. If it exceeds frame's window, then it gets more complicated..
>>
>> "If there is a header at the start of the IPC data in some cases, why 
>> can't you cast and extract the header (...)"
>> ??
>> An IPC Header - primary and extension - is found within Host HW 
>> registers e.g.: HICPI & HIPCIE what differs from data - payload - 
>> which is located in SRAM windows: downlink and uplink - depending on 
>> the direction. Saving header does not "make the IPC work better" - it 
>> allows them to function in the first place. Again, this is not the 
>> case for all IPCs.
> 
> The limited understanding I have of the architecture is that the IPC can 
> be done either by transmitting compressed information in an IPC 
> register, using up to 60 bits of information, or a full-blown version in 
> SRAM windows - with the caveat that the SRAM windows may not be 
> available in all power states. All four combinations between TX and RX 
> are possible, e.g. you can transmit a command over the IPC register and 
> get a reply in the SRAM window.
> I am not aware of a case where the IPC register and SRAM window contain 
> unrelated information, it's either self-contained in the IPC register or 
> the IPC register has a qualifier to help interpret the SRAM window 
> contents. Please correct me here if these explanations are incorrect.
> 
> This solution works for SKL+ only, so I am really wondering why you'd 
> want to align legacy platforms with newer stuff. Not to mention that 
> there are two versions of the IPC registers for cAVS.

Two versions of IPC registers is just a mapping thingy, IPC framework 
does not care about that, leaves that to the caller.
Legacy platforms won't notice the difference at all. Status quo is achieved.

If current _get_large_config is not enough for you, see 
GET_PIPELINE_STATE - first 5 bits of reply.header.extension contain 
actual data. Now, how do I get that info using current framework 
capabilities?

About the architecture. SOF's design is different, cAVS (/skylake) 
always makes use of host registers (IPC header is ALWAYS found there and 
is never located within SRAM window) with SRAM being optional and 
context dependent - data that cannot be contained with the very 60 
available bits is found there.

>>
>> Publishing such IPCs (e.g.: _get_large_config found in skl-sst-ipc.c) 
>> makes no sense if you do not process them correctly. I know not why 
>> dysfunctional code has been upstreamed or why does it not follow cAVS 
>> design pattern. All the series being posted currently aim to correct 
>> the very fundations of Skylake which are/ were broken, clearly.
> 
> Since Skylake+ has a fundamentally different way of doing things, and 
> likely more changes required down the road, why not create your own IPC 
> layer when you can knock yourself out, rather than changing stuff that 
> doesn't need any of this?

Does it really differ that much when it comes to handling IPCs?
Me re-implementing - or let's call it what it would really be: copying - 
IPC framework into /skylake is a lazy option. I prefer doing _simple_ 
changes to an existing /common stuff and thus reducing burden of 
maintenance in months to come.

There are fields and methods /skylake does not require too and yet these 
are there only for the sake of legacy platforms. Long time ago someone 
decided to make them all share one framework. Do you think splitting 
these now is a good idea?

>>>
>>> I have the feeling this is blurring layers between receiving data and 
>>> processing it in platform-specific ways, and I am nervous about 
>>> touching Baytrail and Broadwell legacy, which are way past 
>>> maintenance mode and should be deprecated really.
>>
>> I'm not nervous at all. Baytrail IPC is deprecated in favor of 
>> /atom/sst - God knows why yet another _common_ folder has been created 
>> there..
> 
> deprecated doesn't mean removed, there are still users and we don't 
> break their solution.

Sure thing, wasn't my intention - that's why changes maintain status quo.

>> Haswell with DSP does not really exist.
>> Broadwell is the only one left and my changes only _update_ the 
>> framework - these do not change its behavior.
> 
> When you change something that impacts multiple platforms, the 
> expectation is that it's been tested on other platforms. Precisely when 
> something is deprecated you either don't touch it or make sure the code 
> changes are tested. And with the difficulty getting access to platforms 
> - we have exactly two Broadwell devices with I2S - I am inclined to 
> avoid any changes.

Gathered some legacy platforms, but yeah I was not fortunate yet to test 
these out. Validating on several different platforms starting from SKL 
instead.

Here to makes things right, hope we all are. Skylake+ has been 
dysfunctional for long enough. I'd understand the concern if these were 
functional changes to legacy platforms. They aren't really. Would like 
not to delay the resurrection process any longer.

>> Truth be told, it did not age well at all. 99% of Skylake+ IPC 
>> communication is done in synchronized fashion yet during 
>> initialization there are always 8 messages allocated (times two: tx & 
>> rx). In total we are allocating 8 x 2 x PAGE_SIZE memory. These days 
>> memory might not be a problem, though does not change the fact it 
>> could have been done better. Lot of wasted memory..
> 
> I don't know what this has to do with this patchset, but it's pretty 
> common to allocate multiple messages to queue them up?

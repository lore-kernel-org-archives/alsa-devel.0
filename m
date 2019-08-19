From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [BUG] bdw-rt5650 DSP boot timeout
Date: Mon, 19 Aug 2019 20:08:58 +0200
Message-ID: <d0131c02-3477-8390-e0c6-b37b142169e8@intel.com>
References: <CACJJ=pxPm7dRUE534hDWy2tN3dGYDyrgU8JKqett=wOQx+nWCQ@mail.gmail.com>
 <39533fe5-c060-7a07-c910-74b83eee53c4@linux.intel.com>
 <ac7bcb42e40ac12d9924fd65c3e2c68b9b11b093.camel@linux.intel.com>
 <37ede7ea-e760-eac9-a1d5-0eb8e3bff3cb@linux.intel.com>
 <CACJJ=pyb==xWqKMB-gAzW7-FCFgEU7Rm+b-CL-ANO-eorDKy=A@mail.gmail.com>
 <356b3f4eacb43f23c40c4cd8e3c54ae9514a34c6.camel@linux.intel.com>
 <7e08e45d-7cec-9fdd-36c5-5e82632968f8@linux.intel.com>
 <CACJJ=pzcMCaOvHMVhmYKKL2Z45-XdrBB9FT8VjSzX_obVtKzyw@mail.gmail.com>
 <d80c2f4d-b5f4-5bbe-9529-36b9859ab8be@linux.intel.com>
 <CACJJ=pxokT5z+U=nM9QcUVxCk84998ugM5J89U28k=CVGMjG=w@mail.gmail.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A9606FC567@SHSMSX106.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5CCFBF8011F
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 20:27:15 +0200 (CEST)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A9606FC567@SHSMSX106.ccr.corp.intel.com>
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
To: "Jie, Yang" <yang.jie@intel.com>, Jon Flatley <jflat@chromium.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "benzh@chromium.org" <benzh@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jie Yang <yang.jie@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, "cujomalainey@chromium.org" <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 2019-08-19 04:33, Jie, Yang wrote:
> 
>> -----Original Message-----
>> From: Jon Flatley [mailto:jflat@chromium.org]
>> Sent: Thursday, August 15, 2019 5:25 AM
>> To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Cc: Jon Flatley <jflat@chromium.org>; Jie, Yang <yang.jie@intel.com>;
>> benzh@chromium.org; alsa-devel@alsa-project.org; Ranjani Sridharan
>> <ranjani.sridharan@linux.intel.com>; cujomalainey@chromium.org; Jie Yang
>> <yang.jie@linux.intel.com>
>> Subject: Re: [alsa-devel] [BUG] bdw-rt5650 DSP boot timeout
>>
>> On Wed, Aug 14, 2019 at 1:51 PM Pierre-Louis Bossart <pierre-
>> louis.bossart@linux.intel.com> wrote:
>>>
>>>
>>>> There seems to be an issue when suspending the ALC5650. I think the
>>>> nondeterministic behavior I was seeing just had to do with whether
>>>> or not the DSP had yet suspended.
>>>>
>>>> I reverted commit 0d2135ecadb0 ("ASoC: Intel: Work around to fix HW
>>>> D3 potential crash issue") and things started working, including
>>>> suspend/resume of the DSP. Any ideas for why this may be? I would
>>>> like to resolve this so I can finish upstreaming the bdw-rt5650
>>>> machine driver.
>>>
>>> Copying Keyon in case he remembers the context.
>>>
>>> Reverting a 5yr-old commit with all sorts of clock/power-related fixes
>>> looks brave, and it's not clear why this would work with the rt5677
>>> and not with 5650.
>>
>> No idea, I was just diffing the register writes looking for sources of discrepancy.
>> The Chromium OS 3.14 kernel tree that Buddy uses doesn't have this patch, so
>> I figured what's the worst that could happen?
> 
> Hi Jon, sorry about just noticing this thread.
>  From the dmesg log, the issue happens at runtime suspend/resume but not in boot, am I right(you can disable runtime PM for the device to confirm that)?
> 
> My points here are:
> 1. the commit 0d2135ecadb0 was suggested by FW team to W/A D3 potential crash issue.
> 2. it was verified with rt286(Broadwell.c, e.g. Dell XPS) from our side only(and may have been checked with rt5677 by Chrome team).
> 3. please follow sequence in broadwell.c if issue happen at boot time.
> If happened at runtime PM from DSP side, we should see it with all kinds of machine driver.
> Could you performing more test and debugging to see what it real happen there?
> 4. we have no reason to remove the commit directly, except correcting if some lines are proved wrong. And, as Pierre mentioned, SOF driver is preferred, as there is no new development effort to support SST haswell/Broadwell driver here(no platform, no developer, :-( ).
> 
> Thanks,
> ~Keyon>

Got to disagree with the last one - no platform, no developer.
We are setting up some BDW/ HSW here to join our happy SKL+ family in 
CI. This is because of /common cleanups which will engulf aDSP project 
(hsw/byt) obviously.

These will be tested against the exact same BAT scope as other ADSP 
devices. Code here looks much better, at least compared to /skylake - 
ain't a high threshold though.. Given how outdated all SKL+ fw binaries 
are (on upstream repo) it might even come down simply to fw upgrade.
Most of FW peps who took part in that project are already out. Although, 
found one or two who are willing to help : )

And yes, I'm setting them up with rt286 too. There are some rt56XX but 
I'm unsure if rt5650 is amount them.
Still got some problems with ACPI, but soon two new faces should be 
greeting audio CI bonfire..

Czarek

>>>
>>> Are you using the latest upstream firmware btw? Or the one which
>>> shipped with the initial device (which could be an issue if the protocol
>> changed).
>>
>> The firmware I'm loading is: `FW info: type 01, - version: 00.00, build 77,
>> source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a1`.
>> Hashes the same as the upstream binary.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

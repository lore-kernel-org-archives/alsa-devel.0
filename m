From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/35] ASoC: Intel: Clenaup SST
 initialization
Date: Fri, 23 Aug 2019 15:12:18 -0500
Message-ID: <9dfd3a96-f286-34d6-fe57-9b6b8740e424@linux.intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <a08b2547-3fe5-5c48-9513-c5ade151c01e@linux.intel.com>
 <50932a9f-2f3e-c150-77c7-f021f84ed4d1@intel.com>
 <20190823102652.GM23391@sirena.co.uk>
 <c845fda4-c18d-2ca8-7337-6e6af74d239c@intel.com>
 <70222fac-8c4e-5ceb-3c49-7020196b59df@linux.intel.com>
 <2e2a34b8-2451-01f6-79a1-14f06d1ed059@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82035F805E1
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 22:28:20 +0200 (CEST)
In-Reply-To: <2e2a34b8-2451-01f6-79a1-14f06d1ed059@intel.com>
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
To: Cezary Rojewski <cezary.rojewski@intel.com>, Mark Brown <broonie@kernel.org>
Cc: "Wasko, Michal" <michal.wasko@intel.com>, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com, "Kaczmarski,
 Filip" <filip.kaczmarski@intel.com>
List-Id: alsa-devel@alsa-project.org



On 8/23/19 1:44 PM, Cezary Rojewski wrote:
> On 2019-08-23 18:26, Pierre-Louis Bossart wrote:
>>
>>
>> On 8/23/19 5:43 AM, Cezary Rojewski wrote:
>>> On 2019-08-23 12:26, Mark Brown wrote:
>>>> On Fri, Aug 23, 2019 at 10:29:59AM +0200, Cezary Rojewski wrote:
>>>>> On 2019-08-22 22:55, Pierre-Louis Bossart wrote:
>>>>>> On 8/22/19 2:03 PM, Cezary Rojewski wrote:
>>>>
>>>>>>> Code seen here is part of new Skylake fundament, located at the very
>>>>>>> bottom of internal mainline. Said mainline is tested constantly 
>>>>>>> on at
>>>>>>> least sigle platform from every cAVS bucket (description below). 
>>>>>>> This
>>>>>>> week, BDW has been added to the CI family and was essential in
>>>>>>> validating legacy changes. Baytrail platform is still missing. 
>>>>>>> Changes
>>>>>>> for BYT directly mirror HSW/ BDW but due to current lack of platform
>>>>>>> were untested.
>>>>>>> Boards engaged in testing: rt286, rt298, rt274.
>>>>
>>>>>> this is not enough, sorry. these are RVPs and you need to check with
>>>>>> commercial devices supported in sound/soc/intel/boards/.
>>>>
>>>>> What machine board has to do with FW and host side? If it has, we 
>>>>> better
>>>>> notify the owner so he can fix codec's code at once. All boards 
>>>>> MUST follow
>>>>> recommended protocol whether its HDA or I2S in communicating with 
>>>>> /skylake.
>>>>> This is hardware IP we taking about. I could as well test all 
>>>>> platforms with
>>>>> AudioPrecision and say: shipit.
>>
>> The machine driver defines how many links are used, and in what mode 
>> for the older cases where the topology is not used. You have 
>> configurations with very complicated links, e.g. with amplifiers in 
>> TDM mode plus IV feedback that will stress the firmware in ways that 
>> regular RVPs don't. Same for the case where the SSP clock is turned on 
>> at the request of the machine drivers. That's another case that can't 
>> be tested on RVPs.
>>
>> I am not saying you need to test with every single commercial device, 
>> but that testing on RVPs is not a representative sample of the 
>> configurations and actual workloads.
>>
> 
> Each and every FW coming from main branch gets tested on both RVP and 
> production devices what is done with cooperation with integration teams, 
> PAEs and such. Windows teams alone ensures each binary gets smashed by 
> ten of thousands tests each week - this is true for any release 
> candidate, the standards are very high. Moreover, array of platforms is 
> engaged per target (e.g.: TGL) as single platform alone does not cut it.
> 
> So, I'd not worry about FW being vulnerable to any scenario as long as 
> recommended protocol is followed.

I didn't mean to diss the validation work, but the Chromebook cases and 
amplifiers over TDM with IV feedback are certainly not configurations 
tested by Windows folks who are using HDaudio+DMIC only.

>> With the request_firmware() mechanism, the kernel cannot parse the 
>> file ahead of time, but don't you have a version information reported 
>> by the firmware post-boot that can be used by the kernel so track that 
>> the firmware isn't likely to work?
>>
> 
> Wasn't lying about FW version being unreliable. Let's say vendor 
> receives quick FW drop with new RCR.. such eng drop may carry invalid 
> numbers such as 0.0.0.0..
> In general, I try to avoid relying on FW version whenever possible. It 
> can be dumped for debug reasons, true, but to be relied on? Not really.

Goodness, that's really bad. I didn't realize this.

> 
>>>
>>> - user removes existing sym link from /lib/firmware/intel and creates 
>>> new one, pointing to updated FW binary that should also be present in 
>>> /lib/firmware/intel
>>
>> That's typically handled by distributions updating the linux-firmware 
>> package. Only advanced users and developers can change these symlinks.
>>
>> The other point that comes to my mind is whether we are going to see 
>> dependencies between firmware and topology files? Can you use an 'old' 
>> topology with a 'newer' firmware, or is this a 3-way interoperability 
>> issue?
> 
> Precisely! Three-way-tie!
> It's best FW get updated together with topology as old FW may enforce 
> different constraints on pipeline modules.
> 
> Yay, between rock and hard place. On one side we got old buggy FWs which 
> should (more like should NOT be even here..) be updated to improve 
> user's experience but updating these alone won't cut it as host side 
> needs to be aligned too.
> On the other we want to align upstream /skylake with actual working 
> example, which will quickly fail if it encounters obsolete FW binary.
> And if that wasn't enough, lovely topologies come into picture where 
> some of these were developed behind FDK's back and thus completely 
> bypassing deployment process.
> 
> First thing we will do now is prioritizing topology refactor so all 
> initialization/ load oriented thingies will be visible for upstream 
> review. By doing so, we got all elephants in one room and can discuss 
> how to handle it in best fashion: seamless transition for end-users.
> 
> There aren't many options available: notify user -or- fallback to 
> defaults (hardcodes)? in case encountered binaries do not meet cAVS 
> design criteria.
> 
> Personally, I'm against all hardcodes and would simply recommend all 
> user to redirect their symlinks when they do switch kernel - along with 
> dumping warning/ error message in dmesg. Hardcodes bring problems with 
> forward compatibility and that's why host should offload them away to FW.

Cezary, I know you are not responsible for all this, but at this point 
if we (Intel) can't guarantee any sort of interoperability with both 
firmware and topology we should make it clear that this driver is not 
recommended unless specific versions of the firmware/topology are used, 
and as a consequence the typical client distros and desktop/laptop users 
should use HDaudio legacy or SOF (for DMICs)

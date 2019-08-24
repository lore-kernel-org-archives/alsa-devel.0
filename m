From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH 00/35] ASoC: Intel: Clenaup SST
 initialization
Date: Sat, 24 Aug 2019 15:51:34 +0200
Message-ID: <57196fe6-9291-5518-9fb6-731b9b5c27ed@intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <a08b2547-3fe5-5c48-9513-c5ade151c01e@linux.intel.com>
 <50932a9f-2f3e-c150-77c7-f021f84ed4d1@intel.com>
 <20190823102652.GM23391@sirena.co.uk>
 <c845fda4-c18d-2ca8-7337-6e6af74d239c@intel.com>
 <70222fac-8c4e-5ceb-3c49-7020196b59df@linux.intel.com>
 <2e2a34b8-2451-01f6-79a1-14f06d1ed059@intel.com>
 <9dfd3a96-f286-34d6-fe57-9b6b8740e424@linux.intel.com>
 <20190823213920.GW23391@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 957D7F8014A
 for <alsa-devel@alsa-project.org>; Sat, 24 Aug 2019 15:51:41 +0200 (CEST)
In-Reply-To: <20190823213920.GW23391@sirena.co.uk>
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
To: Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "Wasko, Michal" <michal.wasko@intel.com>, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com, "Kaczmarski,
 Filip" <filip.kaczmarski@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2019-08-23 23:39, Mark Brown wrote:
> On Fri, Aug 23, 2019 at 03:12:18PM -0500, Pierre-Louis Bossart wrote:
>> On 8/23/19 1:44 PM, Cezary Rojewski wrote:
> 
>>> Wasn't lying about FW version being unreliable. Let's say vendor
>>> receives quick FW drop with new RCR.. such eng drop may carry invalid
>>> numbers such as 0.0.0.0..
>>> In general, I try to avoid relying on FW version whenever possible. It
>>> can be dumped for debug reasons, true, but to be relied on? Not really.
> 
>> Goodness, that's really bad. I didn't realize this.
> 
> At a previous employer I modified our build stamping
> infrastructure to also include both a timestamp and a serialized
> build number in the version number since one of my colleagues was
> fond of sending people prereleases of what he was working on to
> other people with identical version numbers on different
> binaries leading to much confusion and checksumming.  You do see
> a lot of things with those serialized version numbers, especially
> SVN based projects.
> 
>>> Personally, I'm against all hardcodes and would simply recommend all
>>> user to redirect their symlinks when they do switch kernel - along with
>>> dumping warning/ error message in dmesg. Hardcodes bring problems with
>>> forward compatibility and that's why host should offload them away to
>>> FW.
> 
>> Cezary, I know you are not responsible for all this, but at this point if we
>> (Intel) can't guarantee any sort of interoperability with both firmware and
>> topology we should make it clear that this driver is not recommended unless
>> specific versions of the firmware/topology are used, and as a consequence
>> the typical client distros and desktop/laptop users should use HDaudio
>> legacy or SOF (for DMICs)
> 
> Not the most elegent solution but I'm wondering if keeping a copy
> of the driver as is around and using new locations for the fixed
> firmware might be the safest way to handle this.  We could have a
> wrapper which tries to load the newer firmware and uses the fixed
> driver code if that's there, otherwise tries the old driver with
> the existing firmware paths.  This is obviously a horror show and
> leaves the old code sitting there but given the mistakes that
> have been made the whole situation looks like a house of cards.
> 

Thanks for the feedback Mark. While I'm not yet on the "SOF will fix 
this" train, I'm keen to agree to leaving this entirely to SOF if it 
comes down to us duplicating /skylake.

However, we are not going to give up that easily. I'll see if some 
"golden config" hardcodes can't be provided in some legacy.c file which 
would be fetched if initial setup fails. E.g.: 2cores, 3ssps, 1PAGE_SIZE 
per trace buffer.. and such. There are quite a few factors to take into 
consideration though. If "asking" user via dmesg to upgrade the firmware 
if his/her setup contains obsolete binary is really not an option, then 
some magic words got to be involved.

Czarek

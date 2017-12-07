From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC 01/10] ASoC: Intel: Boards: Machine driver
 for Intel platforms
Date: Thu, 7 Dec 2017 07:05:51 -0600
Message-ID: <7a1aabda-d883-d644-5476-81f73cbd1509@linux.intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1512119648-2700-2-git-send-email-rakesh.a.ughreja@intel.com>
 <67a5002e-9671-f6cd-f37b-e8c1b6d630ce@linux.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60579AC5C24@BGSMSX104.gar.corp.intel.com>
 <a3a5250b-6b0e-4238-7e01-365624b1a35c@linux.intel.com>
 <85DFEED57DC57344B2483EF7BF8CB60579AC5D64@BGSMSX104.gar.corp.intel.com>
 <bd2f2ff6-ad7f-1f72-2422-7cc539b51f46@linux.intel.com>
 <20171206161755.GD32417@localhost>
 <85DFEED57DC57344B2483EF7BF8CB60579AC9A2A@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A3686267144
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 14:05:53 +0100 (CET)
In-Reply-To: <85DFEED57DC57344B2483EF7BF8CB60579AC9A2A@BGSMSX104.gar.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

On 12/7/17 6:27 AM, Ughreja, Rakesh A wrote:
> 
> 
>> -----Original Message-----
>> From: Koul, Vinod
>> Sent: Wednesday, December 6, 2017 9:48 PM
>> To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Cc: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; alsa-devel@alsa-project.org;
>> broonie@kernel.org; tiwai@suse.de; liam.r.girdwood@linux.intel.com; Patches
>> Audio <patches.audio@intel.com>
>> Subject: Re: [alsa-devel] [RFC 01/10] ASoC: Intel: Boards: Machine driver for Intel
>> platforms
>>
>> On Mon, Dec 04, 2017 at 09:37:37AM -0600, Pierre-Louis Bossart wrote:
>>> On 12/4/17 9:10 AM, Ughreja, Rakesh A wrote:
>>
>>>>>>>>     sound/soc/intel/boards/Kconfig           |  10 ++
>>>>>>>>     sound/soc/intel/boards/Makefile          |   2 +
>>>>>>>>     sound/soc/intel/boards/skl_hda_generic.c | 276
>>>>>>> +++++++++++++++++++++++++++++++
>>>>>>>
>>>>>>> can we drop the Skylake reference? It's become a catch-all term to mean
>>>>>>> both the platform, the IP and the driver.
>>>>>>
>>>>>> Suggest some name. I have no problem.
>>>>>
>>>>> HiFi3 ?
>>>>> iDisp ?
>>>>> HDAudio-DSP ?
>>>>
>>>> hda_dsp_generic.c -- For the main file
>>>> hda_dsp_common.c -- for common functions
>>>>
>>>> Does it look fine ?
>>>
>>> works for me.
>>
>> Sorry not for me. hda_dsp_xxx doesnt tie it to anything. HDA and DSP are too
>> generic terms. But yes I don't have a better alternate than skl_generic.
>> Here this solution is tied to a very specfic IP which is present in SKL
>> onwards platforms..
>>
>> Yes SKL is become an IP as well as platform. Maybe we should have a codename
>> for this like azx :)
> 
> We do have a code name "sst".
> 
> So does this sound okay for you ?
> 
> sst_hda_dsp_generic.c -- For main file
> sst_hda_dsp_common.c -- for common functions

SST is also aliased to platform drivers with closed-source firmware, not 
a good idea for machine drivers.

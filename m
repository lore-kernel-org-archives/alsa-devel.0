From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: hdac_hdmi: Add sampling
 frequencies constraint
Date: Tue, 7 Aug 2018 13:49:19 -0500
Message-ID: <d32d0091-b3d6-f3d3-4477-b6c10f6eae36@linux.intel.com>
References: <1533653765-26080-1-git-send-email-yong.zhi@intel.com>
 <s5hzhxy2oc5.wl-tiwai@suse.de>
 <C193D76D23A22742993887E6D207B54D3420A4AB@ORSMSX106.amr.corp.intel.com>
 <s5htvo62nh8.wl-tiwai@suse.de>
 <C193D76D23A22742993887E6D207B54D3420A502@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 69431267692
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 20:49:22 +0200 (CEST)
In-Reply-To: <C193D76D23A22742993887E6D207B54D3420A502@ORSMSX106.amr.corp.intel.com>
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
To: "Zhi, Yong" <yong.zhi@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "N,
 Harshapriya" <harshapriya.n@intel.com>, "vkoul@kernel.org" <vkoul@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "M, Naveen" <naveen.m@intel.com>, "Kale, Sanyog R" <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 08/07/2018 11:01 AM, Zhi, Yong wrote:
> Hi, Takashi,
>
>> -----Original Message-----
>> From: Takashi Iwai [mailto:tiwai@suse.de]
>> Sent: Tuesday, August 7, 2018 10:41 AM
>> To: Zhi, Yong <yong.zhi@intel.com>
>> Cc: broonie@kernel.org; pierre-louis.bossart@linux.intel.com; alsa-
>> devel@alsa-project.org; N, Harshapriya <harshapriya.n@intel.com>;
>> vkoul@kernel.org; M, Naveen <naveen.m@intel.com>; Kale, Sanyog R
>> <sanyog.r.kale@intel.com>
>> Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: hdac_hdmi: Add sampling
>> frequencies constraint
>>
>> On Tue, 07 Aug 2018 17:36:12 +0200,
>> Zhi, Yong wrote:
>>> Hi, Takashi,
>>>
>>> Thanks for the review.
>>>
>>>> -----Original Message-----
>>>> From: Takashi Iwai [mailto:tiwai@suse.de]
>>>> Sent: Tuesday, August 7, 2018 10:23 AM
>>>> To: Zhi, Yong <yong.zhi@intel.com>
>>>> Cc: broonie@kernel.org; pierre-louis.bossart@linux.intel.com; alsa-
>>>> devel@alsa-project.org; N, Harshapriya <harshapriya.n@intel.com>;
>>>> vkoul@kernel.org; M, Naveen <naveen.m@intel.com>; Kale, Sanyog R
>>>> <sanyog.r.kale@intel.com>
>>>> Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: hdac_hdmi: Add
>>>> sampling frequencies constraint
>>>>
>>>> On Tue, 07 Aug 2018 16:56:05 +0200,
>>>> Yong Zhi wrote:
>>>>> Playback of 44.1Khz contents with HDMI plugged returns "Invalid
>>>>> pipe config".
>>>> Why?  Is it a limitation of i915 graphics side?
>>>> If it's a generic issue, we'd need to fix also in the legacy HDMI driver, too.
>>>>
>>> The HDMI paths in DFW topology are configured for 48Khz operation.
>> OK, so it's specific to this driver, not for the legacy configuration, so far.
>>
>> What if the legacy HDMI codec driver is used on top of Intel SST (as the
>> recent patchset "Enable HDA Codec support on Intel Platforms")?
>> The legacy HDMI codec driver isn't enabled there, but in theory it can be.  I
>> suppose that a similar workaround is required, right?
>>
>>
> Think so if that's the case, but I am far from expert on this topic :)

There are two issues here.
1. the firmware relies on a timer which isn't aligned with any 44.1 
frequency. In general we don't support 44.1kHz in master mode (we've 
relied on 48kHz frequencies since 2013 and no one cared or bothered to 
complain). If you look at all machine drivers using hdmi_hdac they are 
all based on 48kHz already. I suggested to Yong to do this filtering in 
the codec itself rather than in the front-ends since the DSP *could* do 
some resampling. I was also planning to remove all these front-end 
restrictions which prevent folks from using more that 48kHz/stereo/16 
bits over HDMI.

2. it's not clear how the link itself would be configured (need the 
12-11-11- pattern), it's not clear to me it's supported in decoupled 
mode (and I don't know how to test it in the first place due to issue #1)

For the case with the HDA codec path, we are also using that same 
hdac_hdmi codec in the machine driver, along with the new hdac_hda 
pseudo codec, so the same limitations will be enforced.

As to your question on whether this applies to the legacy driver, I 
don't think so. I just tried on my Skylake NUC, all HDMI devices seem to 
support 44.1kHz without errors. The limitation that Yong added is just a 
pragmatic view that 44.1 support is broken when going through the DSP 
and there isn't any real plan to fix this for now since this isn't a 
required feature and doesn't break compliance (HDMI sources may select 
one of 32,44.1,48kHz, HDMI sinks must support all of these frequencies).
>
>> thanks,
>>
>> Takashi

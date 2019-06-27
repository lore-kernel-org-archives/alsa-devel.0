From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH 3/4] ASoC: hdac_hdmi: refine hdmi jacks
Date: Thu, 27 Jun 2019 01:46:53 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19528A3F6E@SHSMSX103.ccr.corp.intel.com>
References: <1558948047-18930-1-git-send-email-libin.yang@intel.com>
 <1558948047-18930-4-git-send-email-libin.yang@intel.com>
 <s5hftowv2ii.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195285809B@SHSMSX103.ccr.corp.intel.com>
 <s5hsgswt1at.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19528582FD@SHSMSX103.ccr.corp.intel.com>
 <96A12704CE18D347B625EE2D4A099D195289BC7B@SHSMSX103.ccr.corp.intel.com>
 <96A12704CE18D347B625EE2D4A099D19528A2E44@SHSMSX103.ccr.corp.intel.com>
 <s5hpnn1x6uz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2818F89678
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 03:46:57 +0200 (CEST)
In-Reply-To: <s5hpnn1x6uz.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: 'Hui Wang' <hui.wang@canonical.com>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, "'broonie@kernel.org'" <broonie@kernel.org>, "'pierre-louis.bossart@linux.intel.com'" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Tuesday, June 25, 2019 7:06 PM
>To: Yang, Libin <libin.yang@intel.com>
>Cc: 'alsa-devel@alsa-project.org' <alsa-devel@alsa-project.org>;
>'broonie@kernel.org' <broonie@kernel.org>; 'pierre-
>louis.bossart@linux.intel.com' <pierre-louis.bossart@linux.intel.com>; 'Hui
>Wang' <hui.wang@canonical.com>
>Subject: Re: [alsa-devel] [RFC PATCH 3/4] ASoC: hdac_hdmi: refine hdmi jacks
>
>On Tue, 25 Jun 2019 08:02:45 +0200,
>Yang, Libin wrote:
>>
>> >
>> >Sorry for a long delay for the hdmi jacks. I was busy on another
>> >critical issue last 2 weeks. I have worked out the UCM configuration
>> >files. Please check the attachment. It is a long file, so I use the attachment
>instead of the patch mode.
>> >Based on my test, it works well. Could you please help review if the
>> >configuration file is OK or not. I will do more test on the meantime,
>> >including DPMST and NON-DPMST.
>>
>> With some more tests on the new hdmi jack with UCM configuration, I
>> found that the kernel patch can always notify the jack hotplug event
>> to userspace correctly. However, the userspace can't set the amixer
>> correctly based on the UCM configurations sometimes.
>>
>> Here is the details:
>> There are 3 PCMs on Intel platforms. Let's call them pcm1, pcm2, pcm3.
>> And there are 3 pins (pin5, pin6, pin7). For DPMST, and each pin has 3 ports:
>> port0, port1, port2.
>>
>> For non-DPMST, we can set pin5 <=> pcm1, pin6 <=> pcm2, pin7 <=> pcm3.
>> This can always work.
>>
>> For DPMST, as there are 9 ports using 3 pcms. So we should assign
>> 1 pcm to 3 ports. For example, pin5-port0, pin6-port1 and pin7-port2
>> are using pcm1;  pin5-port1, pin6-port2 and pin7-port0 are using pcm2;
>> pin5-port2; pin6-port3 and pin7-port1 are using pcm3.
>> In this setting, we should setting the ConflictingDevice in UCM.
>> For example, pin5-port0 is conflicting with pin6-port1 and pin7-port2.
>> Hui and I found if we set one device conflicting with 2 devices, the
>> amixer setting will be wrong and it will not following UCM
>> configuration setting when we are hotplugging the monitors.
>
>How wrong would it behave?  Only one of them is done?
>
>> Hui and I thought this may be the alsa-lib or pulseaudio issue.
>
>You can try alsaucm directly without PA, too.
>But in general the conflicting device management is done in PA, so I'd begin
>with tracking the PA UCM code at first.

Sorry for delay reply. I take annual leave these days. 
The behavior is like Hui's description. Thanks for the suggestion. I will
try alsaucm firstly for the debug.

Regards,
Libin

>
>
>thanks,
>
>Takashi

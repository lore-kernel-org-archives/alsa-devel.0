From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH v2] ASoC: codec: hdac_hdmi add device_link
 to card device
Date: Wed, 17 Apr 2019 01:28:32 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D195281AF90@SHSMSX103.ccr.corp.intel.com>
References: <1555161492-9143-1-git-send-email-libin.yang@intel.com>
 <s5hpnpm5jv1.wl-tiwai@suse.de>
 <f34e1a6f-7d8a-a432-5e9f-387e891f6b4f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00E7DF89614
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2019 03:28:37 +0200 (CEST)
In-Reply-To: <f34e1a6f-7d8a-a432-5e9f-387e891f6b4f@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

>>>
>>> In resume from S3, HDAC HDMI codec driver dapm event callback may be
>>> operated before HDMI codec driver turns on the display audio power
>>> domain because of the contest between display driver and hdmi codec
>driver.
>>>
>>> This patch adds the device_link between soc card device (consumer)
>>> and hdmi codec device (supplier) to make sure the sequence is always
>correct.
>>>
>>> Signed-off-by: Libin Yang <libin.yang@intel.com>
>>
>> Reviewed-by: Takashi Iwai <tiwai@suse.de>
>>
>> Is it an issue that has been present for older released kernels?
>> If so, it deserves for Cc-to-stable.
>
>Yes and no. In theory the same problem impacts the Skylake driver.
>However its support for HDMI has been flaky at best, see e.g. the
>probe/timing issues on Linus' laptop and a variety of devices in December,
>and the only real distribution using it - ChromeOS - does not resume from S3.
>Not to mention that products typically use 3.18 to 4.9.

Agree with Pierre. I have tested on 4.1x before (I didn't remember the
exact version number), it works well. On some later stable versions,
for example 5.0.0, we can easily reproduce this issue.

And for other earlier version, I didn't have ever test on it.

Regards,
Libin

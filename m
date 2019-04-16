From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: codec: hdac_hdmi add device_link
 to card device
Date: Tue, 16 Apr 2019 05:37:53 -0500
Message-ID: <f34e1a6f-7d8a-a432-5e9f-387e891f6b4f@linux.intel.com>
References: <1555161492-9143-1-git-send-email-libin.yang@intel.com>
 <s5hpnpm5jv1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7DC21F89614
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 12:37:55 +0200 (CEST)
In-Reply-To: <s5hpnpm5jv1.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, libin.yang@intel.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org



On 4/16/19 5:23 AM, Takashi Iwai wrote:
> On Sat, 13 Apr 2019 15:18:12 +0200,
> libin.yang@intel.com wrote:
>>
>> From: Libin Yang <libin.yang@intel.com>
>>
>> In resume from S3, HDAC HDMI codec driver dapm event callback may be
>> operated before HDMI codec driver turns on the display audio power
>> domain because of the contest between display driver and hdmi codec driver.
>>
>> This patch adds the device_link between soc card device (consumer) and
>> hdmi codec device (supplier) to make sure the sequence is always correct.
>>
>> Signed-off-by: Libin Yang <libin.yang@intel.com>
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> 
> Is it an issue that has been present for older released kernels?
> If so, it deserves for Cc-to-stable.

Yes and no. In theory the same problem impacts the Skylake driver. 
However its support for HDMI has been flaky at best, see e.g. the 
probe/timing issues on Linus' laptop and a variety of devices in 
December, and the only real distribution using it - ChromeOS - does not 
resume from S3. Not to mention that products typically use 3.18 to 4.9.

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: codec: hdac_hdmi: no checking
 monitor in hw_params
Date: Tue, 7 May 2019 08:39:41 -0500
Message-ID: <9ff760fb-ce59-337a-0c96-05de394361fb@linux.intel.com>
References: <1557210791-20332-1-git-send-email-libin.yang@intel.com>
 <s5hef5airju.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7968BF89671
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2019 15:39:44 +0200 (CEST)
In-Reply-To: <s5hef5airju.wl-tiwai@suse.de>
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
Cc: hui.wang@canonical.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org



On 5/7/19 3:42 AM, Takashi Iwai wrote:
> On Tue, 07 May 2019 08:33:11 +0200,
> libin.yang@intel.com wrote:
>>
>> From: Libin Yang <libin.yang@intel.com>
>>
>> Some userspace apps, like pulseaudio, may call open, hw_params,
>> prepare to judge whether the pcm is ready or not. Current hdac_hdmi
>> will return -ENODEV if monitor is not connected, which will cause
>> the apps believe the pcm is not ready. Actually PCM for hdmi is ready,
>> even the monitor is not connected.
>>
>> This patch removes the check of monitor presence in hw_params, just like
>> what the legacy HD-Audio driver does.
>>
>> Signed-off-by: Libin Yang <libin.yang@intel.com>
> 
> LTGM,
>    Reviewed-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

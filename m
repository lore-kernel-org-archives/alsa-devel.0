From: Rohit Kumar <rohitkr@codeaurora.org>
Subject: Re: [alsa-devel] Applied "ASoC: soc-core: defer card probe until all
 component is added to list" to the asoc tree
Date: Thu, 10 Jan 2019 12:39:13 +0530
Message-ID: <961ef85b-86a5-1db8-260b-6c5cb27399fe@codeaurora.org>
References: <1547023627-30312-1-git-send-email-rohitkr@codeaurora.org>
 <20190109124902.672EB1127528@debutante.sirena.org.uk>
 <874lahb6bi.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <874lahb6bi.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Ajit Pandey <ajitp@codeaurora.org>, rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, asishb@codeaurora.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

Thanks Kuninori for reporting the issue.

On 1/10/2019 8:02 AM, Kuninori Morimoto wrote:
> Hi Mark, Ajit
>
>> From: Ajit Pandey <ajitp@codeaurora.org>
>> Date: Wed, 9 Jan 2019 14:17:07 +0530
>> Subject: [PATCH] ASoC: soc-core: defer card probe until all component is added
>>   to list
>>
>> DAI component probe is not called if it is not present
>> in component list during sound card registration.
>> Check if component is available in component list for
>> platform and cpu dai before soundcard registration.
>>
>> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> ---
> I got below WARNING by this patch.
> I guess we need mutex_lock() on snd_soc_register_card() ?

Right, we should have client_mutex lock before calling 
soc_find_component().

We will post fix.

>
> 	...
> 	[drm] Device feb00000.display probed
> 	[drm] Cannot find any crtc or sizes
> 	[drm] Cannot find any crtc or sizes
> 	WARNING: CPU: 0 PID: 76 at sound/soc/soc-core.c:739 soc_find_component+0xb8/0xc0
> 	CPU: 0 PID: 76 Comm: kworker/0:1 Not tainted 5.0.0-rc1+ #1360
> 	Hardware name: Renesas H3ULCB Kingfisher board based on r8a7795 ES2.0+ (DT)
> 	Workqueue: events deferred_probe_work_func
> 	pstate: 60000005 (nZCv daif -PAN -UAO)
> 	pc : soc_find_component+0xb8/0xc0
> 	lr : soc_find_component+0xb4/0xc0
> 	sp : ffff00001217ba10
> 	x29: ffff00001217ba10 x28: 0000000000000000
> 	x27: ffff000010a82920 x26: 0000000000000000
> 	x25: ffff8006f9c59900 x24: ffff0000105f33a0
> 	x23: ffff000010948d70 x22: 0000000000000000
> 	x21: ffff000010af1720 x20: ffff8006ff80b6d8
> 	x19: ffff8006f8523080 x18: 0000000000000010
> 	x17: 0000000000000000 x16: 0000000000000000
> 	x15: ffffffffffffffff x14: 0720072007200720
> 	x13: 0720072007200720 x12: 0720072007200720
> 	x11: 0720072007200720 x10: 0720072007200720
> 	x9 : 0000000000000000 x8 : ffff000010a85000
> 	x7 : ffff000010114bd4 x6 : 0000000000000001
> 	x5 : 0000000000000018 x4 : 0000000000000001
> 	x3 : 0000000000000000 x2 : 0000000000000003
> 	x1 : ffff000010af17b0 x0 : 0000000000000000
> 	Call trace:
> 	 soc_find_component+0xb8/0xc0
> 	 soc_init_dai_link+0x18c/0x210
> 	 snd_soc_register_card.part.16+0x138/0x198
> 	 snd_soc_register_card+0x30/0x48
> 	 devm_snd_soc_register_card+0x4c/0xa0
> 	 graph_probe+0x2d8/0x388
> 	 platform_drv_probe+0x58/0xa8
> 	 really_probe+0x1c0/0x2a0
> 	 driver_probe_device+0x5c/0xf0
> 	 __device_attach_driver+0x9c/0xe0
> 	...

Regards,
Rohit
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

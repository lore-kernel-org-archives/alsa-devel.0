From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/3] ALSA: pcm: add tracepoints for PCM
	params refinement
Date: Wed, 7 Jun 2017 17:38:24 +0900
Message-ID: <f673a8f5-204a-ac5d-a366-31f72c0d7106@sakamocchi.jp>
References: <20170606234645.13775-1-o-takashi@sakamocchi.jp>
 <s5hfufc5p65.wl-tiwai@suse.de>
 <c2534f9d-d2a1-2e0c-2beb-58bedbe2239f@sakamocchi.jp>
 <s5htw3s43t6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id D531D266991
 for <alsa-devel@alsa-project.org>; Wed,  7 Jun 2017 10:38:27 +0200 (CEST)
In-Reply-To: <s5htw3s43t6.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Ju 7 2017 17:09, Takashi Iwai wrote:
>>>> The second field represents id of each rule applied to the runtime, and
>>>> the total number of rules added to the runtime. Basically, when the rule
>>>> is applied to the runtime, these events are probed, but lines with id 0
>>>> are exceptions. They're application of constraints to the runtime.
>>>>
>>>> The third field is name of parameter in the runtime. The rest fields
>>>> depends on type of the parameter (mask/interval).
>>>>
>>>>
>>>> In ALSA PCM core, runtimes get 22 (or 21) rules as a default. In a below
>>>> sample, the 21st rule is added by driver (snd-soc-imx-ssi.ko). The rest is
>>>> added by snd-pcm.ko. In detail, please see 'snd_pcm_hw_constraints_init()'
>>>> and 'snd_pcm_hw_constraints_complete()' in 'sound/core/pcm_native.c'.
>>>>
>>>> hw_interval_param: 0,0,0,0 019/023 PERIOD_TIME 0 0 [0 4294967295] 0 0 (166 4095875]
>>>> hw_interval_param: 0,0,0,0 020/023 BUFFER_TIME 0 0 [0 4294967295] 0 0 (333 4096000]
>>>> hw_interval_param: 0,0,0,0 021/023 PERIOD_SIZE 0 1 [16 32767] 0 1 [16 32766]
>>>> hw_interval_param: 0,0,0,0 022/023 BUFFER_BYTES 0 1 [128 65536] 0 1 [128 65536]
>>>> hw_interval_param: 0,0,0,0 023/023 RATE 0 0 [8000 96000] 0 0 [8000 96000]
>>>> hw_mask_param:     0,0,0,0 001/023 FORMAT 00000000000000000000001000000044 00000000000000000000001000000044
>>>
>>> Could you add these explanations in Documentation?  The cover letter
>>> is gone at merging.
>>
>> Hm. Could I postpone the task for my later work in this development
>> period? Text writing takes me a bit time, but I have patches for the
>> rest of my RFC and firewire stack.
> 
> It's fine if you can promise to submit the document patch in this
> development cycle :)

I promise.


Regards

Takashi Sakamoto

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] ALSA: isa/wavefront: Fix potential Spectre v1
 vulnerabilities
Date: Thu, 20 Dec 2018 11:13:31 -0600
Message-ID: <c367ab0f-6b07-fa4f-0e05-0050a02875ae@embeddedor.com>
References: <20181219233143.GA14518@embeddedor> <s5ha7l0obxk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha7l0obxk.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 12/20/18 2:11 AM, Takashi Iwai wrote:
> On Thu, 20 Dec 2018 00:31:43 +0100,
>   Gustavo A. R. Silva  wrote:
>>
>> header->number is indirectly controlled by user-space, hence leading
>> to a potential exploitation of the Spectre variant 1 vulnerability.
>>
>> This issue was detected with the help of Smatch:
>>
>> sound/isa/wavefront/wavefront_synth.c:792 wavefront_send_patch() warn: potential spectre issue 'dev->patch_status' [w] (local cap)
>> sound/isa/wavefront/wavefront_synth.c:819 wavefront_send_program() warn: potential spectre issue 'dev->prog_status' [w] (local cap)
>> sound/isa/wavefront/wavefront_synth.c:1197 wavefront_send_alias() warn: potential spectre issue 'dev->sample_status' [w]
>> sound/isa/wavefront/wavefront_synth.c:1248 wavefront_send_multisample() warn: potential spectre issue 'dev->sample_status' [w]
>> sound/isa/wavefront/wavefront_synth.c:1548 wavefront_synth_control() warn: potential spectre issue 'dev->sample_status' [r] (local cap)
>>
>> Fix this by sanitizing header->number before using it to index
>> dev->patch_status, dev->prog_status and dev->sample_status.
>>
>> Notice that given that speculation windows are large, the policy is
>> to kill the speculation on the first load and not worry if it can be
>> completed with a dependent load/store [1].
>>
>> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Is there any platform with ISA slot that suffers from Spectre?
> 
> 

Do you mean 'any other'?

If so, yeah, I just spotted some Spectre vulns in sound/isa/sb/emu8000.c

I'll send a patch for that.

Thanks
--
Gustavo

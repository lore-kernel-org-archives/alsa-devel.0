From: Jorge <jorge.sanjuan@codethink.co.uk>
Subject: Re: [PATCH v2 4/4] ALSA: usb-audio: Operate UAC3 Power Domains in PCM
 callbacks
Date: Mon, 30 Jul 2018 17:09:38 +0100
Message-ID: <95e003a2-0cc2-6ce1-b330-0a4fa3643386@codethink.co.uk>
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
 <20180730092336.18741-1-jorge.sanjuan@codethink.co.uk>
 <20180730092336.18741-5-jorge.sanjuan@codethink.co.uk>
 <s5h8t5sx3x9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h8t5sx3x9.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 30/07/18 14:13, Takashi Iwai wrote:
> On Mon, 30 Jul 2018 11:23:36 +0200,
> Jorge Sanjuan wrote:
>>
>> Make use of UAC3 Power Domains associated to an Audio Streaming
>> path within the PCM's logic. This means, when there is no audio
>> being transferred (pcm is closed), the host will set the Power Domain
>> associated to that substream to state D1. When audio is being transferred
>> (from hw_params onwards), the Power Domain will be set to D0 state.
>>
>> This is the way the host lets the device know which Terminal
>> is going to be actively used and it is for the device to
>> manage its own internal resources on that UAC3 Power Domain.
>>
>> Note the resume method now sets the Power Domain to D1 state as
>> resuming the device doesn't mean audio streaming will occur.
> 
> I guess we need the power state transition to D0 also in prepare
> callback.  The recovery from suspend doesn't need hw_params call but
> just prepare -> trigger.

Right! Shouldn't it then be enough to just go to D0 on .prepare? I,e.
Move the state transition from .hw_params to .prepare.

Jorge

> 
> One could think of implementing into the trigger, but since the
> transition needs some delay, prepare callback would be a better
> choice, as it seems.
> 
> 
> thanks,
> 
> Takashi
> 

-- 
Jorge Sanjuan, Software Engineer                         Codethink Ltd
http://www.codethink.co.uk/
We respect your privacy.   See https://www.codethink.co.uk/privacy.html

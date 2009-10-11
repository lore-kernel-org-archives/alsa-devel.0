From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 0/30] ALSA: HDA VIA: patch series
Date: Sun, 11 Oct 2009 13:51:28 -0600
Message-ID: <4AD23740.9060800@gmail.com>
References: <4AD06ADD.4000308@viatech.com.cn>	<s5h8wfhewf1.wl%tiwai@suse.de>	<51f3faa70910110956t3b537401p51a4053102f94a2c@mail.gmail.com>
	<s5hvdil4tor.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FB451037E3
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Oct 2009 21:51:32 +0200 (CEST)
Received: by ywh33 with SMTP id 33so2579636ywh.23
	for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2009 12:51:31 -0700 (PDT)
In-Reply-To: <s5hvdil4tor.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, LydiaWang@viatech.com.cn, Logan Li <loganli@viatech.com.cn>, HaraldWelte@viatech.com
List-Id: alsa-devel@alsa-project.org

On 10/11/2009 01:27 PM, Takashi Iwai wrote:
> At Sun, 11 Oct 2009 10:56:48 -0600,
> Robert Hancock wrote:
>>
>> On Sun, Oct 11, 2009 at 10:18 AM, Takashi Iwai<tiwai@suse.de>  wrote:
>>> At Sat, 10 Oct 2009 19:07:09 +0800,
>>> Logan Li wrote:
>>>>
>>>> Following patch series mainly includes:
>>>>   - support VT1718S, VT2002P, VT1812S, VT1716S, ...
>>>>   - support smart 5.1
>>>>   - add jack detection for VT1708
>>>>   - power saving functions
>>>
>>> Thanks for the patches.  They are all well formatted now.
>>>
>>> I applied your patches except for 17,
>>>         ALSA: HDA VIA: Add 2nd S/PDIF out for VT1708S and VT1702
>>> as Robert reported a regression.
>>>
>>> This is likely because of the behavior change by this patch.  Now
>>> the second SPDIF has to be specified manually with the explicit
>>> substream number.  This itself is fine, but I see the problem with
>>> pulseaudio, for example.  There is no good way to specify this substream
>>> automatically for PA with some symbols like "spdif" or "hdmi".
>>>
>>> This is basically a problem of the current ALSA core and HD-audio core
>>> implementation.  So, we should solve all together.
>>
>> Actually, the latest posted version didn't have the mixer problem I
>> had before (I haven't looked in detail at what was different). But I
>> agree using a different substream for a different output isn't ideal
>> since there's no way for software to detect that this is the case. Can
>> it be a separate PCM like hw:0,2 or something?
>
> It would work like hw:0,1,1.  But, this is exactly what I mentioned in
> the above.  The secondary SPDIF isn't specified as an intuitively
> selectable PCM device.

Well, if it was its own subdevice like hw:0,2 it would have some hope of 
being detected by HAL, PulseAudio, etc. If it's just a substream then I 
don't think that software can actually tell it's a separate output and 
not just a HW mixing-type stream, etc.

>
>> Hopefully VIA will also look into the SPDIF no-output problem I have
>> with VT1828S..
>
> What is the problem, specifically?

With the latest patch I do get the optical output lighting up and the 
receiver detects a PCM signal, but it seems to be just silence coming 
through. (In previous iterations the SPDIF digital converter wasn't 
being enabled automatically so it didn't get even that far.)

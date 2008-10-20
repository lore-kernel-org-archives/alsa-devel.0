From: Xarteras <xarteras@nostalgicnetworxx.org>
Subject: Re: [PATCH] snd-sbxfi: implement Master volume control
Date: Mon, 20 Oct 2008 12:41:40 +0000
Message-ID: <48FC7C84.5070805@nostalgicnetworxx.org>
References: <20081019225808.8054977DF81@carpathia.dereferenced.org>	<s5h8wsjrem3.wl%tiwai@suse.de>	<s5hskqrod8k.wl%tiwai@suse.de>	<48FC77DB.2030509@nostalgicnetworxx.org>	<s5h8wsj5u81.wl%tiwai@suse.de>
	<s5h7i835tws.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nostalgicnetworxx.org (snowleopard.nostalgicnetworxx.org
	[87.106.211.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 72FBD1038DA
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 14:44:07 +0200 (CEST)
In-Reply-To: <s5h7i835tws.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, William Pitcock <nenolod@sacredspiral.co.uk>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 20 Oct 2008 14:25:34 +0200,
> I wrote:
>> At Mon, 20 Oct 2008 12:21:47 +0000,
>> Xarteras wrote:
>>> Takashi Iwai wrote:
>>>> At Mon, 20 Oct 2008 07:59:32 +0200,
>>>> I wrote:
>>>>> At Sun, 19 Oct 2008 18:08:15 -0500,
>>>>> William Pitcock wrote:
>>>>>> Unfortunately, the X-Fi does not have a hardware master volume control, so we have
>>>>>> to create a virtual master and bind all playback controls to it.
>>>>>>
>>>>>> This patch depends on the patch that renames Master to PCM.
>>>>>>
>>>>>> Signed-off-by: William Pitcock <nenolod@sacredspiral.co.uk>
>>>>> I don't like this patch because the virtual master implementation is
>>>>> already found in sbxfi.c  No reason to use yet another vmaster
>>>>> framework in addition.
>>>>>
>>>>> So, no I don't apply both patches.  A simpler fix is just to add PCM
>>>>> volume like Master volume.  Both can use the same callbacks, so the
>>>>> addition would be pretty small.
>>>> I added PCM volume now using the same mechanism as Master volume.
>>>> Please give it a try, and let me know if it's broken.
>>>>
>>> The last version from git is again, not working for me.
>>>
>>> To make it work the following fixes are needed:
>>> The correct option for the ratec is SRCCTL_STATE_INIT, not 
>>> SRCCTL_STATE_TAIL.
>>>
>>> --- sbxfi.c.ori 2008-10-20 14:13:53.000000000 +0200
>>> +++ sbxfi.c     2008-10-20 14:18:06.000000000 +0200
>>> @@ -542,7 +542,7 @@
>>>          }
>>>          ratec |= SRCCTL_FMT_S16;
>>>          ratec |= SRCCTL_BUS_MASTER;
>>> -       ratec |= SRCCTL_STATE_TAIL;
>>> +       ratec |= SRCCTL_STATE_INIT;
>>>
>>>          ctrl = ratec;
>>>          ctrl |= SRCCTL_PITCH_MASTER; /* master */
>> Oops, thanks for checking it.
>> Will fix it now.
> 
> Fixed and pushed out.
> 
>>> Also for some strange and for me unknown reason the patch "ALSA: 
>>> snd-sbxfi: use SBXXXX model numbers instead of user-unfriendly names 
>>> like UAA and ORIG." broke sound output, too.
>>> Reverting it and applying the patch above fixes the driver for me.
>> Hm, it's weird.  Checking now...
> 
> Maybe the id string was changed by the patch unexpectedly?
> Check /proc/asound/cards output before and after the patch.
> If so, it's because the mixer setting was lost and not restored via
> alsactl due to the renaming of the id string.  Re-adjust the mixer
> setting again.
> 

Whoops, don't know how I could miss that.
It works now with the new IDs, thanks :)

Jan Wolf

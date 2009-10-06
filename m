From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/1] Changing the Multi Track Peak control
 from MIXER to PCM type
Date: Tue, 6 Oct 2009 15:41:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0910061540130.31529@eeebox2.perex-int.cz>
References: <1254833466-11485-1-git-send-email-pavel.hofman@ivitera.com>
	<s5hmy443cin.wl%tiwai@suse.de> <4ACB4846.6080208@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BEB9D24368
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Oct 2009 15:41:41 +0200 (CEST)
In-Reply-To: <4ACB4846.6080208@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Oct 2009, Pavel Hofman wrote:

> Takashi Iwai wrote:
>> At Tue,  6 Oct 2009 14:51:06 +0200,
>> pavel.hofman@ivitera.com wrote:
>>> From: Pavel Hofman <pavel.hofman@ivitera.com>
>>>
>>> * The "Multi Track Peak" control is now of PCM type, to avoid
>>>   confusing users in other alsa mixers.
>>
>> We still need to handle the older kernels, so it has to retry with
>> IFACE_MIXER as fallback.
>>
>> Could you fix and repost?
>
> Sure, just would you please tell me which snd_ctl_elem method to use to
> check for existence of the control? I have no experience with alsa-lib

Just use snd_ctl_elem_read() as in update_peak_switch(). If an error is 
returned, control is not present.

 						Jaroslav


-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

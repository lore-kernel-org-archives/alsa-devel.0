From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: add support for disabling period irq
Date: Mon, 8 Nov 2010 22:04:09 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011082203330.29422@eeebox2.perex-int.cz>
References: <1288649573-31545-1-git-send-email-pierre-louis.bossart@intel.com>
	<s5h8w1c18no.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020850550.29422@eeebox2.perex-int.cz>
	<s5h4oc016eq.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020923430.29422@eeebox2.perex-int.cz>
	<s5h1v7415ih.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011020957590.29422@eeebox2.perex-int.cz>
	<s5hy69cytmn.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1011021020550.29422@eeebox2.perex-int.cz>
	<AANLkTimCOOpV7fe1sbaWqY3ZpWQ3eZOkOi6pxyJVFo55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1570021637-1289250249=:29422"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 91F34243EC
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 22:04:09 +0100 (CET)
In-Reply-To: <AANLkTimCOOpV7fe1sbaWqY3ZpWQ3eZOkOi6pxyJVFo55@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1570021637-1289250249=:29422
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 8 Nov 2010, pl bossart wrote:

>>>>>>> I feel that some bottom-line check is needed if we keep the linear
>>>>>>> position over the buffer size even without the period irq.
>>>>>>> If the app doesn't care, OK fine, the driver shouldn't care, too.
>>>>>>> But then it doesn't make sense to keep the linear position, either.
>>>>>>
>>>>>> But if we can keep the linear position using the light-weight jiffie=
s
>>>>>> check, it's probably OK to keep it rather than changing the hw_ptr
>>>>>> behaviour.
>>>>>
>>>>> Well, but the point of the patch is to avoid wakeups as much as
>>>>> possible. =C2=A0The jiffies-check adds an unconditional wakeup for ea=
ch
>>>>> buffer size, thus it's against the purpose of the patch.
>>>>
>>>> I don't see any wakeup.
>>>
>>> The CPU is woken up. =C2=A0This is to be avoided.
>>
>> Nope. No timers are used. The jiffies check and hw_ptr correction should=
 be
>> done from the avail_update call invoked from an application.
>
> ok, so I re-implemented all the points found in the reviews except for
> this thread. There's already some code to see if we go beyond the
> buffer boundaries, so I am not sure what the 'linear position' means.

Linear means that new hw_ptr must be always behind the previous hw_ptr.

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1570021637-1289250249=:29422
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1570021637-1289250249=:29422--

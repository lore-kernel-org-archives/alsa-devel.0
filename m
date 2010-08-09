From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: move snd-aloop to the alsa-kernel tree?
Date: Mon, 9 Aug 2010 15:10:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008091446210.10278@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.1008090858190.10278@eeebox2.perex-int.cz>
	<s5hbp9cz1kq.wl%tiwai@suse.de>
	<alpine.LNX.2.00.1008091348140.10278@eeebox2.perex-int.cz>
	<s5h39uodmsr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DC72210381C
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 15:10:13 +0200 (CEST)
In-Reply-To: <s5h39uodmsr.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Aug 2010, Takashi Iwai wrote:

> At Mon, 9 Aug 2010 13:50:37 +0200 (CEST),
> Jaroslav Kysela wrote:
>>
>> On Mon, 9 Aug 2010, Takashi Iwai wrote:
>>
>>> At Mon, 9 Aug 2010 09:17:10 +0200 (CEST),
>>> Jaroslav Kysela wrote:
>>>>
>>>> Hi all,
>>>>
>>>>  	does anyone have any objection to move the loop module (snd-aloop)
>>>> from the alsa-driver tree to the alsa-kernel tree (Linux 2.6 tree)?
>>>>  	I worked on these things last days:
>>>>
>>>> - fixed timing issues (we cannot use the identical period
>>>>    timing for both playback/capture - it also means that the capture and
>>>>    playback buffer setup might be different)
>>>> - added proper buffer silencing when the playback is in the draining phase
>>>> - added stream parameters change notification (stop the capture stream
>>>>    when the playback stream parameters were changed)
>>>> - added controls to propagate the playback stream parameters to the
>>>>    user space with the notification of changes
>>>> - added simple time shift functionality to compensate the time drift for
>>>>    another clock source
>>>
>>> Sounds good.  But, let's merge it into 2.6.37.
>>
>> I don't see any reason to wait with merging of this pretty generic driver
>> while 2.6.36-rc1 is not released, but I'm not in a hurry :-)
>
> As a generic rule, all new features to be merged should have appeared
> in linux-next (i.e. also mm tree) before the merge window opened.

OK, I put the snd-aloop driver to my devel git tree and removed the code 
from the alsa-driver git tree (with the new pm_qos_request updates).

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] ALSA: pcm_lib - read/write IO improvement
Date: Wed, 14 Apr 2010 09:23:54 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004140910230.16336@eeebox2.perex-int.cz>
References: <20100413144959.601bb9db.jhnikula@gmail.com>
	<s5hljcrz3ps.wl%tiwai@suse.de>
	<20100414095802.6f24e87f.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1875F24434
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 09:23:55 +0200 (CEST)
In-Reply-To: <20100414095802.6f24e87f.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Apr 2010, Jarkko Nikula wrote:

> On Tue, 13 Apr 2010 19:01:35 +0200
> Takashi Iwai <tiwai@suse.de> wrote:
>
>>> So by not doing the padding the distance to xrun is about the same and
>>> the wake-up semantics remains the same. I understood from the thread
>>> below that not all applications like if the wake-up happens before
>>> avail >= avail_min what would happen with the second idea.
>>>
>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-December/023986.html
>>
>> Well, my understanding is that it's an application thing.
>> It feeds the unaligned data while it expects the aligned wake-up.
>>
>> Or, any other real example that doesn't work?
>>
> Actually I noticed this by wondering why there are wake-ups happening
> only for every second period even if there are only two periods. E.g.

It's quite nice jitter problem in the ring buffer position updates from 
the drivers. Thanks for the detailed explanation.

Your first proposal (change wake up condition) looks more appropriate to 
me, but I need to think more about this issue.

Another solution might be to add another position check using a workqueue 
or any timer source when the expectation of missed wake up is close.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: [PATCH] cs46xx update SMP fixes
Date: Thu, 22 Aug 2002 15:33:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D64E811.30005@cucumelo.org>
References: <3D64B60D.5070907@cucumelo.org> <s5hit23t65p.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>could you rewrite mutex with spinlock if not too long held?
>
>you cannot use mutex on trigger since this could be called from
>interrupt handlers, too (in order to stop the stream when xrun is
>detected).
>
I believe that the critical sections are too long and will lose to much 
performance
on a SMP machines that's why i've choose the mutex instead of spin_locks.
However, that the trigger functions could be called from interrupt 
context is new to me,
thanks to pointing it out.
Mutexes are used in _trigger function in current CVS too, not directly 
in trigger function,
but in _link and _unlink function called by _trigger, and SMP is broken, 
so in  some
way we need to fix it.

I'll try to come with another solution, if you have any suggestion how 
to solve it, then great.

/Benny





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390

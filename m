From: Igor Kovalenko <garrison@mail.ru>
Subject: Re: [Openvortex-dev] Re: Re: [ALSA - driver 0001138]:
 errors when installing au8820 modules
Date: Tue, 07 Jun 2005 21:38:12 +0400
Message-ID: <42A5DB84.2030407@mail.ru>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <s5hwtp6w2nw.wl@alsa2.suse.de> <42A5D3C8.1030903@mail.ru> <200506071917.42953.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200506071917.42953.alien999999999@users.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alien <alien999999999@users.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, openvortex-dev@nongnu.org, Raymond <rayau@netvigator.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alien wrote:
> Op dinsdag 7 juni 2005 19:05, schreef Igor Kovalenko:
> 
>>Takashi Iwai wrote:
>>
>>>At Tue, 7 Jun 2005 17:16:02 +0200,
>>>
>>>Alien wrote:
>>>
>>>>[1  <text/plain; iso-8859-1 (quoted-printable)>]
>>>>
>>>>Op dinsdag 7 juni 2005 17:05, schreef Raymond:
>>>>
>>>>>The patch (diff11.diff) cause segmenation fault on my 32bit machine
>>>>>during /etc/init.d/alsasound start
>>>>>
>>>>>http://savannah.nongnu.org/patch/?func=detailitem&item_id=3948
>>>>>
>>>>>Do anyone know why readl() and writel() behave different in i386
>>>>>(32bits) and AMD64 (64bits) ?
>>>>>
>>>>>http://sourceforge.net/mailarchive/message.php?msg_id=10773530
>>>>>
>>>>>
>>>>>#ifndef CONFIG_X86_64
>>>>>
>>>>>#define        hwread(x,y) readl((x)+((y)>>2))
>>>>>#define        hwwrite(x,y,z) writel((z),(x)+((y)>>2))
>>>>>
>>>>>#else
>>>>>
>>>>>#define        hwread(x,y) readl((x)+(y))
>>>>>#define        hwwrite(x,y,z) writel((z),(x)+(y))
>>>>>
>>>>>#endif
>>>>
>>>>that doesn't look good, unless the mmio is void* in 32bit and unsigned
>>>>long* in x86_64...
>>>>
>>>>'unsigned long* mmio' should be preferred and together with '#define
>>>>hwread(x,y) readl((x)+(y))' , this works for both platforms
>>>
>>>I guess using "unsigned long" for both architectures is broken, too.
>>>Should be "u32" to be arch-independent.
>>
>>I strongly believe readl() and writel() on x86_64 does 32 bit reads/writes.
>>(checked linux-2.6.12-rc5). Therefore reads/writes are of correct size with
>>that patch - should be something different.
> 
> 
> i know that does not work!
> 
> when i started doing this, i got segfaults because of the >>2 .
> 
> readl and writel do long operations as evidenced by the 'l'
> 
> i know this seems weird, but this is memory-mapped, and appearantly it's 
> memory mapped to long, anyway; when i do 'unsigned long* mmio' and i use 
> readl and writel without any bitshifts, it works...
> 
> you may believe what you want, but i _know_ that on x86_64, i _NEED_ unsigned 
> long* mmio and no bitshifting to get this to work.
> 
> maybe the problem lies with writel and readl to begin with, maybe if you wrote 
> an int, it would work...
> 
> AL13N

OK, then let's put it this way: change to void* and removal of shifts is to make
address operations correct. That is the address itself is at the same offset on
all arches. Then readl/writel just do 32 bit read/write which is what we need.
May be it is the mapping is wrong?

Please check if you applied the patch correctly - I suspect you used different
kernel version and patch may have missed some points... BTW the segfault (oops)
report would be handy.

-- 
Kind regards,
Igor V. Kovalenko


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20

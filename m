From: Paul Davis <pbd@op.net>
Subject: Re: AW: general audio card Q
Date: Wed, 31 Jul 2002 08:47:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207311245.OAA19422@alsa.alsa-project.org>
References: <DAELIEGDPLDDCIJPAICBIECECDAA.annabellesgarden@yahoo.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx2.fast.net (newmx2.fast.net [209.92.1.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA19422
	for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2002 14:45:52 +0200
In-Reply-To: Your message of "Wed, 31 Jul 2002 13:20:24 +0200."
             <DAELIEGDPLDDCIJPAICBIECECDAA.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@alsa-project.org, l5gibson@hotmail.com
List-Id: alsa-devel@alsa-project.org

>Paul wrote:
>
>> cards that do not use DMA should generally be considered inferior
>> because of the extra CPU cycles they force on the host system.
>
>not generally. i.e. the pinnacle/fiji way is to map a piece of memory into
>the pc's memory space.
>thus an application using alsa-mmap can write (or read) directly into the
>cards pcm-memory.
>pretty efficiently, don't you think? (except that its ISA-memory)
>(it can do so with 2 or 3 periods per buffer).
>I don't see any drawback here caused by the lack of DMA.

yes, but this isn't what I mean by "a card that doesn't use
DMA". cards that don't use DMA require the host CPU to issue an
instruction per-small-piece-of-data to move it from host memory to the
interface memory. what you're describing is still instruction-free
movement of data between the two. the fact that the mapping is
interface->host rather than host->interface (as on the rme9652,
sblive, ice1712 and others) doesn't change that all that much.

--p


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31

From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: User land drivers.
Date: Fri, 3 Sep 2004 16:08:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409031603060.21405@linux.local>
References: <413456AE.7000007@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 026D42C0
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 16:22:17 +0200 (MEST)
In-Reply-To: <413456AE.7000007@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 31 Aug 2004, James Courtier-Dutton wrote:

> Would it be possible to have userland processes creating /dev/ files ?

It's not necessary for the ALSA case.

> Alternatively, could we provide a new plugin method, so we can add 
> userland PCMs, Mixer, etc.

Yes, a new PCM i/o plugin in alsa-lib is sufficient. For mixer, we need to 
create an additional layer. 

Actually, I'm thinking to design a loopback soundcard in kernel in 
conjunction with a daemon with these targets:

1) creating "virtual" hardware (PCMs, mixers, RawMIDI ports etc.)
2) redirect OSS emulation from the kernel space back to user space
3) redirect ALSA devices back to user space

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

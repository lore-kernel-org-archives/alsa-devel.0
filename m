From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 31 Aug 2004 11:39:46 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408311131310.1762@pnote.perex-int.cz>
References: <200408310852.i7V8qSKk023731@www4.pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 31D0126A
	for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2004 11:50:58 +0200 (MEST)
In-Reply-To: <200408310852.i7V8qSKk023731@www4.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: atlka@pg.gda.pl, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 31 Aug 2004, Peter Zubaj wrote:

> Hi,
> 
> Why not create some kind of sound server (again sound server :-)) with
> alsa-lib API on both sides. Some combination of dmix and dsnoop.
> I don't think that most of users needs low latency provided by dmix.
> Most of users need software mixing, something to be able to do
> upmixing (down mixing) from 2 -> 5.1 and ability to record in more
> then 1 app and maybe bass/treble (equalizer). This server can use hw
> mixing too, if it is provided by sound card. This can be like virtual
> soundcard, but in userspace.

Yes, we might end up with this solution.

Anyway, the problem now is to reroute data from the kernel driver back to 
user space. My ideas are:

1) use ALSA API also from the back side (capture direction); we have
   already very efficient transfer method and sharing one ring buffer for
   both playback (application) and capture (mixing daemon) is possible
2) use universal control API to pass messages like stream parameters etc.
3) clocking
   - synced to system time clock (probably jiffies) - for no real playback
   - or use the slave PCM timer for the real output devices

It seems that many parts of the current dummy driver can be reused.

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

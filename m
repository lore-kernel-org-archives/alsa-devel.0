From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Two sound cards, only sound out of one
Date: Fri, 29 Aug 2003 11:27:44 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0308291113410.27398-100000@studcom.urz.uni-halle.de>
References: <20030829165719.68400c00.erikd-alsa@mega-nerd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20030829165719.68400c00.erikd-alsa@mega-nerd.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Erik de Castro Lopo wrote:
> > Is the output of "lspci -x" the same for both cards (except port and
> > irq settings)?
>
> Slightly different:
>     00:0a.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
>     [... port 0xa400, irq 10 ...]
>     00:0d.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
>     [... port 0x9400, irq 5 ...]

These are different cards.

If these were in the same slots as in your previous mails, the ES1371
worked while the 5880 didn't.

> I have the original two cards in the machine, in their two
> original slots and they both work.
>
> I have no idea what the problem was.

What is the output of "lspci -x" now?


Regards,
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

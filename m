From: Ove Kaaven <ovek@transgaming.com>
Subject: Re: mmap_commit() and hardware buffering
Date: Sat, 05 Nov 2005 15:40:44 -0500
Message-ID: <1131223244.5118.13.camel@renegade>
References: <20051101165651.2a5f125b.davmac@davmac.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051101165651.2a5f125b.davmac@davmac.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Davin McCall <davmac@davmac.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

tir, 01,.11.2005 kl. 16.56 +1100, skrev Davin McCall:
> My thinking is that for double-buffered cards, the driver could demand that the lock/unlock buffer calls be used (i.e. the direct sound layer has to lock part of the buffer before updating it, and unlock it when done), in which case the driver has much better info about how much it can commit (a portion of the buffer can be committed when it is unlocked).

The TransGaming Cedega alsa driver does something like this - always.
The overhead is negligible, it works on pretty much everything (barring
dmix bugs, which AFAIK still remains a problem), and just-in-time mixing
is possible (thanks to suggestions from the alsa developers).

This implementation was once upon a time offered to Wine in a wine-devel
posting, but as is normal, there was no reply.



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

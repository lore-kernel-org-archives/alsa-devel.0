From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Why do I get broken pipe on write to a pcm in
 statePREPARED?
Date: Tue, 17 Sep 2002 13:55:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209171341410.2859-100000@mailserver.intern.bfad.de>
References: <s5hhegoswi7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhegoswi7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Anders Torger <torger@ludd.luth.se>, Abramo Bagnara <abramo.bagnara@libero.it>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 17 Sep 2002, Takashi Iwai wrote:

> 
> but are you sure that this feature is really implemented?
> on my system, write() to an FIFO which is not opened for read doesn't
> fail, for example,
> 	% mkfifo /tmp/foo
> 	% cat /dev/random > /tmp/foo
> and cat is blocked, not failed.

No, in this case open() blocks. cat is even not started, because the shell
waits for open().

If you open /tmp/foo for reading, then open() suceeds, cat starts and may
write. If you close the other end, the next write() from cat will return -1.

Best regards,
--
Tomasz Motylewski

P.S. ALSA has more possible states of fd than pipes which may be just
open/closed by the other side, and eventually full. This makes direct
comparision difficult.



-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab

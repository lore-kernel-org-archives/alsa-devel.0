From: Tim Goetze <tim@quitte.de>
Subject: Re: Why do I get broken pipe on write to a pcm in state
 PREPARED?
Date: Fri, 13 Sep 2002 13:45:24 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209131337110.639-100000@summer.quitte>
References: <s5hwupqtbjd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwupqtbjd.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>if it's on the blocking mode, the driver should block if it's possible
>to do write in future _by any chance_.
>if it's not on the blocking mode, the driver should return -EAGAIN.
>and, the behavior of poll() depends on the behavior of write().
>if it blocks, then poll blocks, too.

sorry, i beg to differ. poll returning immediately with EAGAIN on a
nonblock fd doesn't make sense to me. 

you call poll because you want to block until a read/write possible
condition, and not to check if read/write is possible now -- you'd
call read()/write() instead.

that's the behaviour other linux fds (file, socket, fifo etc) show
when set to nonblock, and that's what i think one naturally expects.

tim



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

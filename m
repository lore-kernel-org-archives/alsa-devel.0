From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Emptying read buffer
Date: Fri, 4 Oct 2002 18:54:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210041851570.713-100000@pnote.perex-int.cz>
References: <200210041846.22642.vollmer.philipp@t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200210041846.22642.vollmer.philipp@t-online.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Philipp Vollmer <vollmer.philipp@t-online.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 4 Oct 2002, Philipp Vollmer wrote:

> Hello,
> 
> I'm playing soundfiles in read/write fullduplex mode, but I have one
> problem:
> 
> When I'm playing this file, I'm not able to empty the buffer, because
> it needs too much CPU load. And after 2 or 3 seconds
> the buffer is full and the app crashes. Is there a possibility to
> empty the buffer without any reading? Or is there any function
> to suspend the read handle, without closing it so that I can 
> playback data?

Simply set stop_threshold to UINT_MAX and start the capture stream.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

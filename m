From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Why do I get broken pipe on write to a pcm in state
 PREPARED?
Date: Wed, 11 Sep 2002 20:48:24 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209112035050.607-100000@pnote.perex-int.cz>
References: <200209111829.g8BITg022911@d1o87.telia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200209111829.g8BITg022911@d1o87.telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 11 Sep 2002, Anders Torger wrote:

> I use a RME9652 hammerfall with two periods (the hardware is that way).
> 
> I watch a file descriptor associated to the output with select(), when 
> it gets ready for writing, I write data to the pcm with 
> snd_pcm_writen(). In the beginning, the state of the pcm is PREPARED.
> 
> What I would expect then, is that the file descriptor is ready for 
> writing until the two periods has been filled with data, and then 
> select will block (output buffers full, sound card not running). But 
> instead, when the two periods is filled with data, select() still 
> returns and says that the file descriptor is ready for writing, but 
> when calling snd_pcm_writen(), it returns -EPIPE. The pcm state is 
> still PREPARED.
> 
> What is wrong? Is it me (probably), or is it alsa?

You should also check for POLLERR. I'm not sure, that it's necessary to 
return POLLOUT together with POLLERR in that case. Anyway, application 
should check for POLLERR at first and then write data.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com




-------------------------------------------------------
In remembrance
www.osdn.com/911/

From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Why do I get broken pipe on write to a pcm in state PREPARED?
Date: Wed, 11 Sep 2002 21:04:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209111904.g8BJ49005923@d1o87.telia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Wednesday 11 September 2002 20.48, you wrote:
> On Wed, 11 Sep 2002, Anders Torger wrote:
> > I use a RME9652 hammerfall with two periods (the hardware is that
> > way).
> >
> > I watch a file descriptor associated to the output with select(),
> > when it gets ready for writing, I write data to the pcm with
> > snd_pcm_writen(). In the beginning, the state of the pcm is
> > PREPARED.
> >
> > What I would expect then, is that the file descriptor is ready for
> > writing until the two periods has been filled with data, and then
> > select will block (output buffers full, sound card not running).
> > But instead, when the two periods is filled with data, select()
> > still returns and says that the file descriptor is ready for
> > writing, but when calling snd_pcm_writen(), it returns -EPIPE. The
> > pcm state is still PREPARED.
> >
> > What is wrong? Is it me (probably), or is it alsa?
>
> You should also check for POLLERR. I'm not sure, that it's necessary
> to return POLLOUT together with POLLERR in that case. Anyway,
> application should check for POLLERR at first and then write data.

I'm sorry, I don't understand, what would be the error in the above
case? I just want to watch the file descriptor for writing, and expect
that it will be triggered when there is available space in the output
buffer to write to, or, if there is an error, for example broken pipe.
But how could it be broken pipe if the pcm is in state PREPARED? It has
never been put into RUNNING.

The problem here is that the output buffer is full, the pcm is not
RUNNING, but the file descriptor gets triggered anyway. When can that
happen?

/Anders Torger


-------------------------------------------------------
In remembrance
www.osdn.com/911/

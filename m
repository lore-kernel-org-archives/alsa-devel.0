From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Why do I get broken pipe on write to a pcm in statePREPARED?
Date: Tue, 17 Sep 2002 15:04:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209171304.g8HD4E028186@d1o87.telia.com>
References: <200209171301.g8HD1Ww01231@mother.ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200209171301.g8HD1Ww01231@mother.ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 September 2002 15.03, you wrote:
> >IMHO the current behaviour is the proper behaviour as implemented by
> > other file descriptors, and as mandated by POSIX.
> >
> ><http://www.opengroup.org/onlinepubs/007904975/functions/write.html>
> >
> >says regarding pipes, FIFOs and sockets:
> >| The write() function shall fail if:
>
> the discussion here is about the behaviour of poll(2), not
> write(2). as i read it, nobody has any problems with ALSA's write
> implementation.

I expected write with EAGAIN instead of EPIPE when writing to a full 
buffer on a prepared card. If poll blocks, EAGAIN on non-blocking 
write, and blocking on blocking write is the natural behaviour.

/Anders Torger


-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab

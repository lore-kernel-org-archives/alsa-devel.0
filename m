From: Haakon Riiser <haakon.riiser@fys.uio.no>
Subject: Re: SysEx overflow when using the MIDI sequencer event
	interface
Date: Sun, 20 Aug 2006 13:19:38 +0200
Message-ID: <20060820111938.GA1577@fox>
References: <20060819102421.GA1991@fox> <20060819200154.GA1054@fox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060819200154.GA1054@fox>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> [...] I'm having trouble getting the big picture of how the MIDI
> parts in ALSA works, so a little help would be appreciated. :-)

Never mind, I finally sucked it up, and forced myself to do the
tedious task of tracking the MIDI events all the way from user
space to hardware, and discovered what the problem was:

Turns out that the buffer that overflows isn't a hardware buffer
in the CM-32L -- it's a software buffer in ALSA that is fixed to
a single page of memory (4096 bytes on x86).

This wouldn't be a problem if there were a mechanism that allowed
incoming events to wait until there's room in the output buffer,
or at least to fail with EAGAIN, allowing the application to retry.

What happens here is that the function in question returns ENOMEM
and prints a warning (but only if you enable ALSA debugging,
which, of course, I had not) saying that events are lost due to
buffer overflow.  Unfortunately, the return code is ignored by
the calling function, so the error is silently ignored.

I _really_ hope this isn't intentional, because it makes the
event interface too fragile to be useful.  I can fix this, but
there are many ways to go about doing it (for example waiting
for the buffer to drain, dynamically increasing buffer size,
or getting the error code propagated up the stack).  I'd like to
know what the authors think is the best solution, so that I can
get the fix into the official sources.

-- 
 Haakon

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

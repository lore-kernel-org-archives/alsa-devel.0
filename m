From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Why do I get broken pipe on write to a pcm instatePREPARED?
Date: Wed, 9 Oct 2002 15:54:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210091354.g99DsA007307@d1o87.telia.com>
References: <Pine.HPX.4.33n.0210090843120.2463-100000@studcom.urz.uni-halle.de> <3DA42EEB.2030208@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DA42EEB.2030208@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Wednesday 09 October 2002 15.28, you wrote:
> Clemens Ladisch wrote:
> >The behaviour of polling during capture is just fine:
> >
> >RUNNING: block until avail_min is available, then return POLLIN
> >DRAINING: return POLLIN until buffer is empty, then return POLLERR
> >(other states: POLLERR)
> >
> >The current behaviour for playback is:
> >
> >PREPARED: return POLLOUT until the buffer is full, then return
> > POLLERR
>
> Why would the buffer get full in PREPARED state ?
> Surely any sensible, "start_threshold" should cause the state to
> change to RUNNING before the buffer is full.
> I can't see any reason to not to use "start_threshold" in order to
> get from PREPARED to RUNNING.

Because another thread that should start the card is not ready yet. In 
threaded programming it may be fully natural to first fill the output 
buffer and then start the card from another thread. Of course, you can 
always adapt to how it works (for example if there would always be a 
start threshold which could not be changed), but it is best if poll() 
works in a way that is expected, and is conforming to standards.

If poll() behaviour is changed to the proposed, we will not only get a 
more clear standard conformance (what is conforming or not is however 
always a question of interpretation, since there is no relevant 
standard that directly relates to sound cards), but a more flexible API 
in terms of how to design your multi-threaded/process applications.

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

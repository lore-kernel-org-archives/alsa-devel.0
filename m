From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Why do I get broken pipe on write to a pcm instatePREPARED?
Date: Thu, 10 Oct 2002 05:51:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210100351.g9A3p5020874@d1o87.telia.com>
References: <Pine.HPX.4.33n.0210090843120.2463-100000@studcom.urz.uni-halle.de> <200210091354.g99DsA007307@d1o87.telia.com> <3DA4E2C5.1050703@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DA4E2C5.1050703@superbug.demon.co.uk>
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

On Thursday 10 October 2002 04.15, James Courtier-Dutton wrote:
> I don't understand which applications prefer: -
> 1) "PREPARED: return POLLOUT until the buffer is full, then return
> POLLERR." and which would prefer (as suggested): -
> 2) "PREPARED: return POLLOUT until the buffer is full, then BLOCK."
>
> As I understand it, the poll works correctly in RUNNING state?
> I think (2) would basically kill all single thread apps so on
> balance, I think (1) is the best to go with for now.
>
> The application I have thought of is that an application might want
> to fill many file handles/streams buffers but keep them in PREPARED
> state. Then release all the channels at the same time so that they
> play in sync. But for that one does not need to do any polling in
> PREPARED state. One just does snd_pcm_write until one gets an error.

This is possible to do with (1) as well, actually it is only a slight  
difference. You will need to have non-blocking write in the above 
example, or else you are not sure that you fill the buffer at all, for 
example if the output buffer is 2048 frames, and you try to write 4096, 
which currently returns an error in blocking mode, but still the output 
buffer will be empty.

With non-blocking mode it works, you fill the buffer and currently you 
wait for EPIPE, with the new behaviour you would wait for EAGAIN 
instead. The (1) alternative is then more flexible in terms of 
application design. Changing the behaviour would of course break your 
example application if it specifically checks for EPIPE (and not just a 
generic error).

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

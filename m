From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Why do I get broken pipe on write to a pcm in   statePREPARED?
Date: Mon, 7 Oct 2002 15:19:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210071319.g97DJJ008659@d1o87.telia.com>
References: <Pine.HPX.4.33n.0209171615490.1084-100000@studcom.urz.uni-halle.de> <s5h65we4ksf.wl@alsa2.suse.de> <3DA178F1.769C6FFA@libero.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DA178F1.769C6FFA@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: alsa-devel@lists.sourceforge.net, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Monday 07 October 2002 14.07, you wrote:
> Takashi Iwai wrote:
> > it CAN happen if you have multi-threads.
> > the problem is that we have no option to block the poll.
>
> If you have multi-thread you have other alternative to do that.
> OTOH application can't detect *why* poll is blocking with the change
> you advocate.

This is a non-issue. I think it is larger risk to search for the wrong 
problem (like I did), that is beleiving that there is a buffer underrun 
or similar. This type of blocking bug is very easy to detect and debug, 
I don't think the bug-detection argument is important, and that is also 
the only argument for the current behaviour (apart from that it is bad 
to change APIs).

> > > That apart I'm sure that to make a change in actual behaviour
> > > between rcX and 1.0 is a professional suicide. However it's
> > > _your_ professional suicide so... ;-)))
> >
> > yes, i know it well ;)
> >
> > i don't like to change this inevitably, too.
> > and as mentioned above, i don't mind to add an option as sw_params,
> > etc. for the new behavior.
> >
> > but the current behavior is incorrect from the interpretation of
> > POSIX.  so this must be a bug.
> > if we have to change it, then i would choose the new one, because
> > it's more intuitive without exception.
>
> As pointed by Clemens the current is the proper POSIX behaviour.

Perhaps you missed it, but he actually changed his mind, I have cited 
below.

-----------------

I think we have only two choices for POSIX-compliant write() behaviour 
in the prepared state:

1) Don't allow any writes. Always return EPIPE.
   (my interpretation above)

2) Allow writes until the buffer is full, then block.
   (Takashi's second interpretation)

The current ALSA implementation is an inconsistent mixture of both:
returning EPIPE means that it is impossible to write, but then it should
not have been possible for the first bufferfull to succeed.

And we want to be able to fill the first buffer, so IMHO 2) is the way 
to go.


Regards,
Clemens

-----------------------------


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

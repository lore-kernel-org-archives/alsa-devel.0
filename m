From: Anders Torger <torger@ludd.luth.se>
Subject: Re: Why do I get broken pipe on write to a pcm in statePREPARED?
Date: Fri, 4 Oct 2002 10:14:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210040814.g948E9015465@d1o87.telia.com>
References: <Pine.HPX.4.33n.0209171615490.1084-100000@studcom.urz.uni-halle.de> <200209181957.g8IJvS008300@d1o87.telia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200209181957.g8IJvS008300@d1o87.telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wednesday 18 September 2002 21.57, Anders Torger wrote:
> On Tuesday 17 September 2002 16.40, Clemens Ladisch wrote:
> > > I feel that one can interpret both ways, so it is a quite open
> > > choice. Either way, one can state POSIX behaviour. Then the
> > > question becomes: what is the most usable behaviour?
> >
> > I think we have only two choices for POSIX-compliant write()
> > behaviour in the prepared state:
> >
> > 1) Don't allow any writes. Always return EPIPE.
> >    (my interpretation above)
> >
> > 2) Allow writes until the buffer is full, then block.
> >    (Takashi's second interpretation)
> >
> > The current ALSA implementation is an inconsistent mixture of both:
> > returning EPIPE means that it is impossible to write, but then it
> > should not have been possible for the first bufferfull to succeed.
> >
> > And we want to be able to fill the first buffer, so IMHO 2) is the
> > way to go.
>
> So, are we going to see a change in behaviour here? It seems like
> everyone which has discussed this, except Abramo, wants to see a
> change to the second interpretation which is:
>
> * write() blocks on blocking mode when output buffer is full, and
>   returns EAGAIN when in non-blocking mode.
>
> * poll/select blocks when output buffer is full
>
> ...with no difference if the card is running or not. Today, it is a
> different behaviour when the card is not running, where write returns
> EPIPE (both blocking/non-blocking) and poll/select does not block.
>
> The arguments for keeping the current behaviour is according to its
> supporter(s?):
>
>  * It is easier to detect bugs which else would dead-lock the program
>  * It is more logical, like a pipe with the hardware in the read end
>
> The arguments for changing to the new are:
>
>  * It is sometimes used in multi-threaded programs (fill buffer in
> one thread, start from another).
>  * The current behaviour has no use apart from detection of a trivial
>    dead-lock bug.
>  * Especially in multi-threaded programs, the current behaviour with
>    EPIPE can be confused with underruns or overflows, making the
>    "easier-to-detect-bug" feature to have the opposite effect.
>  * It is a POSIX-compliant behaviour which the current is not
>  * It is more logical, always same behaviour, no special case for
> cards not running
>  * It seems to be the more popular choice, and would break very
> little if any if implemented.
>
> Ok, I said I would stop argue about this, so sue me.

Uhhh... I guess ignoring me works just as well :-)

/Anders Torger


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

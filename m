From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: weird snd_ctl_open() behavior
Date: Sat, 07 Jun 2003 12:19:40 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306071202020.25513-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.44.0306060913240.28000-100000@ccrma-gate.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.44.0306060913240.28000-100000@ccrma-gate.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gary Scavone <gary@ccrma.Stanford.EDU>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(quoting fixed; please don't top-post)

Gary Scavone wrote:
> On Fri, 6 Jun 2003, Clemens Ladisch wrote:
> > The default card id is composed of the letters and numbers of the last
> > word of the card's name (as seen in /proc/asound/cards).
> > ...
> > The first parameter to hw specifies the card; if it looks like a number,
> > it will be interpreted as the card number.
>
> This behavior seems like a bug.  Could snd_ctl_open() not first
> compare the "card" argument to the known internal device id and then,
> if that fails, attempt to interpret the card as a number?

The CVS version of ALSA has now been changed so that it never creates
an id looking like a number.

> I'm using the id because it is what my program exposes to users
> for device selection (which is more human readable than the device
> number when an id is specified in the configuration).

The card's name (either shortname or longname) would be even more
human-readable (but it isn't unique when there are two identical
cards, so you still need to show card number or id).

> It's a hassle for me to have to keep both an ascii id _and_ a
> device number around, especially when the ascii id is supposed to
> do what I need.

Isn't it sufficient to keep only the card number around?
Anyway, the id will work now (as long as you're sure that your users
are using ALSA 0.9.5 or later).


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.

From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: my first usb-midi experiment ends with segmentation
 fault
Date: Thu, 01 Aug 2002 11:48:55 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0208011136310.1825-100000@studcom.urz.uni-halle.de>
References: <20020731210259.GA733@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020731210259.GA733@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Martin Langer wrote:
> On Wed, Jul 31, 2002 at 12:26:33PM +0200, Clemens Ladisch wrote:
> >
> > IMHO the garbled device name is strange, too. ;-)  This is a (rather
> > harmless) buffer overflow which has been fixed by the latest version of my
> > other patch.
>
> Rather harmless buffer overflows results in segfaults - a tough ideology!

It was the uninitialized variable which caused the segfault, the buffer
overflow only garbled the long name.

> Finally there is only one point, which doesn't show perfect beauty. It's the
> shortname of the proc entry, which looks incomplete,
>
> 3 [card3          ]: USB MIDI - Evolution Electronics Ltd. MK-2
>                      Evolution Electronics Ltd. MK-249C USB MIDI keyboard at
> 001/002 if 1

ALSA limits the length of the shortname to 32 bytes (hence _short_name).
You already know what happens if the shortname isn't restricted to that
size.  ;-)


Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

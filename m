From: "Mike Mazarick" <mazarick@bellsouth.net>
Subject: Advice wanted on developing new driver - gadget labs
Date: Tue, 28 Dec 2004 15:38:03 -0500
Message-ID: <LEEHJNBIEAAEJEHBEGDBIEMCCGAA.mazarick@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jay Schwichtenberg <jays@aracnet.com>, Waldemar Haszlakiewicz <waldemar.haszlakiewicz@siol.net>
List-Id: alsa-devel@alsa-project.org


Hi!

I am getting ready start setting up a development system for furnishing an
Alsa driver for the GadgetLabs 8/24 card (and hopefully, it will work for
the other series of GL cards also).

Ferdando Lopez-Lezcano is starting to settle on a 2.6.X Fedora Core 3 based
kernel for Planet CCRMA, and I'll use the Planet CCRMA distribution as the
development system environment.   I'm also anticipating getting the source
for a working and tested WinXP based driver ASIO driver, which is written in
C and C++.

Since this will be my first attempt at driver development (or for that
matter, development in general), I could use some advice on the tools and
methodology for writing an Alsa driver for this card.

The card itself is an 8 channel 24 bit card that operates up to 48 khz
sampling frequency.  It has an older model Altera Flex 6000 PGA as the
"engine" (this means the chip has to be "loaded" first with a circuit
description before it works), a local bus controller chip called PLX 9052,
and a little memory pluis some d/a-a/d conversion chips.  I bring this up
because other people may be interested in playing with the Altera Flex chip
for purposes other than sound generation - the development system for the
Altera Flex chip is available for download (however, it is Windoz based).
It may be interesting to others, for instance, to put a set of instructions
"in hardware" (hardware buffer overflow protection, anyone?).

In googling around, what seems useful that I could use an educated opinion
on for kernel development is:

1)  User mode linux - would this be really useful, nice to have, or not
needed for this effort?
2)  Valgrind - I presume this would be really useful, but I'm not sure if it
does a lot of good mainly for user level programs, and is not useful for
kernel level stuff.
3)  There was some discussion about a "loopback" type of soundcard that was
a software emulation of a device;   this seems to be really useful to make
sure things can be loaded/unloaded successfully.  Any comments on
4)  I haven't messed with WINE very much... didn't have plans on using it
for this effort.  Am I "missing the boat" for not using it as part of the
development effort?

Any missing items or tools that would be really useful?

I had previously solicited comments, and most people stated to use the 2.6.X
kernel, which I took as good advice, but I had to wait for the CCRMA stuff
to become a little more stable (plus the WinXP driver wasn't finished).

I would welcome any comments (obvious stuff is good), such as "sprinkle the
source with "printf" statements so you can tell how far it got before it
bombed", "make sure you have a CVS repository set up and only compile out of
this", "read all the documentation about Alsa first", "look at the XXX card
as an example that you should follow", etc.  If anyone else has done a
conversion from Windoz ASIO to Linux, it would be particularly good to learn
where the holes in the road are.

Feel free to write directly to me if you don't wish to pollute the mailing
list with comments/pointers that are too elementary for others.

Best wishes, Merry Christmas, and Happy New Year!!

Mike Mazarick



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

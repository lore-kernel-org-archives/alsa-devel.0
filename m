From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Oops in 2.6.10-rc1
Date: Sat, 6 Nov 2004 23:02:28 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org>
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz>
 <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de>
 <418D7959.4020206@g-house.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261549AbUKGHCh@vger.kernel.org>
In-Reply-To: <418D7959.4020206@g-house.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Kujau <evil@g-house.de>
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org



On Sun, 7 Nov 2004, Christian Kujau wrote:
>=20
> if someone could give me a hint here what to do next or perhaps tell =
me
> that the whole things was totally pointless - please say so.
> i am somehow lost as to which is the right person to bug here.

Since you seem to be a BK user, try doing a

	bk revtool sound/pci/ens1370.c=20

and see if you can find the change that caused your problem. Of course,=
=20
the real change might be somewhere else in the sound driver initializat=
ion=20
path, so it's not like just that one file might be the cause. Regard=F6=
ess,=20
the more you can pinpoint when the problem started, the better.

Also, if you enable frame pointers (under kernel debugging), the traceb=
ack
will look a bit better. As it is, your oops looks looks like something =
has
jumped off into la-la-land by jumping through a bad pointer (the value =
is
still in %ecx), but it's definitely not clear _where_ that happened. =20
Your trace points to pci_enable_device_bars(), but that may well be jus=
t
stale stack contents.

		Linus

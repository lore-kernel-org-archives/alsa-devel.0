From: Christian Kujau <evil@g-house.de>
Subject: Re: Oops in 2.6.10-rc1
Date: Mon, 08 Nov 2004 14:01:39 +0100
Message-ID: <418F6E33.8080808@g-house.de>
References: <4180F026.9090302@g-house.de> <Pine.LNX.4.58.0410281526260.31240@pnote.perex-int.cz> <4180FDB3.8080305@g-house.de> <418A47BB.5010305@g-house.de> <418D7959.4020206@g-house.de> <Pine.LNX.4.58.0411062244150.2223@ppc970.osdl.org> <20041107130553.M49691@g-house.de> <418E4705.5020001@g-house.de> <Pine.LNX.4.58.0411070831200.2223@ppc970.osdl.org> <20041107182155.M43317@g-house.de> <418EB3AA.8050203@g-house.de> <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411071653480.24286@ppc970.osdl.org>
Sender: linux-sound-owner@vger.kernel.org
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, alsa-devel@lists.sourceforge.net, linux-sound@vger.kernel.org, Greg KH <greg@kroah.com>
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds schrieb:
> 
> Not your fault. Think of this as a learning experience ;)

it definitely is, yes.

> Anyway, now that the _other_ driver also oopses, and with a very similar 
> oops too, so it looks like they both depended on some undocumented (or 
> changed) detail in the PCI layer. Next step would be to see if the thing 
> that breaks is this merge:

may i ask how you come to this conclusion? by technical knowledge or could
this be deduced by some bk magic too?

> 
> 	ChangeSet@1.2463, 2004-11-04 17:07:16-08:00, torvalds@ppc970.osdl.org
> 	  Merge bk://kernel.bkbits.net/gregkh/linux/driver-2.6
> 	  into ppc970.osdl.org:/home/torvalds/v2.6/linux
> 
> which merges Greg's PCI/driver model changes.
> 
> It's all the same steps you took with the ALSA merge, you're a
> professional by now ;)

i did "bk undo -a1.2463" from a current -BK tree and it oopses:

http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/dmesg-debug_oops-a1.2463.txt

(i've booted with different boot options this time, because i noticed that
i always booted with "acpi=force". changing this did not help either.)

next i wanted to do "bk undo -r1.2463" now to see if it does *not* break
without this ChangeSet (because i already know it *breaks* with this
ChangeSet) but that would leave some parentless child deltas. i read in
the BK docs that "bk cset -x<version>" would help here. but "bk cset
- -x1.2463" aborts:

- ---------------------
evil@atlant:~/kernel/linux-2.6-BK$ bk changes | head -n3
ChangeSet@1.2463, 2004-11-04 17:07:16-08:00, torvalds@ppc970.osdl.org
  Merge bk://kernel.bkbits.net/gregkh/linux/driver-2.6
  into ppc970.osdl.org:/home/torvalds/v2.6/linux

evil@atlant:~/kernel/linux-2.6-BK$ bk cset -x1.2463
cset: Merge cset found in revision list: (1.2463).  Aborting. (cset1)
- ---------------------

i've put everthing on http://www.nerdbynature.de/bits/prinz/2.6.10-rc1/
the .configs, the oopses are there. i've double checked a kernel built
from "bk -a a1.2000.7.2" yesterday but the result was the same (no oops)

thank you,
Christian.
- --
BOFH excuse #121:

halon system went off and killed the operators.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBj24z+A7rjkF8z0wRAu0tAJ9g7mfG0iz/LvSAafD7LWKNu9qvLQCg3fjW
1oMRRK8oSqH5oZsudyIQVtw=
=f8CQ
-----END PGP SIGNATURE-----

From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Subject: Re: [ALSA - tools 0001343]: bitops not 64bit clean
Date: Sun, 6 Nov 2005 17:56:30 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0511061626150.16077@redshift.mimosa.com>
References: <ad23d0cdd86a56c2aa486fb59a4801ae@bugtrack.alsa-project.org>
Reply-To: "D. Hugh Redelmeier" <hugh@mimosa.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newpack.xtdnet.nl (newpack.xtdnet.nl [193.110.157.75])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0B508171
	for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2005 22:56:47 +0100 (MET)
Received: from gw-c.mimosa.com (CPE00606767ed59-CM000f9fa81660.cpe.net.cable.rogers.com [69.199.79.248])
	by newpack.xtdnet.nl (8.13.1/8.13.1) with ESMTP id jA6LucvK020332
	for <alsa-devel@alsa-project.org>; Sun, 6 Nov 2005 22:56:41 +0100
Received: from redshift.mimosa.com (redshift.mimosa.com [192.139.70.107])
	by gw-c.mimosa.com (8.12.8/8.12.8) with ESMTP id jA6LuV4a020324
	for <alsa-devel@alsa-project.org>; Sun, 6 Nov 2005 16:56:31 -0500
In-Reply-To: <ad23d0cdd86a56c2aa486fb59a4801ae@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

| From: bugtrack@alsa-project.org
| Date: Fri, 26 Aug 2005 14:42:44 +0200

| The following issue has been RESOLVED.
| ======================================================================
| <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1343> 
| ======================================================================

| The bitops functions (set_bit and associated) that ld10k1 use come from
| the linux kernel, and assume that longs are 32bit only, causing a buffer
| overflow of the bit buffer.
| 
| The attached patch fixes the bitops to be independent of the size of
| longs, and is confirmed to fix the bug on my box.

| diff -ur alsa-tools-1.0.9/ld10k1/src/bitops.h
| alsa-tools-1.0.9.mine/ld10k1/src/bitops.h
| --- alsa-tools-1.0.9/ld10k1/src/bitops.h	2005-03-18 08:41:02.000000000

| -	addr += nr >> 5;
| -	mask = 1 << (nr & 0x1f);
| +	addr += nr >> (sizeof(long) + 1);
| +	mask = 1 << (nr & (sizeof(long) * 8 - 1));

[A similar change appears two other places in the bitops.h.]

You cans see this in CVS:
  http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-tools/ld10k1/src/bitops.h?rev=1.2&view=log

This patch looks very wrong to me.  The original code used 5 because
it is the base 2 log of the number of bits in an unsigned long
(thought to be always 32) and 0x1f because it is a mask with the
length of that same 5.

When sizeof(unsigned long) == 4:
	sizeof(long) + 1 == 5
and
	log2(sizeof(unsigned long) * 8) == 5
so the new code should work in this case.

When sizeof(unsigned long) == 8
	sizeof(long) + 1 == 9
and
	log2(sizeof(unsigned long) * 8) == 6
so the new code should not work in this case.

If this code actually works on a system with sizeof(long) == 8, then
something very funny is going on.

I don't know anything about how these functions are used, so I cannot
say what the correct fix is.

As rlrevell said in the bugtrack entry, the right change might be to
use type u32 rather than long.

Alternatively, you need a way to reference log2(sizeof(long) * 8).
Perhaps this is in some header.  It is kind of hard to calculate lg2
in a manifest constant expression.

UNTESTED CODE:
/* lg2_ulong_bits: log-base-2 of the number of bits in an unsigned long.
 * Assumes:
 * (1) a char is 8 bits (almost always true, but not required by C)
 * (2) sizeof(unsigned long) is a power of two (almost always true; assumed
 *     by other parts of the code)
 * (3) sizeof(unsigned long) is at least 4 (guaranteed by C and (1))
 * (4) sizeof(unsigned long) is at most 32 (likely true for a long while)
 */
#define lg2_ulong_bits (5 + \
	(sizeof(unsigned long) > 4) + \
	(sizeof(unsigned long) > 8) + \
	(sizeof(unsigned long) > 16))

| -	addr += nr >> 5;
| -	mask = 1 << (nr & 0x1f);
| +	addr += nr >> lg2_ulong_bits;
| +	mask = 1 << (nr & (sizeof(unsigned long) * 8 - 1));

There is a SECOND bug in this code.  The mask is declared to be of
type int but should be of type unsigned long.

The assignment to mask is also wrong:  the "1" being shifted should
actually be "1UL".  Otherwise the shift is done with an int and will
get the wrong value if sizeof(int) != sizeof(unsigned long).
Technically, but not practically, an int overflow results in undefined
behavior, according to the C standard.

Similar changes are needed in the other *_bit functions.

NOTE: I am new to the internals to alsa.  I only noticed this because
I just read the (old!) mail to which I am replying.

I did a quick look at the ld10k1/src directory in CVS.  The first file
that referred to a *_bit function was dl10k1.c.  It seems to include
<bitops.h>, not "bitops.h".  Normally, this would be the system
header file (depending on the flags used to invoke the C compiler).
On my system, Fedora Core 4 on x86_64, there is no <bitops.h> but
there is an <asm/bitops.h>.  So: I don't know what header would be
used.

The <asm/bitops.h> versions are atomic: they use lock prefixes.
Is this what ld10k1 wants?  Most single-threaded userland code doesn't
need this.  The code in "bitops.h" doesn't seem to be coded to be
atomic.  If so, I think that the naming convention in the kernel should be
followed: use names prefixed by __.  I admit that I don't like this
convention, but it has been adopted in the kernel.  I further admit
that the C standard reserves names starting with __ for the C
implementation -- one of many things with which the kernel plays fast and
loose.

I would also recommend using <asm/bitops.h>.  Why not let the kernel
coders make sure that the code is correct and efficient?  I'm not sure
that it mixes with glibc and hence normal userland code.  So this
might not be possible.

If you don't wish to use the kernel implementation, I strongly
recommend that you use names distinct from what the kernel uses.  This
will confuse readers less.

================

Will some ALSA developer work on this?  I'm willing to help, but I
hope not to have to build or test ALSA.

BTW: thanks to the team for producing such a useful product for all of
us.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php

From: Joachim Feise <jfeise+alsa@ics.uci.edu>
Subject: Re: [Alsa-user] cs46xx (Turtle Beach Santa Cruz), kernel 2.6 recording
Date: Sat, 14 Feb 2004 14:25:48 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <402EA06C.2060808@ics.uci.edu>
References: <200402142001.i1EK1SH19063@ucsc.edu> <20040214215121.GB28424@ohlone>
Reply-To: jfeise+alsa@ics.uci.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040214215121.GB28424@ohlone>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jim McCloskey said  on 2/14/2004 13:51:
>
> [2] To record from line input using this card (the Turtle Beach Santa
> Cruz, cs46xx driver), you have to set *all three* of:
>
>                           LINE  CAPTURE  ADC
>
> to Captur(e) (and also un-mute and set values appropriately of
> course).
> Alsamixer in fact shows two Capture channels for the card. Here at
> least, the crucial one is the leftmost channel.

Thank you. That solved the problem.

- -Joe

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)

iD8DBQFALqBsKc8oZ1MoTeoRAiKxAJwP5d4j97q59zYR/WbZMZMGqGhdOACfQ2sy
8dyFbifhqmUIKIX37aV2soo=
=Es1p
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

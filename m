From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio Sonica support
Date: Tue, 03 Sep 2002 10:22:58 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0209030953130.20482-100000@studcom.urz.uni-halle.de>
References: <s5hadn0e1ye.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hadn0e1ye.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Stephen Hassard <steve@hassard.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > If we have luck, the firmware is stored in a DFU file (not necessarily
> > with that name).
>
> Stephen, could you check whether any possible file eixsts on windows?

ma005101.bin  (obviously ;-)

The following looks like standard USB audio descriptors
(but I don't have the device to test it):

000620:                                  12 01 10 01 00            .....
000630: 00 00 08 63 07 05 20 01 01 01 02 00 01 09 02 15 ...c.. .........
000640: 01 02 01 00 80 64 09 04 00 00 00 01 01 00 02 09 .....d..........
000650: 24 01 00 01 28 00 01 01 0C 24 02 01 01 01 00 02 $...(....$......
000660: 03 00 00 00 0A 24 06 02 01 01 01 02 02 00 09 24 .....$.........$
000670: 03 03 01 03 00 02 00 09 04 01 00 00 01 02 00 00 ................
000680: 09 04 01 01 01 01 02 00 00 07 24 01 01 01 01 00 ..........$.....
000690: 26 24 02 01 02 03 18 0A 40 1F 00 11 2B 00 E0 2E &$......@...+...
0006A0: 00 22 56 00 C0 5D 00 00 7D 00 44 AC 00 80 BB 00 ."V..]..}.D.....
0006B0: 88 58 01 00 77 01 09 05 03 09 40 02 01 00 00 07 .X..w.....@.....
0006C0: 25 01 01 01 DC 05 09 04 01 02 01 01 02 00 00 07 %...............
0006D0: 24 01 01 01 01 00 26 24 02 01 02 02 10 0A 40 1F $.....&$......@.
0006E0: 00 11 2B 00 E0 2E 00 22 56 00 C0 5D 00 00 7D 00 ..+...."V..]..}.
0006F0: 44 AC 00 80 BB 00 88 58 01 00 77 01 09 05 03 09 D......X..w.....
000700: 80 01 01 00 00 07 25 01 01 01 DC 05 09 04 01 03 ......%.........
000710: 01 01 02 00 00 07 24 01 01 01 01 20 26 24 02 03 ......$.... &$..
000720: 02 02 10 0A 40 1F 00 11 2B 00 E0 2E 00 22 56 00 ....@...+...."V.
000730: C0 5D 00 00 7D 00 44 AC 00 80 BB 00 88 58 01 00 .]..}.D......X..
000740: 77 01 09 05 03 09 80 01 01 00 00 07 25 01 01 01 w...........%...
000750: DC 05_12 01 00 01 FE 01 00 08 63 07 FF FF 01 01 ..........c.....
000760: 01 02 00 01 09 02 19 00 01 01 00 40 00 09 04 02 ...........@....
000770: 00 00 FE 01 00 00 07 21 05 FF FF 20 00 04 03 09 .......!... ....
000780: 04 10 03 4D 00 2D 00 41 00 75 00 64 00 69 00 6F ...M.-.A.u.d.i.o
000790: 00 0E 03 53 00 6F 00 6E 00 69 00 63 00 61 00    ...S.o.n.i.c.a.


Now we need a DFU loader. The loader at http://at76c503a.sourceforge.net/
looks promising. I think I'll be able to munge it into a generic DFU
loader.


HTH
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390

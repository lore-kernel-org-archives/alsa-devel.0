From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [CFT][patch] OPL3 stuff
Date: Wed, 14 Aug 2002 18:01:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D5A7EE4.8EF6F0CF@ladisch.de>
References: <Pine.LNX.4.05.10208141702260.2786-101000@pulsar.kss-loka.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Uros Bizjak <uros@kss-loka.si>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Uros Bizjak wrote:
> This patch is a rework of OPL3 chip detection (again...):
> 
> - detects OPL4 with by-the-book procedure. FM registers can not be
> read in OPL4 mode (look at page 8 of OPL4 documentation)

The registers can be read with my OPL4 chip.
The chip designers did not read the documentation. :-)

> Mostly trivial stuff, but OPL3-L and OPL4 detection is untested as
> I don't have the hardware. Could anybody test it?

+	/* OPL4 outputs 0x02 in status register after NEW2 bit is set */
+	signature = inb(opl3->l_port);  /* Status register */
+	if (signature == 0x02) {

This only works the first time after a cold boot.
I think my old code has a better chance of working reliably.

The OPL4 detection doesn't really matter as long as we don't have an
OPL4 driver. That one would look at the OPL4 registers to detect it.
(The Yamaha drivers test whether all 8 bits of PCM registers F8/F9
are R/W. This is undocumented for the upper 2 bits. :-)
We cannot do this in the OPL3 driver without grabbing the OPL4 port
addresses.

I have source code for an OPL4 wavetable driver for NT, but didn't yet
have enough time to port it to ALSA. Anybody interested?

> OPL4 documents can be found at:
> http://www.kss-loka.si/~uros/opl4.pdf (application manual)

My copy (at <http://www.informatik.uni-halle.de/~ladischc/opl4.pdf>)
has the same contents, but smaller file size. Different compression?


Clemens


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31

From: jean@schurger.org
Subject: Bugged ES1978 Maestro 2E (rev 10) ? make it works
Date: Tue, 10 Aug 2004 12:38:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040810103809.GB6622@schurger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
	I have an (old) laptop with an ESS Technology ES1978 Maestro 2E
	(rev 10), that seems to have an "STAC9721/23" inside (id =
	0x83847609).

	0000:00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro
	2E (rev 10)
	Subsystem: Dell: Unknown device 00aa
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d800 [size=256]
	Capabilities: [c0] Power Management
	version 2

	in the snd_ac97_mixer() function,  the ac97 driver test the
	AC97_REC_GAIN register by writing 0x8a06 on it, and if it read
	well the same value, it enable the AC97_SCAP_AUDIO.

	But, on my board, the last quartet of AC97_REC_GAIN, is always
	readen as 0, then when the AC97_REC_GAIN is tested, it return
	0x0a06 instead of 0x8a06, and the ac97 driver tell "(not audio
	or modem codec)", then no sound card.

	I simply added a test of 0x83847609 to |= 0x8000 to the test
	value, and all works fine.


--
	Jean Schurger <jean@schurger.org>


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285

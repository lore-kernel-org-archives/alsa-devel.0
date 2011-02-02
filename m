From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH] EDB93xx: Add support for CS4271 CODEC on EDB93xx boards
Date: Wed, 2 Feb 2011 11:48:01 -0600
Message-ID: <0D753D10438DA54287A00B027084269764CEFD473E@AUSP01VMBX24.collaborationhost.net>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
	<20110202104943.GN12743@opensource.wolfsonmicro.com>
	<1296645167.1504.31.camel@r60e>
	<20110202125327.GO12743@opensource.wolfsonmicro.com>
	<1296653211.1504.40.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEFD45C8@AUSP01VMBX24.collaborationhost.net>
	<20110202165959.GT12743@opensource.wolfsonmicro.com>
	<1296667999.1504.44.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1296667999.1504.44.camel@r60e>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexander Sverdlin <subaparts@yandex.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lennert Buytenhek <buytenh@wantstofly.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday, February 02, 2011 10:33 AM, Alexander Sverdlin wrote:
> It's a chip select. The way I've managed it in CODEC it's because Cirrus
> boards do not have any other SPI devices. Supported by current mainline,
> at least.

All the EDB93xx boards also have an spi flash device.  And there are a
couple drivers in mainline that can be used.  Depending on the actual spi
flash device: drivers/mtd/m25p80.c, drivers/mtd/sst25l.c, or 
/drivers/misc/eeprom/at25.c.

There are a couple patches floating around to add the spi flash support
to the edb93xx platform init but nothing is merged yet.

BTW, you really should remove the or-gate's that Cirrus used with the spi
chip-selects to logically-and the SFRM and GPIO signals.  The SFRM signal
deasserts when the spi fifo's empty which could cause a chip-select 
deassertion to the chip in the middle of a transfer.  For the spi flash,
this breaks any read's from the device.  Just connect the gpio line
directly to the chip-select of the device.

Regards,
Hartley

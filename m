From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH] EDB93xx: Add support for CS4271 CODEC on EDB93xx boards
Date: Wed, 2 Feb 2011 11:21:40 -0600
Message-ID: <0D753D10438DA54287A00B027084269764CEFD4693@AUSP01VMBX24.collaborationhost.net>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
	<20110202104943.GN12743@opensource.wolfsonmicro.com>
	<1296645167.1504.31.camel@r60e>
	<20110202125327.GO12743@opensource.wolfsonmicro.com>
	<1296653211.1504.40.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEFD45C8@AUSP01VMBX24.collaborationhost.net>
	<20110202165959.GT12743@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110202165959.GT12743@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexander Sverdlin <subaparts@yandex.ru>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lennert Buytenhek <buytenh@wantstofly.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday, February 02, 2011 10:00 AM, Mark Brown wrote:
> On Wed, Feb 02, 2011 at 10:53:15AM -0600, H Hartley Sweeten wrote:
>> I don't have any problem with leaving the reset management in the codec.
>> The enable (chip-select) should be handled in the platform code.  But,
>> gpio_disable should be removed from struct cs4271_platform_data to avoid
>> any confusion.
>
> Is that really a chip select or is it a power control?

>From the datasheet:

Pin Name   #  Pin Description
--------  --  ----------------------------------------------------------
AD0/nCS   13  Address Bit 0 (I2S)/Control Port Chip Select (SPI) (Input)
              - AD0 is a chip address pin in I2C mode; nCS is the chip
              signal select for SPI format.

The other pin in question:

Pin Name   #  Pin Description
--------  --  ----------------------------------------------------------
nRST      14  Reset (Input) - The device enters a low power mode when
              this pin is driven low.

Regards,
Hartley

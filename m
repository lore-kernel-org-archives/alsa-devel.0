From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: new alsa driver for ti omap chip
Date: Thu, 12 Feb 2004 13:00:42 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402121256460.1962@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA09F28EC5@DBDE01>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <F509E6111989D311B63700805FA761DA09F28EC5@DBDE01>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Gupta, Kshitij" <kshitij@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Feb 2004, Gupta, Kshitij wrote:

> hi,
> 
> 	yeah that's true I2S has not much to with the driver.  So there is
> one more component on the chip called McBSP(Multichannel Buffered serial
> port) which will actually communicate to the codec chip over I2S protocol.
> And the DMA can read data from the McBSP recieve and transmit buffers. But
> still the driver has to do the McBSP configuration. 
> The kind of functionality the driver should provide is 
> 
> - Codec Control
> 	xxx_codec_write
> 	xxx_codec_read
> for reading and writing to the codec control bits.  This will be done via
> SPI interface.

So, look to alsa-kernel/i2c directory for examples, how to write a library 
for such codecs. We prefer to create a library than controlling codecs in
the toplevel driver, because we can reuse code later.

> - Dma Control functions
> 	start_dma
> 	queue_dma
> 	stop_dma ...

Exactly. In this case, you may look to any ISA/PCI drivers what the 
callbacks from midlevel do.

If you have a specific question, we are here ;-)

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: new alsa driver for ti omap chip
Date: Thu, 12 Feb 2004 12:22:31 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402121217270.1962@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA09F28EC1@DBDE01>
 <s5h65eca7jw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65eca7jw.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Gupta, Kshitij" <kshitij@ti.com>, "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Feb 2004, Takashi Iwai wrote:

> At Thu, 12 Feb 2004 12:56:04 +0530,
> Gupta, Kshitij wrote:
> > 
> > hi,
> > 
> > 	I am trying to write an alsa driver for a tsc2101 codec on a arm
> > based SOC.  The control interface between the SOC and the tsc2101 codec is
> > via SPI. 
> > And the data interface is a I2S interface.  Can some one suggest a good
> > starting point to start such a driver.  
> 
> some ALSA drivers use their own i2c functions, although there is a
> generic i2c layer on linux kernel.  for example, delta.c or ews.c of
> ice1712 driver use i2c (SPI) transfer (which calls ak4xxx-adda.c).
> but it's rather complex to refer...
> 
> the i2c transfer is really easy to implement.  do just like the spec
> says.  a pseudo code is like below.
> 
> 	chip_select_low();
> 	udelay(1);
> 
> 	for (i = 15; i >= 0; i--) {
> 		set_bit_clock(0);
> 		udelay(1);
> 		if (value_to_send & (1 << i))
> 			set_bit_data(1);
> 		else
> 			set_bit_data(0);
> 		udelay(1);
> 		set_bit_clock(0);
> 		udelay(1);
> 	}
> 
> 	chip_select_high();

Note that I2S is not I2C. I2S is used to connect A/D and D/A converters 
(three wires - clock, l/r word and sample bit). We don't talk directly 
with any device over this serial bus.

I think that the driver must be written for a sound bridge between host
and the converters. In case of ARM platform, it's usually an integrated
serial controller which can do DMA transfers.

So, this I2S question is a bit irrelevant (it's for hardware designers, 
but not for driver developers).

Because I don't know the behaviour of the sound / serial bridge, I cannot 
suggest a driver, but if it's similar as ARM1100 architecture, then we 
have already a driver for it.

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

From: "Peter Antypas" <peter@joyfaktory.com>
Subject: Re: Attempts on the ESS-1869 card
Date: Wed, 25 Feb 2004 22:07:57 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000901c3fc26$81612510$6601a8c0@peterlaptop>
References: <20040226045441.11593.qmail@web60804.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


> IRQ 5
> DMA 1
> DMA 5
> ports at 0x0220 thru 0x022F   (16 ports)
> ports at 0x0388 thru 0x038B   (4 ports)
> ports at 0x0330 thru 0x0331   (2 ports)
> some other port range at 0x0250 thru 0x0257   (8 ports).
> 
> In reading the driver I see that "port" reserves 16, "fm_port" reserves
> 4, and "mpu_port" reserves 2.
> 
> Being a "nice guy" I attempt to load the module with insmod, and the
> file "modules.conf" has:
> ...
> alias snd-card-0 snd-es18xx
> options snd-es18xx id="first" enable=1 dma1=1 dma2=5 irq=5 port=0x220 \
>    fm_port=0x338 mpu_port=0x330

Is that a misspelling ? 0x388 vs 0x338???




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

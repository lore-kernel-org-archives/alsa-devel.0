From: Pavel Roskin <proski@gnu.org>
Subject: Re: integration of via668 and via8233 drivers
Date: Thu, 5 Sep 2002 03:53:00 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209050346170.24048-100000@portland.hansa.lan>
References: <s5hofbd6dex.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hofbd6dex.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

> right now I committed the changes for VIA chip drivers to cvs.
> 
> now via686 and via8233 drivers are merged into a unified driver,
> via82xx.  this supports both VIA686 and VIA8233 south bridges.
> the supported functions are identical with older drivers.
> so it's nothing but a merge of two modules into one.
> 
> i've tested it shortly on my via686 chip, and confirmed to work.
> but on via8233 it's not tested much.

Actually, I have via686, and it used to work with the CVS version a few
months ago.  I tried it a week ago and it didn't work (it produced wrong
sounds).  We'll see if your integration fixed it.  If it didn't I'll do a 
binary search.

Right now, I have unresolved symbols with the CVS version:

# depmod -ae
depmod: *** Unresolved symbols in 
/lib/modules/2.4.20-pre5/kernel/sound/pci/snd-via82xx.o
depmod:         snd_mpu401_uart_new_R84d07db1
depmod:         snd_mpu401_uart_interrupt_R4ea4dc60
depmod:         snd_ac97_set_rate_Rae15d98c
depmod:         snd_ac97_mixer_Rb0b86cda

snd-mpu401.o and snd-mpu401-uart.o are not compiled and not installed.  
The configure options are:

--without-sequencer --with-oss --without-isapnp --with-cards=via82xx

Looks like a configuration problem to me.  --with-cards=via82xx should
enable the mpu401 and ac97 modules if the symbols from them are used in
the driver.

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390

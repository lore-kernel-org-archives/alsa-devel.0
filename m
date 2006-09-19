From: Julian Scheel <julian@jusst.de>
Subject: Re: ice1724/Audiotrak Prodigy 7.1 HiFi
Date: Tue, 19 Sep 2006 11:40:17 +0200
Message-ID: <200609191140.18077.julian@jusst.de>
References: <200609152111.03266.julian@jusst.de> <s5hlkogw6ip.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hlkogw6ip.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 19. September 2006 11:27 schrieb Takashi Iwai:
> At Fri, 15 Sep 2006 21:11:03 +0200,
> First you should make clear whether the codec chip is connected via
> the vt1724's standard connection or 3-wired SPI connection via GPIO.
> The most boards use the latter method while pontis board uses the
> former.  In the latter case, the address is usually 2 bit, so you can
> do a wild guess more easily.

I figured out that the WM8766 is connected through a 3-wired SPI-connection. I 
also figured out that the GPIOs 16,17,18 are used.
pontis.c already includes a SPI-implementation, but according to the WM8766 
specs (look at wolfsonmico.com) this device does not await an address, but 
only 2 bytes of data: register address/values.
Actually trying to initializing the chip leads to silence, in comparison to 
the noise coming out before, when the chip was in default mode.
I assume that there must be some timing problem with the data-transmission or 
similiar. I will do some more testing today.
Maybe I'll send in a patch if I can't find a problem, anyway.

-Julian

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV

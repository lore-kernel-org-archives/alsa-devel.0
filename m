From: Domen Puncer <domen@coderock.org>
Subject: Re: snd_mpu401_uart: hang when trying to play .mid
Date: Mon, 6 Sep 2004 17:48:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040906154819.GA7901@nd47.coderock.org>
References: <20040905092234.GA3605@masina.coderock.org> <s5h656rwhmh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h656rwhmh.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 06/09/04 17:18 +0200, Takashi Iwai wrote:
> At Sun, 5 Sep 2004 11:22:35 +0200,
> Domen Puncer wrote:
> > 
> > Hi.
> > 
> > "hang" here means: not even alt+sysrq+p responds
> > 
> > I tried to play some .mid files with kmid, I wouldn't be suprised if
> > it didn't work, but it *hanged* the computer!
> > 
> > 2 messages appeared on console (retyped):
> > cmd: 0xff failed at 0x20 (status = 0x50, data = 0x0)
> > cmd: 0x3f failed at 0x20 (status = 0x3f, data = 0x3)
> > 
> > These messages come from mpu401_uart.c:snd_mpu401_uart_cmd
> > It seems like commands MPU401_RESET and MPU401_ENTER_UART fail,
> > but code continues, ignoring that.
> > 
> > At this point it might be clear to alsa developers why/when hang
> > occours, if not I'll provide more data next weekend.
> 
> Does your hardware really a MPU401 device?

I don't know, probably not.

> If not, you can remove the call of snd_mpu401_uart_new() in
> snd_trident_probe().

Or just never start kmid again :-)
My point is: user can hang the computer; this is a bug.

> 
> Takashi


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click

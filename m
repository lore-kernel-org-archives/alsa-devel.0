From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] MPU-401 fixes
Date: Wed, 07 May 2003 10:31:46 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305071010500.25787-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.44.0305070956200.7448-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.44.0305070956200.7448-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 6 May 2003, Takashi Iwai wrote:
> > > Ok, I'm now using the spin_trylock check in the trigger function and
> > > RX_LOOP and TX_LOOP protectors are removed now. Hopefully, it finally
> > > solves our problem.
> >
> > i'm afraid no.  as mentioned before, we need to consider to avoid two
> > things:
> >
> > 1. (infinite) recursive call of trigger() (via input_read())
> > 2. double spinlocks around input_read() from irq handler and
> >    the suceeding call of trigger()
> >
> > introducing spin_trylock() solves the case #2 but not case #1,
> > since spin_trylock() always returns 1 on UP.
> > for #1, an extra (formerly RX_LOOP bit) flag is still necessary.
>
> I see. So the protectors are back in trigger() callbacks.

Now the recursive call sequence describe by Takashi is still possible:

>	irq
>	-> snd_mpu401_uart_interrupt()
>	-> lock
>	-> snd_mpu401_uart_input_read()
>		-> snd_rawmidi_receive()
>			-> rawmidi->event()
>				-> rawmidi->trigger() (in seq_midi.c)
>					-> snd_mpu401_uart_input_trigger()

... so the interrupt probably should set the bit, too. OTOH the recursion
isn't infinite anymore, so the current code really doesn't need any more
fixing.


Regards,
Clemens




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

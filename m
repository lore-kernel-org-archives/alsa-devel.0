From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] MPU-401 fixes
Date: Tue, 6 May 2003 17:09:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305061704230.7448-100000@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0305051715000.3930-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0305051715000.3930-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 5 May 2003, Clemens Ladisch wrote:

> Takashi Iwai wrote:
> > Clemens Ladisch wrote:
> > > Jaroslav Kysela wrote:
> > > > On Mon, 5 May 2003, Clemens Ladisch wrote:
> > > >
> > > > > - fix deadlock: when snd_mpu401_uart_input_trigger() is interrupted
> > > > >   immediately after the call to spin_unlock_irqrestore(), the interrupt
> > > > >   handler won't clear the interrupt condition because the RX_LOOP bit is
> > > > >   still set
> > > >
> > > > Thanks. The RX_LOOP bit is cleared before unlock now.
> > >
> > > The same thing will happen when the interrupt occurs immediately before
> > > the call to spin_lock_irqsave().
> > >
> > > The real problem is that the interrupt handler _must_ read the data from
> > > the device to clear the MPU401's interrupt condition. Therefore, there
> > > must not be any condition which can prevent the handler from reading data.
> >
> > hmm, this problem is not easy to solve.
> >
> > originally, the bit check was introduced to prevent double spinlocks
> > in the path:
> >
> > 	irq
> > 	-> snd_mpu401_uart_interrupt()
> > 	-> lock
> > 	-> snd_mpu401_uart_input_read()
> > 		-> snd_rawmidi_receive()
> > 			-> rawmidi->event()
> > 				-> rawmidi->trigger() (in seq_midi.c)
> > 					-> snd_mpu401_uart_input_trigger()
> 
> AFAICS the only protection needed is against a recursive call of
> _input_trigger() but not of _interrupt() because the interrupt routine
> cannot be called inside the spin_lock_irqsave(), i.e., the code being
> interrupted will not be the _input_read() function.

It's not true on MP. The interrupt handler can be run on different CPU 
than trigger.

> So a solution would be that _interrupt() sets the RX_LOOP bit, but does
> _not_ check it. But then RX_LOOP can be set twice, so we'd need an
> atomic_t counter instead.

Ok, I'm now using the spin_trylock check in the trigger function and 
RX_LOOP and TX_LOOP protectors are removed now. Hopefully, it finally 
solves our problem.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

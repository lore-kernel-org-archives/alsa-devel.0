From: "Bill Adair" <adair@gotadsl.co.uk>
Subject: Bug in serial-u16550.c
Date: Thu, 24 Feb 2005 10:30:15 -0000
Message-ID: <opsmo54p0sn0kn27@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

There is a bug in serial-u16550.c that has been causing my PC to lock up =
=20
solid. The three chunks of code
should explain the nature of it. Basically a lock is taken out on =20
interrupt and is still held on calling
snd_rawmidi_receive (). snd_rawmidi_receive () eventually calls back into=
 =20
the driver code at snd_uart16550_input_trigger ()
where an attempt is made to take out the same lock again. Other pieces of=
 =20
code using the same construction avoid
this problem by unlocking before calling snd_rawmidi_receive () and =20
relocking e.g. mtpav.c - though this does
not seem a good solution ;-).

The bug would only affect users who receive data from their MIDI =20
interfaces.

So two questions -

Do you want a patch for this? In the Opcode driver I've been writing
based on this I've checked to see if the kernel is in an interrupt using =
=20
the in_interrupt ()
call before locking or unlocking in snd_uart16550_input_trigger ().

Can anyone describe the function of the up parameter passed to =20
snd_uart16550_input_trigger ()?
Should I be using this to determine if the call came from an interrupt?

static irqreturn_t snd_uart16550_interrupt(int irq, void *dev_id, struct =
=20
pt_regs *regs)
{
         snd_uart16550_t *uart;

         uart =3D (snd_uart16550_t *) dev_id;
         spin_lock(&uart->open_lock);
         if (uart->filemode =3D=3D SERIAL_MODE_NOT_OPENED) {
                 spin_unlock(&uart->open_lock);
                 return IRQ_NONE;
         }
         inb(uart->base + UART_IIR);             /* indicate to the UART =
=20
that the interrupt has been serviced */
         snd_uart16550_io_loop(uart);
         spin_unlock(&uart->open_lock);
         return IRQ_HANDLED;
}

static void snd_uart16550_io_loop(snd_uart16550_t * uart)
{
		// deleted stuff here...
		/* Read Loop */
		while ((status =3D inb(uart->base + UART_LSR)) & UART_LSR_DR) {
			/* while receive data ready */
			c =3D inb(uart->base + UART_RX);

			// deleted stuff here...
			snd_rawmidi_receive(uart->midi_input[substream], &c, 1);              =
  =20
}

			// deleted stuff here...
		}

		// deleted stuff here...
}

static void snd_uart16550_input_trigger(snd_rawmidi_substream_t * =20
substream, int up)
{
         unsigned long flags;
         snd_uart16550_t *uart =3D substream->rmidi->private_data;

         spin_lock_irqsave(&uart->open_lock, flags);
         if (up) {
                 uart->filemode |=3D SERIAL_MODE_INPUT_TRIGGERED;
         } else {
                 uart->filemode &=3D ~SERIAL_MODE_INPUT_TRIGGERED;
         }
         spin_unlock_irqrestore(&uart->open_lock, flags);
}


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

From: "Bill Adair" <adair@gotadsl.co.uk>
Subject: snd_serial_u16550 lockup
Date: Mon, 17 Jan 2005 13:22:01 -0000
Message-ID: <opskq0qzkmn0kn27@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I'm writing a driver based on this code for an Opcode 64X serial MIDI =20
interface.
It's working for output using rosegarden and for input using amidi.
However when I set record on my device in Rosegarden (and other sequencer=
 =20
packages
jazz and Muse) the whole (twin CPU) pc locks solid and I have to press =20
reset.
This happens only if my synth is turned on i.e. a stream of 'FE' midi byt=
es
are being delivered to the interface and then my driver software.

I have altered the code so it doens't call snd_rawmidi_receive at which =20
point my
driver software runs happily receiving and acknowledging bytes from the =20
interface.

The locking sequence runs.

static irqreturn_t snd_uart16550_interrupt (int irq, void *dev_id, struct=
 =20
pt_regs *regs)
{
         snd_uart16550_t *uart;
         unsigned char c;

         uart =3D (snd_uart16550_t *) dev_id;
         spin_lock (&uart->open_lock);
         if (uart->filemode =3D=3D SERIAL_MODE_NOT_OPENED) {
                 spin_unlock (&uart->open_lock);
                 return (IRQ_NONE);
         }
         c =3D inb (uart->base + UART_IIR);
         snd_uart16550_io_loop (uart);
         spin_unlock (&uart->open_lock);
         return (IRQ_HANDLED);
}

static void snd_uart16550_io_loop(snd_uart16550_t *uart)
{
         if (uart->F5_received) {
			// switch streams
                   uart->F5_received =3D FALSE;
         }
         else {
                   if (uart->filemode & SERIAL_MODE_INPUT_OPEN
                   &&  uart->midi_input[substream] !=3D NULL) {
                         snd_rawmidi_receive (uart->midi_input[substream]=
, =20
&c, 1);
                   }
         }
}

int snd_rawmidi_receive(snd_rawmidi_substream_t * substream, const =20
unsigned char *buffer, int count)
{
         unsigned long flags;
         int result =3D 0, count1;
         snd_rawmidi_runtime_t *runtime =3D substream->runtime;

         if (runtime->buffer =3D=3D NULL) {
                 snd_printd("snd_rawmidi_receive: input is not =20
active!!!\n");
                 return -EINVAL;
         }
         spin_lock_irqsave(&runtime->lock, flags);
         if (count =3D=3D 1) {       /* special case, faster code */
                 substream->bytes++;
                 if (runtime->avail < runtime->buffer_size) {
                         runtime->buffer[runtime->hw_ptr++] =3D buffer[0]=
;
                         runtime->hw_ptr %=3D runtime->buffer_size;
                         runtime->avail++;
                         result++;
                 } else {
                         runtime->xruns++;
                 }
	  }
         if (result > 0 && runtime->event =3D=3D NULL) {
                 if (snd_rawmidi_ready(substream))
                         wake_up(&runtime->sleep);
         }
         spin_unlock_irqrestore(&runtime->lock, flags);
         if (result > 0 && runtime->event)
                 runtime->event(substream);
         return result;
}


I'm assuming there is no way that the runtine lock and the uart lock are =
=20
the same but that
I'm spinning against the runtime lock. Anyone got any ideas? Is it =20
possible that Rosegarden
holds a lock on the ALSA runtime object at all times if output is open an=
d =20
amidi only ever
works in one direction (i.e. input or output)?

TIA
Bill
--=20
Using Opera's revolutionary e-mail client: http://www.opera.com/m2/


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

From: "Bill Adair" <adair@gotadsl.co.uk>
Subject: New driver for Opcode 64X Serial MIDI interfaces
Date: Thu, 24 Feb 2005 10:57:55 -0000
Message-ID: <opsmo7etnqn0kn27@linux.site>
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

I have nearly completed my driver - I have only to add support for a =20
couple of units (the 128X and 64XTC)
for which I have the specification but not any hardware. My question is =20
how (or where) should I add it to
the alsa code. The current code is integrated into serial-u16550.c but I =
=20
have made changes to the basic code
to improve clarity and increase the level of documentation. I have also =20
written doxygen based comments for the
new and original code. As an example below is a section of the original =20
and my new version...

Do you want me to (a) provide a replacement file for serial-u16550.c, (b)=
 =20
provide a version of serial-u16550.c
with comment documentation in but no Opcode driver and a seperate Opcode =
=20
driver file, or (c) provide just a
comment documented Opcode driver and leave serial-u16650.c alone? Note =20
there is a bug in the current
serial-u16550.c as explained in another post.

/* This loop should be called with interrupts disabled
  * We don't want to interrupt this,
  * as we're already handling an interrupt
  */
static void snd_uart16550_io_loop(snd_uart16550_t * uart)
{
         unsigned char c, status;
         int substream;

         /* recall previous stream */
         substream =3D uart->prev_in;

         /* Read Loop */
         while ((status =3D inb(uart->base + UART_LSR)) & UART_LSR_DR) {
                 /* while receive data ready */
                 c =3D inb(uart->base + UART_RX);

                 /* keep track of last status byte */
                 if (c & 0x80) {
                         uart->rstatus =3D c;
                 }

                 /* handle stream switch */
                 if (uart->adaptor =3D=3D SNDRV_SERIAL_GENERIC) {
                         if (uart->rstatus =3D=3D 0xf5) {
                                 if (c <=3D SNDRV_SERIAL_MAX_INS && c > 0=
)
                                         substream =3D c - 1;
                                 if (c !=3D 0xf5)
                                         uart->rstatus =3D 0; /* prevent =
=20
future bytes from being interpreted as streams */
                         }
                         else if ((uart->filemode & SERIAL_MODE_INPUT_OPE=
N) =20
&& (uart->midi_input[substream] !=3D NULL)) {
                                 snd_rawmidi_receive(uart->midi_input[sub=
stream], =20
&c, 1);
                 }
                 } else if ((uart->filemode & SERIAL_MODE_INPUT_OPEN) && =
=20
(uart->midi_input[substream] !=3D NULL)) {
                         snd_rawmidi_receive(uart->midi_input[substream],=
 =20
&c, 1);
                 }

                 if (status & UART_LSR_OE)
                         snd_printk("%s: Overrun on device at 0x%lx\n",
                                uart->rmidi->name, uart->base);
         }

         /* remember the last stream */
         uart->prev_in =3D substream;

etc... etc...

/**
  * \brief Reads bytes from hardware to Uart structure
  * \param uart Uart handle
  * \return none
  *
  * This loop should be called with interrupts disabled.
  * We don't want to interrupt this, as we're already handling an interru=
pt
  * This is where the processing of interrupts is done. Any interrupt fro=
m
  * the hardware will end up in here. Incoming bytes from the hardware ar=
e
  * passed into ALSA using the snd_rawmidi_receive() call.
  *
  * - UART_LSR - the 16550 Line Status Register.
  * - UART_LSR_DR - the 16550 UART_LSR Data Ready.
  * - UART_LSR_OE - the 16550 UART_LSR Overrun Error.
  * - UART_RX - the 16550 Receive Buffer.
  * - UART_LSR_THRE - the 16550 UART_LSR Transmitter Holding Register Emp=
ty.
  * - UART_MSR - the 16550 Modem Status Register.
  * - UART_MSR_CTS - the 16550 UART_MSR Clear To Send.
  *
  * If an F5 is received at the input then stream switching is performed.
  * The next byte read is used as the stream number to switch to. The cod=
e
  * layout is confusing as when the F5 character is received then control
  * continues to get the next byte. If the next byte is not a valid strea=
m
  * number it is discarded and F5_received will be set to FALSE. This
  * wouldn't work with - say - SYSEX containing F5s but SYSEX is defined =
as
  * only containing values up to 7F between it's heading F0 and trailing =
F7.
  */
static void snd_uart16550_input_loop(snd_uart16550_t *uart)
{
         unsigned char c, status;
         int substream;
         int bytes_read =3D 0;

         substream =3D uart->prev_in;      /* recall previous stream */

//      snd_printk (KERN_ERR "Opcode 64X in input_loop\n");

         while ((status =3D inb (uart->base + UART_LSR)) & UART_LSR_DR
         &&     bytes_read <=3D SNDRV_SERIAL_OPCODE_PACKET_SIZE) {
                 if (status & UART_LSR_OE)
                         snd_printk ("%s: Overrun on device at 0x%lx\n", =
=20
uart->rmidi->name, uart->base);
                 c =3D inb (uart->base + UART_RX);
                 switch (uart->adaptor) {
                 case SNDRV_SERIAL_OPCODE_64X:
                         uart->opcode64x_rts_toggle_count++;
                         if (uart->opcode64x_rts_toggle_count =3D=3D 16)
                                 snd_uart16550_opcode64x_rtssignal (uart)=
;
                         break;
                 default:
                         break;
                 }
//              snd_printk (KERN_ERR "Opcode 64X in byte %x\n", c);
                 if (c =3D=3D 0xf5) {
                         switch (uart->adaptor) {
                         case SNDRV_SERIAL_GENERIC:
                         case SNDRV_SERIAL_OPCODE_64X:
                                 uart->F5_received =3D TRUE;
                                 continue;
                                 break;
                         default:
                                 break;
                         }
                 }
                 if (uart->F5_received) {
                         switch (uart->adaptor) {
                         case SNDRV_SERIAL_GENERIC:
                         case SNDRV_SERIAL_OPCODE_64X:
                                 if (c <=3D SNDRV_SERIAL_MAX_INS && c > 0=
) {
                                         substream =3D c - 1;
//                                      snd_printk (KERN_ERR "Opcode 64X =
=20
stream change %d\n", substream);
                                 }
                                 uart->F5_received =3D FALSE;
                                 continue;
                                 break;
                         default:
                                 break;
                         }
                 }
//              snd_printk (KERN_ERR "Opcode 64X in stream %x ptr %x\n", =
=20
substream, uart->midi_input[substream]);
//              snd_printk (KERN_ERR "Opcode 64X in filemode %x\n", =20
uart->filemode);
                 if (uart->filemode & SERIAL_MODE_INPUT_OPEN
                 &&  uart->midi_input[substream] !=3D NULL) {

                         int res =3D 0;

//                      snd_printk (KERN_ERR "Opcode 64X =20
snd_rawmidi_receive %x substream %d\n", c, substream);
                         res =3D snd_rawmidi_receive =20
(uart->midi_input[substream], &c, 1);
//                      snd_printk (KERN_ERR "Opcode 64X result %d\n", =20
res);
                 }
                 bytes_read++;
         }
         uart->prev_in =3D substream;      /* remember the last stream */
}


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

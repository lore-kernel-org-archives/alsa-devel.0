From: "Bill Adair" <adair@gotadsl.co.uk>
Subject: Serial port MIDI devices - Opcode Studio 64X
Date: Tue, 07 Dec 2004 17:20:10 -0000
Message-ID: <opsinefwk1n0kn27@biotracedesign.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
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

I'm about to have a look at developing an ALSA serial port driver
for the Opcode Studio 64X. Does anyone else have an interest in this
device, or similar hardware?

The Roland Sound Canvas and Midiator devices seem to be similar to the
specification I have. There are four stages Detection, Sign-On, =20
MIDI-Transfer
and Sign-Off. The interface toggles the CTS and the PC responds on RTS =20
during
detection and then the two lines are used during MIDI-Transfer to prevent=
 =20
buffer
overflow.

Where would be the best place to add this code? I'm a little confused by =
=20
the
way all the functionality is laid out. The following is a list of routine=
s =20
 from the
serial-u16650.c file. Is there a guide anywhere that says which routines =
=20
are called by
ALSA to "do" operations i.e. if I want to detect my hardware I need check=
 =20
a port
for response. Which routine should this be done in? Is this triggered by =
=20
loading a driver?
etc.

snd_uart16550_add_timer()
snd_uart16550_del_timer()
snd_uart16550_buffer_output()
snd_uart16550_io_loop()
snd_uart16550_interrupt()
snd_uart16550_buffer_timer()
snd_uart16550_detect()
snd_uart16550_do_open()
snd_uart16550_do_close()
snd_uart16550_input_open()
snd_uart16550_input_close()
snd_uart16550_input_trigger()
snd_uart16550_output_open()
snd_uart16550_output_close()
snd_uart16550_buffer_can_write()
snd_uart16550_write_buffer()
snd_uart16550_output_byte()
snd_uart16550_output_write()
snd_uart16550_output_trigger()
snd_rawmidi_ops_t snd_uart16550_output =3D
snd_rawmidi_ops_t snd_uart16550_input =3D
snd_uart16550_free()
snd_uart16550_dev_free()
snd_uart16550_create()
snd_uart16550_rmidi()
snd_serial_probe()
alsa_card_serial_init()
alsa_card_serial_exit()
module_init()
module_exit()

Bill


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/

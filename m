From: Darwin Marcus Johnson <schwaahed@yahoo.com>
Subject: Fwd: Midiator MS-124w w/ALSA0.9.0beta12
Date: Mon, 4 Mar 2002 08:34:58 -0500
Message-ID: <200203040834.58013.schwaahed@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org


Subject: Midiator MS-124w w/ALSA0.9.0beta12
Date: Sat, 2 Mar 2002 10:33:30 -0500
From: Darwin Marcus Johnson <schwaahed@yahoo.com>
To: alsa-user@lists.sourceforge.net
Cc: linux-audio-user@music.columbia.edu

Hi All,

I am trying to get my Midiator Midi interface working with ALSA0.9.0beta =
12.
 I am trying to insert the snd-serial-u16550 module. My /etc/modules.conf
 seems to have the right options for this card.

Does anyone have a Midiator Midi interface working with the ALSA support?

Does anyone have another serial interface working with the snd-serial-u16=
550
module?

Can anyone point me to any documentation on setting up the modules beside
the 1 page in the ALSA-HOWTO that contain this info below?

Does any of this info below have some obvious over sights, mistakes,=20
omissions?

-Thanks
Darwin

=46rom the ALSA-HOWTO:
----snip------------------------
snd_port        - port # for UART16550A chip
snd_irq - IRQ # for UART16550A chip, -1 =3D poll mode
snd_divisor     - divisor to calculate bit rate
=09=09=09115200bps / # - 3 =3D 38.4kbpsdefault
snd_ports       - number of MIDI ports 1,2,3,4 - 1 =3D default
----snip-----------------------

# modprobe snd-serial-u16550

I get these error messages:
----snip-----------------------
Note: /etc/modules.conf is more recent than
/lib/modules/2.4.18-rc1/modules.dep
/lib/modules/2.4.18-rc1/kernel/driver/sound/snd-serial-u16550.o: init_mod=
ule:
No such device
Hint: insmod errors can be caused by incorrect module parameters, includi=
ng
invalid IO or IRQ parameters
/lib/modules/2.4.18-rc1/kernel/driver/sound/snd-serial-u16550.o: insmod
/lib/modules/2.4.18-rc1/kernel/driver/sound/snd-serial-u16550.o failed
/lib/modules/2.4.18-rc1/kernel/driver/sound/snd-serial-u16550.o: insmod
snd-serial-u16550 failed
----snip-------------------------

# setserial -a /dev/ttyS0
/dev/ttyS0, Line 0, UART: 16550A, Port: 0x03f8, IRQ: 4
        Baud_base: 57600, close_delay: 50, divisor: 1
        closing_wait: 3000
        Flags: spd_normal skip_test

# cat /etc/modules.conf
----snip-------------------------
# ALSA native device support
alias char-major-116 snd
options snd snd_major=3D116 snd_cards_limit=3D2
alias snd-card-0 snd-cs46xx
alias snd-card-1 snd-serial-u16550
# snd-cs46xx Options
options snd-card cs46xx snd_index=3D0 snd_id=3D"CS46XX" \
        snd_dac_frame_size=3D128 snd_adc_frame_size=3D128

# snd-serial-u16550 Options
options snd-serial-u16550 snd_index=3D1 snd_id=3D"MidiatorMS124w" \
        snd_port=3D0x03f8 snd_irq=3D4 #snd_divisor=3D1 snd_ports=3D1
----snip-------------------------------




_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

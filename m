From: Clemens Ladisch <clemens@ladisch.de>
Subject: ES1938 MIDI input not working?
Date: Mon, 26 May 2003 18:28:52 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305261828210.26683-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have a report that, with an ES1938 card, MIDI (input only) doesn't =
work.
It looks as if MIDI interrupts aren't generated or acknowledged prope=
rly.

es9138.c has the following MIDI interrupt code:

=09/* MPU401 */
=09if (status & 0x80) {
=09=09// snd_es1938_mixer_bits(chip, ESSSB_IREG_MPU401CONTROL, 0x40, =
0); /* ack? */
=09=09if (chip->rmidi) {
=09=09=09handled =3D 1;
=09=09=09snd_mpu401_uart_interrupt(irq, chip->rmidi->private_data, re=
gs);
=09=09}
=09}

This was added in revision 1.6 of es1938.c, with the log message "not
tested well". In revision 1.22, the "ack?" line was commented out, wi=
thout
any relevant log message.

Has this code been tested? Does anybody know if it works, somewhere?


Regards,
Clemens



---------- Forwarded message ----------
Date: Mon, 26 May 2003 10:27:05 +0200
=46rom: Stefan Gruber <GruberLISCON@netscape.net>
Newsgroups: de.comp.os.unix.linux.misc, de.rec.musik.elektronisch
Subject: Re: MIDI: Ausgabe ja, Eingabe nein

(... cat /dev/midi00 ...)

> Wird dabei "Rx bytes" in /proc/asound/card0/midi0 hochgez=E4hlt?

Nein. "Rx bytes" bleibt permanent auf Null.

> Wird bei empfangenen MIDI-Bytes ein Interrupt generiert? (kann man =
in
> /proc/interrupts mitz=E4hlen)

Scheinbar kommt auch hier nichts. Auf welchem IRQ m=FCsste der denn k=
ommen?





-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge

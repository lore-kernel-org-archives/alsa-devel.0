From: Jean-Marc Desprez <jean-marc.desprez@wanadoo.fr>
Subject: serialmidi problem
Date: Sun, 22 Dec 2002 23:44:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E064032.329156C9@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------EC2D7760CDAC3C10A943737E"
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

This is a multi-part message in MIME format.
--------------EC2D7760CDAC3C10A943737E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hi everybody,

testing a serial midi synth (Yamaha QY70) with alsa-0.9.0rc6,
linux-2.4.18,
and pmidi-1.5.5, and I noticed that the first notes of score where
lost/jammed,
whereas the rest sounded ok

After a couple of printk in snd-serialmidi.o, it seems that
serialmidi::tx_loop
happens to be executed by 2 concurent threads, one on behalf of
the serial driver via its line discipline, the other called by
snd_serialmidi_output_trigger (I assume it has to do with applicative
snd_seq_drain_output). The preemption probably occurs in the write
function
of the tty driver

these concurent threads both peek the same block of data from rawmidi,
and write it to the tty driver (that could be not that serious
if the block matches exactly an atomic midi event: its is simply sent
twice,
for example the same note), but both as well ack the writing, removing
the sent
event and the next to send (even if it has not been submited yet!)

I fixed this problem with a coarse hack in tx_loop, calling
snd_rawmidi_transmit_ack BEFORE tty->driver.write (that is not that
risky,
as far as the upper layer (rawmidi) and the lower layer (tty driver)
already
agreed on count), but I think a spinlock or whatever kernel artefact
would be more appropriate to avoid concurency in the first place

I join 4 files:
- a midi file containing an arpeggio: C3/E3/G3/C4, 120bpm, each half
note
- a version of tx_loop crowded with printk
- a run of the arpeggio with pmidi, dumped from /var/log/messages
- a dump of the same run of pmidi, with the hack

best regards

--------------EC2D7760CDAC3C10A943737E
Content-Type: text/plain; charset=iso-8859-1;
 name="arpeggio.mid"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="arpeggio.mid"

MThd=00=00=00=06=00=01=00=01=06=C0MTrk=00=00=00Z=00=FF=01=01?=00=FFX=04=04=
=02=00=00=00=FFQ=03=07=A1 =00?<?=00=FF=01=01??=00?<=00=00?@?=00=FF=01=01?=
?=00=FF=01=01?=00?@=00=00?C?=00=FF=01=01??=00?C=00=00?H?=00=FF=01=01??=00=
=FF=01=01?=00?H=00=00=FF/=00
--------------EC2D7760CDAC3C10A943737E
Content-Type: text/plain; charset=us-ascii;
 name="tx_loop.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tx_loop.c"


static void tx_loop(serialmidi_t *serial)
{
	static int __nb__nb__ = 0;
	struct tty_struct *tty;
	char buf[64];
	int count;

	printk("%d: entry in tx_loop: serial %lx\n", __nb__nb__++, 
			(long)serial);

	tty = serial->tty;
	count = tty->driver.write_room(tty);
	while (count > 0) {
		printk("%d: write_room: %i\n", __nb__nb__++, count);
		count = count > sizeof(buf) ? sizeof(buf) : count;
		count = snd_rawmidi_transmit_peek(serial->substream_output, buf, count);
		printk("%d: peek: %i\n", __nb__nb__++, count);
		if (count > 0) {
#ifdef MY_HACK
			snd_rawmidi_transmit_ack(serial->substream_output, count);
#endif
			count = tty->driver.write(tty, 0, buf, count);
			printk("%d: tx_loop tty %lx: written: %i: ", 
					__nb__nb__++,
					(long)tty, count);
			{ int i; 
			  for (i = 0; i < count; i++) 
				printk("%.2x ", buf[i] & 0xff);
			  printk("\n");
			}
#ifndef MY_HACK
			snd_rawmidi_transmit_ack(serial->substream_output, count);
#endif
			count = tty->driver.write_room(tty);
		} else {
			clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
			break;
		}
	}
	printk("%d: exit from tx_loop\n", __nb__nb__++);
}


--------------EC2D7760CDAC3C10A943737E
Content-Type: text/plain; charset=us-ascii;
 name="messages_no_hack"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages_no_hack"

Dec 22 00:19:13 synprez kernel: snd_serialmidi_output_trigger: up=0
Dec 22 00:19:13 synprez kernel: snd_serialmidi_output_trigger: up=1
# first thread: ok
Dec 22 00:19:13 synprez kernel: 0: entry in tx_loop: serial cb150760
Dec 22 00:19:13 synprez kernel: 1: write_room: 4095
Dec 22 00:19:13 synprez kernel: 2: peek: 3
Dec 22 00:19:13 synprez kernel: ldisc_write_wakeup
# second thread, the same data are read from rawmidi: oops...
Dec 22 00:19:13 synprez kernel: 3: entry in tx_loop: serial cb150760
Dec 22 00:19:13 synprez kernel: 4: write_room: 4095
Dec 22 00:19:13 synprez kernel: 5: peek: 3
# legal  C3 on
Dec 22 00:19:13 synprez kernel: 6: tx_loop tty c9c39000: written: 3: 91 3c 3f 
Dec 22 00:19:13 synprez kernel: 7: write_room: 4092
Dec 22 00:19:13 synprez kernel: 8: peek: 0
# first exit, the second thread resumes
Dec 22 00:19:13 synprez kernel: 9: exit from tx_loop
# duplicate C3 on: the ear does not notice, because the note is simply stroke
# twice in the same millisec
Dec 22 00:19:13 synprez kernel: 10: tx_loop tty c9c39000: written: 3: 91 3c 3f 
Dec 22 00:19:13 synprez kernel: 11: write_room: 4092
Dec 22 00:19:13 synprez kernel: 12: peek: 0
# second exit
Dec 22 00:19:13 synprez kernel: 13: exit from tx_loop
# at this point, 6 bytes (thice the same 3) where played and acked
Dec 22 00:19:14 synprez kernel: snd_serialmidi_output_trigger: up=1
# here the C3 off should be sent, but is was lost, so the C3 key remains on
Dec 22 00:19:14 synprez kernel: 14: entry in tx_loop: serial cb150760
# from this point, every is ok
Dec 22 00:19:14 synprez kernel: 15: write_room: 4095
Dec 22 00:19:14 synprez kernel: 16: peek: 3
Dec 22 00:19:14 synprez kernel: 17: tx_loop tty c9c39000: written: 3: 91 40 3f 
Dec 22 00:19:14 synprez kernel: 18: write_room: 4095
Dec 22 00:19:14 synprez kernel: 19: peek: 0
Dec 22 00:19:14 synprez kernel: 20: exit from tx_loop
Dec 22 00:19:15 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:19:15 synprez kernel: 21: entry in tx_loop: serial cb150760
Dec 22 00:19:15 synprez kernel: 22: write_room: 4095
Dec 22 00:19:15 synprez kernel: 23: peek: 3
Dec 22 00:19:15 synprez kernel: 24: tx_loop tty c9c39000: written: 3: 81 40 00 
Dec 22 00:19:15 synprez kernel: 25: write_room: 4095
Dec 22 00:19:15 synprez kernel: 26: peek: 0
Dec 22 00:19:15 synprez kernel: 27: exit from tx_loop
Dec 22 00:19:15 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:19:15 synprez kernel: 28: entry in tx_loop: serial cb150760
Dec 22 00:19:15 synprez kernel: 29: write_room: 4095
Dec 22 00:19:15 synprez kernel: 30: peek: 3
Dec 22 00:19:15 synprez kernel: 31: tx_loop tty c9c39000: written: 3: 91 43 3f 
Dec 22 00:19:15 synprez kernel: 32: write_room: 4092
Dec 22 00:19:15 synprez kernel: 33: peek: 0
Dec 22 00:19:15 synprez kernel: 34: exit from tx_loop
Dec 22 00:19:16 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:19:16 synprez kernel: 35: entry in tx_loop: serial cb150760
Dec 22 00:19:16 synprez kernel: 36: write_room: 4095
Dec 22 00:19:16 synprez kernel: 37: peek: 3
Dec 22 00:19:16 synprez kernel: 38: tx_loop tty c9c39000: written: 3: 81 43 00 
Dec 22 00:19:16 synprez kernel: 39: write_room: 4095
Dec 22 00:19:16 synprez kernel: 40: peek: 0
Dec 22 00:19:16 synprez kernel: 41: exit from tx_loop
Dec 22 00:19:16 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:19:16 synprez kernel: 42: entry in tx_loop: serial cb150760
Dec 22 00:19:16 synprez kernel: 43: write_room: 4095
Dec 22 00:19:16 synprez kernel: 44: peek: 3
Dec 22 00:19:16 synprez kernel: 45: tx_loop tty c9c39000: written: 3: 91 48 3f 
Dec 22 00:19:16 synprez kernel: 46: write_room: 4092
Dec 22 00:19:16 synprez kernel: 47: peek: 0
Dec 22 00:19:16 synprez kernel: 48: exit from tx_loop
Dec 22 00:19:17 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:19:17 synprez kernel: 49: entry in tx_loop: serial cb150760
Dec 22 00:19:17 synprez kernel: 50: write_room: 4095
Dec 22 00:19:17 synprez kernel: 51: peek: 3
Dec 22 00:19:17 synprez kernel: 52: tx_loop tty c9c39000: written: 3: 81 48 00 
Dec 22 00:19:17 synprez kernel: 53: write_room: 4095
Dec 22 00:19:17 synprez kernel: 54: peek: 0
Dec 22 00:19:17 synprez kernel: 55: exit from tx_loop
Dec 22 00:19:19 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:19:19 synprez kernel: 56: entry in tx_loop: serial cb150760
Dec 22 00:19:19 synprez kernel: 57: write_room: 4095
Dec 22 00:19:19 synprez kernel: 58: peek: 1
Dec 22 00:19:19 synprez kernel: ldisc_write_wakeup
Dec 22 00:19:19 synprez kernel: 59: entry in tx_loop: serial cb150760
Dec 22 00:19:19 synprez kernel: 60: write_room: 4095
Dec 22 00:19:19 synprez kernel: 61: peek: 1
Dec 22 00:19:19 synprez kernel: 62: tx_loop tty c9c39000: written: 1: ff 
Dec 22 00:19:19 synprez kernel: 63: write_room: 4094
Dec 22 00:19:19 synprez kernel: 64: peek: 0
Dec 22 00:19:19 synprez kernel: 65: exit from tx_loop
Dec 22 00:19:19 synprez kernel: 66: tx_loop tty c9c39000: written: 1: ff 
Dec 22 00:19:19 synprez kernel: 67: write_room: 4094
Dec 22 00:19:19 synprez kernel: 68: peek: 0
Dec 22 00:19:19 synprez kernel: 69: exit from tx_loop
Dec 22 00:19:19 synprez kernel: snd_serialmidi_output_trigger: up=0
Dec 22 00:19:19 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:19:19 synprez kernel: 70: entry in tx_loop: serial cb150760
Dec 22 00:19:19 synprez kernel: 71: write_room: 4095
Dec 22 00:19:19 synprez kernel: 72: peek: 1
Dec 22 00:19:19 synprez kernel: ldisc_write_wakeup
Dec 22 00:19:19 synprez kernel: 73: entry in tx_loop: serial cb150760
Dec 22 00:19:19 synprez kernel: 74: write_room: 4095
Dec 22 00:19:19 synprez kernel: 75: peek: 1
Dec 22 00:19:19 synprez kernel: 76: tx_loop tty c9c39000: written: 1: fe 
Dec 22 00:19:19 synprez kernel: 77: write_room: 4094
Dec 22 00:19:19 synprez kernel: 78: peek: 0
Dec 22 00:19:19 synprez kernel: 79: exit from tx_loop
Dec 22 00:19:19 synprez kernel: 80: tx_loop tty c9c39000: written: 1: fe 
Dec 22 00:19:19 synprez kernel: 81: write_room: 4094
Dec 22 00:19:19 synprez kernel: 82: peek: 0
Dec 22 00:19:19 synprez kernel: 83: exit from tx_loop
Dec 22 00:19:19 synprez kernel: snd_serialmidi_output_trigger: up=0


--------------EC2D7760CDAC3C10A943737E
Content-Type: text/plain; charset=us-ascii;
 name="messages_hack"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages_hack"

Dec 22 00:37:51 synprez kernel: snd_serialmidi_output_trigger: up=0
Dec 22 00:37:51 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:37:51 synprez kernel: 0: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:51 synprez kernel: 1: write_room: 4095
Dec 22 00:37:51 synprez kernel: 2: peek: 3
Dec 22 00:37:51 synprez kernel: ldisc_write_wakeup
Dec 22 00:37:51 synprez kernel: 3: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:51 synprez kernel: 4: write_room: 4095
Dec 22 00:37:51 synprez kernel: 5: peek: 0
Dec 22 00:37:51 synprez kernel: 6: exit from tx_loop
Dec 22 00:37:51 synprez kernel: 7: tx_loop tty ca8dd000: written: 3: 91 3c 3f 
Dec 22 00:37:51 synprez kernel: 8: write_room: 4095
Dec 22 00:37:51 synprez kernel: 9: peek: 0
Dec 22 00:37:51 synprez kernel: 10: exit from tx_loop
Dec 22 00:37:52 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:37:52 synprez kernel: 11: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:52 synprez kernel: 12: write_room: 4095
Dec 22 00:37:52 synprez kernel: 13: peek: 3
# the C3 off is here again :-)
Dec 22 00:37:52 synprez kernel: 14: tx_loop tty ca8dd000: written: 3: 81 3c 00 
Dec 22 00:37:52 synprez kernel: 15: write_room: 4095
Dec 22 00:37:52 synprez kernel: 16: peek: 0
Dec 22 00:37:52 synprez kernel: 17: exit from tx_loop
Dec 22 00:37:52 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:37:52 synprez kernel: 18: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:52 synprez kernel: 19: write_room: 4095
Dec 22 00:37:52 synprez kernel: 20: peek: 3
Dec 22 00:37:52 synprez kernel: 21: tx_loop tty ca8dd000: written: 3: 91 40 3f 
Dec 22 00:37:52 synprez kernel: 22: write_room: 4092
Dec 22 00:37:52 synprez kernel: 23: peek: 0
Dec 22 00:37:52 synprez kernel: 24: exit from tx_loop
Dec 22 00:37:53 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:37:53 synprez kernel: 25: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:53 synprez kernel: 26: write_room: 4095
Dec 22 00:37:53 synprez kernel: 27: peek: 3
Dec 22 00:37:53 synprez kernel: 28: tx_loop tty ca8dd000: written: 3: 81 40 00 
Dec 22 00:37:53 synprez kernel: 29: write_room: 4095
Dec 22 00:37:53 synprez kernel: 30: peek: 0
Dec 22 00:37:53 synprez kernel: 31: exit from tx_loop
Dec 22 00:37:53 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:37:53 synprez kernel: 32: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:53 synprez kernel: 33: write_room: 4095
Dec 22 00:37:53 synprez kernel: 34: peek: 3
Dec 22 00:37:53 synprez kernel: 35: tx_loop tty ca8dd000: written: 3: 91 43 3f 
Dec 22 00:37:53 synprez kernel: 36: write_room: 4092
Dec 22 00:37:53 synprez kernel: 37: peek: 0
Dec 22 00:37:53 synprez kernel: 38: exit from tx_loop
Dec 22 00:37:54 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:37:54 synprez kernel: 39: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:54 synprez kernel: 40: write_room: 4095
Dec 22 00:37:54 synprez kernel: 41: peek: 3
Dec 22 00:37:54 synprez kernel: 42: tx_loop tty ca8dd000: written: 3: 81 43 00 
Dec 22 00:37:54 synprez kernel: 43: write_room: 4095
Dec 22 00:37:54 synprez kernel: 44: peek: 0
Dec 22 00:37:54 synprez kernel: 45: exit from tx_loop
Dec 22 00:37:54 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:37:54 synprez kernel: 46: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:54 synprez kernel: 47: write_room: 4095
Dec 22 00:37:54 synprez kernel: 48: peek: 3
Dec 22 00:37:54 synprez kernel: 49: tx_loop tty ca8dd000: written: 3: 91 48 3f 
Dec 22 00:37:54 synprez kernel: 50: write_room: 4092
Dec 22 00:37:54 synprez kernel: 51: peek: 0
Dec 22 00:37:54 synprez kernel: 52: exit from tx_loop
Dec 22 00:37:55 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:37:55 synprez kernel: 53: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:55 synprez kernel: 54: write_room: 4095
Dec 22 00:37:55 synprez kernel: 55: peek: 3
Dec 22 00:37:55 synprez kernel: 56: tx_loop tty ca8dd000: written: 3: 81 48 00 
Dec 22 00:37:55 synprez kernel: 57: write_room: 4095
Dec 22 00:37:55 synprez kernel: 58: peek: 0
Dec 22 00:37:55 synprez kernel: 59: exit from tx_loop
Dec 22 00:37:57 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:37:57 synprez kernel: 60: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:57 synprez kernel: 61: write_room: 4095
Dec 22 00:37:57 synprez kernel: 62: peek: 1
Dec 22 00:37:57 synprez kernel: ldisc_write_wakeup
Dec 22 00:37:57 synprez kernel: 63: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:57 synprez kernel: 64: write_room: 4095
Dec 22 00:37:57 synprez kernel: 65: peek: 0
Dec 22 00:37:57 synprez kernel: 66: exit from tx_loop
Dec 22 00:37:57 synprez kernel: 67: tx_loop tty ca8dd000: written: 1: ff 
Dec 22 00:37:57 synprez kernel: 68: write_room: 4095
Dec 22 00:37:57 synprez kernel: 69: peek: 0
Dec 22 00:37:57 synprez kernel: 70: exit from tx_loop
Dec 22 00:37:57 synprez kernel: snd_serialmidi_output_trigger: up=0
Dec 22 00:37:57 synprez kernel: snd_serialmidi_output_trigger: up=1
Dec 22 00:37:57 synprez kernel: 71: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:57 synprez kernel: 72: write_room: 4095
Dec 22 00:37:57 synprez kernel: 73: peek: 1
Dec 22 00:37:57 synprez kernel: ldisc_write_wakeup
Dec 22 00:37:57 synprez kernel: 74: entry in tx_loop: serial cb13d7c0
Dec 22 00:37:57 synprez kernel: 75: write_room: 4095
Dec 22 00:37:57 synprez kernel: 76: peek: 0
Dec 22 00:37:57 synprez kernel: 77: exit from tx_loop
Dec 22 00:37:57 synprez kernel: 78: tx_loop tty ca8dd000: written: 1: fe 
Dec 22 00:37:57 synprez kernel: 79: write_room: 4095
Dec 22 00:37:57 synprez kernel: 80: peek: 0
Dec 22 00:37:57 synprez kernel: 81: exit from tx_loop
Dec 22 00:37:57 synprez kernel: snd_serialmidi_output_trigger: up=0


--------------EC2D7760CDAC3C10A943737E--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf

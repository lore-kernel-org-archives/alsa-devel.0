From: alsa@slackware.ru
Subject: audigy2 strange behaviour
Date: Fri, 28 Mar 2003 15:54:01 +0300 (MSK)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0303281547160.17385@scil.sinp.msu.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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


Hi!


I've got that audigy2.
after Alsa installation, launching mixer etc. I've get no sound from the
card (first output). when switching  Audigy Analog/Digital Output Jack
card produces sound artifacts from the sound (plauing wav file with
aplay). just in the moment of the switching. other time it is silent.
windoze works fine with it.
kernel 2.4.20
any ideas?


04:01.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
04:01.1 Input device controller: Creative Labs SB Audigy MIDI/Game port
(rev 04)04:01.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire
Port (rev 04)

  Bus  4, device   1, function  0:
    Multimedia audio controller: Creative Labs SB Audigy (rev 4).
      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0xa000 [0xa03f].
  Bus  4, device   1, function  1:
    Input device controller: Creative Labs SB Audigy MIDI/Game port (rev
4).
      Master Capable.  Latency=32.
      I/O at 0xa400 [0xa407].
  Bus  4, device   1, function  2:
    FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 4).
      IRQ 18.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=4.
      Non-prefetchable 32 bit memory at 0xec104000 [0xec1047ff].
      Non-prefetchable 32 bit memory at 0xec100000 [0xec103fff].



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en

From: Sam <tzahm@punkass.com>
Subject: emagic MT4
Date: Fri, 19 Aug 2005 20:36:08 +0200
Message-ID: <1124476568.430626984ab55@horde.hku.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

I've been attempting to use the "snd-usb-audio" module to make an Emagic =
MT4
midi interface work under linux. At first, it appeared to be working fine=
: 'cat
/dev/snd/midiC0D0' would output more garbled characters everytime I'd str=
uck a
key on the keyboard.

Connecting the keyboard to a software synth via aconnect does work, but t=
he
result is not what one would expect: I hear one note when I first hit a k=
ey,
but the sound either gets stuck or the synth repeats the same note once I
release the key. Trying to play a scale does not work. I always hear the =
same
note.=20

I inspected the output of midiC0D0 with a midi monitor and I noticed that=
 no
"Note Off" messages were being produced. After a while, the /snd/midiC0D0
device sort of dies... still being there, but not outputting any data.

I've tried the same midi keyboard (Yamaha SY33) on OSX and it works prope=
rly.

Now, has anyone managed to get this midi interface (MT4) to work properly=
? Is it
fully operational at the moment? Could it be that the driver is generatin=
g "Note
On" messages instead of "Note Off" when keys are released?

:::sam:::


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

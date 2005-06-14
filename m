From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Tascam US-X2Y MIDI  is AWOL?
Date: Wed, 15 Jun 2005 00:50:43 +0100 (WEST)
Message-ID: <40505.192.168.1.5.1118793043.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
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
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Martin Langer <martin-langer@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Sorry to interrupt :) but I've suddenly stumbled on this, and I'm really
worried about it.

I've tested and re-tested all over again that somehow, somewhen I've lost
the MIDI I/O capability on my US-224. PCM audio is working neatly, and th=
e
jackd usx2y "rawusb" backend is doing just fine, ever since using alsa
1.0.8+ and/or 2.6.11+ kernels.

Problem is, a few days ago, I've came to try again the MIDI I/O, like
plugging a hardware synth keyboard, and to my horror it didn't work at
all. Also tried to send something out via the ALSA sequencer client port
"TASCAM US-X2Y MIDI 1", and nothing happens. MIDI I/O LEDs remain dark,
dead. Nada.

Strange thing is, when feeding the ALSA-seq port with some pitchwheel
events, the US-224 shows some weird behavior, regarding some other
completely unrelated LEDs (eg. MUTE, REC, SOLO, SELECT) being lit on and
off quite randomly. Same happens when I try to send out some midifiles
(SMFs) to the same port. When this lightfest occurs is pretty usual to
have crash due on the US-224.

It looks like, and thats my own suspicion, that MIDI is trashing the DMA
regions, or else. Other one, is if my beloved US-224 is partially damaged=
.
Thats why I'm asking you guys if you can check if this has any meaning to
you.

(Ah, nevermind that last one, MIDI I/O is working if you do it on Windows
So my US-224 MIDI I/O is NOT damaged at all. :)

I'm pretty sure (yes I am) that this MIDI I/O used to work as advertised,
but I'm afraid that the last time I had it working was before the OHCI
struggle began, more than on year ago, back in the days of alsa 1.0.3.
Remember? ;)

Any hint would be awesome.
Thanks in advance.
--=20
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

P.S. I would open the issue on mantis, but prefer to ask whether this is
something worth of it in the first place.



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k

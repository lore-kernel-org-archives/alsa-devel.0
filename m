From: Jordi Mallach <jordi@debian.org>
Subject: unresolved bugs in the Debian BTS
Date: Thu, 6 Mar 2003 19:17:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030306181713.GA15224@nubol.int.oskuro.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: debian-alsa@lists.wedontsleep.org
List-Id: alsa-devel@alsa-project.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

As promised, here are the bugs we have on our bug tracking system. I hope
some will have been fixed in some recent release and we haven't been able
to confirm. Others have been reported against rc7 (what is in Debian,
currently).

All the logs for a given bugs are in http://bugs.debian.org/bugnumber.

#######################
Bug 183316: OSS-emulation MIDI timer problems

SEQ_START_TIMER(), if used more than once for a given /dev/sequencer sessio=
n,
causes odd things to happen. I'm not quite sure what's going on here, but
investigaton using lxmusserv and rosegarden shows that timer events seem to
be occurring in bursts.

With Doom, let some piece of music be repeated then try to do something
(start a game, quit) and you'll find that it doesn't happen immediately;
instead, it happens some time later; mwanwhile, the same music continues to
be played as the game engine is blocked, waiting for musserv to read in the
new music data.

With rosegarden, the effect can be seen by starting, stopping and restarting
the music: watch the timer apparently make several large jumps (each
corresponding to many SNDCTL_SEQ_SYNC + SEQ_WAIT_TIME pairs) instead of lots
of small jumps (each of which corresponds to one SNDCTL_SEQ_SYNC +
SEQ_WAIT_TIME pair).

########################
Bug 183315: Sequencer device opening fails with ENOMEM

After some time (several open/close cycles of /dev/sequencer?), the next
attempt to use the device will cause any open attempt to return ENOMEM. The
usage counts of snd-emu10k1-synth, snd-emux-synth and snd-emu10k1 become
non-zero and are incremented for each open failure, rendering them (AFAIK)
unremovable without a reboot.

To trigger this, I've found it sufficient to run some lxmusserv-using Doom
port several times [1]; though I don't think that it matters which program =
is
used, I don't currently know whether it matters if AWE emulation/support is
used.

The problem appears to only affect OSS sequencer usage; pmidi and programs
which use other OSS devices still work.

########################
Bug 182840: hw_pointer warning with 845PE chipset

this system has an Asustek P4PE motherbooard with an Intel 845PE
chipset.  Here is the lspci output for the integrated audio
controller:

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 0=
2)

I finally managed to get sound out of this motherboard with alsaplayer
(not with the ALSA xmms output plugin yet).

So all is well, except that I saw this warning message in the dmesg
output:

ALSA ../alsa-kernel/core/pcm_lib.c:187: Unexpected hw_pointer value (stream=
 =3D 0, delta: -1168, max jitter =3D 8192): wrong interrupt acknowledge?

PS: the other soundcard (ens1371) is managed by OSS/Free.

#########################
Bug 181890: System crash after using sound device

The submitter says the kernel and the modules were compiled with the same
compiler version. Sound card is a Crystal Sound 4237B or 4236B, he's not su=
re.
He gets a Null pointer dereference kernel error.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D181890

#########################
Bug 180653: Bad audio quality on VT8233 with rc7

Quoting:
-----------------
The quality of the audio output has decreased very strongly from rc6
to rc7.  With rc6, everything was working fine, but with rc7 there is
always a bit of noise when sound is played (I had the same problem
with older versions of alsa, but rc6 was working fine).

My sound card is an on-board VT8233 chip, and I'm running kernel
2.4.20.  I didn't try rc7-1.
------------------

Could this be related to the bad detection code in rc7 for VIA8233?

#########################

Bug 177522: aplay segfaults on multiple files

Submitted against RC3, but I think it's still there:

-----------------
sorry fellas, when one mixes .au and .wav, or does more than one of the same
file, e.g.
$ y=3D/usr/share/emacs/site-lisp/emacspeak/sounds/default-8k/yank-object.au
$ aplay $y $y $y $y
one wont hear all what is requested, and will even seg fault!


aplay: pcm.c:5692: snd_pcm_unlink_ptr: Assertion `0' failed.
Aborted...
aplay: pcm_plug.c:68: snd_pcm_plug_close: Assertion `plug->slave =3D=3D plu=
g->req_slave' failed.
Aborted...
aplay: pcm_plug.c:68: snd_pcm_plug_close: Assertion `plug->slave =3D=3D plu=
g->req_slave' failed.

that line  repeated 4000 times, then
Segmentation fault
-----------------

Is this a bug in alsa-utils, or in an old rc3 driver?

########################

The following bugs are a bit older, so I'll just give urls for the bug logs.
We would appreciate some feedback, if you know they have been fixed in rece=
nt
release candidates

########################
Bug 174690: alsamixer silently fails with ALI5451 South Bridge card

(against beta12)

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D174690

########################
Bug 172967: "AC'97 0:0 does not respond"

(against rc6)

He said:
When attempting to load the es1968 driver, built against kernel 2.4.18,
2.4.19 or 2.4.20, I get the following message from the ALSA code:

    kernel: ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:1529: AC'97 0:0 do=
es not respond - RESET [REC_GAIN =3D 0x0]

The driver fails to load.

Same for rc5, works with beta12.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D172967

#######################
Bug 126797: Rear channels no longer work on SB Live ! 512

(against beta10)

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D126797

Probably fixed?

#######################
Bug 123800: maestro3 breaks irda

ancient bug, submitter doesn't have the hardware anymore. The bug has a poi=
nter to a patch, but it's a 404 now, so I couldn't check.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D123800

########################
Bug 108572: PCI IRQ sharing with USB will crash ALSA
(against beta 4)

Null pointer dereference when loading the cs45xx module.
Another user confirmed this for rc6, but now with kernel panic.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D108572

Would be nice to have a look at this one.

#########################

That's it, I think. Any feedback very welcome.

Jordi

--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Z5CpJYSUupF6Il4RAggvAKCBDGXosUdJD3TW+SOiyKPuFckCgQCfdUI+
f9y8hppPRDyf+yUUa1V2W9M=
=r86e
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com

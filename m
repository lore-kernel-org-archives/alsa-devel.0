From: Mark Ziegler <info.mz@gmx.de> (by way of Mark Ziegler <info.mz@gmx.de>)
Subject: xrun in arecord, ice1714
Date: Tue, 19 Nov 2002 20:48:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211192048.21064.info.mz@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

I've sent this mail already to the alsa-user formum, but nobody answered.=
 I=20
don't know, my be the questions are too stupid, too difficult or just too=
=20
trivial. Sorry for bothering you, but I really think its something to tal=
k a=20
little bit.

Hopefully an alsa developer has an answer:


I've got 2 questions:

1.) I want to record the digital input from my ice1714 based terratec car=
d. I
found here the advice to write the following ~/,asoundrc:

pcm.ice_spdif {
                type plug
                ttable.0.8 1
                ttable.1.9 1
                slave.pcm {
                        type hw
                        card 1
                        device 0
                }
        }

Then I started arecord -f cd -Dice_spdif test.wav

Ok, works fine. But I figgured out, that even a 48kHz sampled song will b=
e
resampled to 44.1kHz by the alsa drivers. I understood, with the option -=
f
dat I can sample 48kHz. But I would be more lucky, if I cound get the raw
data without resampling by the alsa drivers. I mean, it might be, that my=
 DAT
Player gives only 44099 Hz. Does anybody know how to modify the .asoundrc=
 to
switch off the resampling feature?

2.) arecord reported a lot of xruns. I also tried to run arecord from the
commandline and I switched off the x-server, I worked on a fresh booted l=
inux
system, I played with the arecord option -B from 10000 to 3000000 (I don'=
t
care about latency), but the xruns didn't disapear. And when playing back=
 the
samples, the breaks don't sound very good. I found here in the newsgroup =
the
hint to use

ecasound -r -z:db -z:intbuf -f:s32_le,12,44100 -i alsa,hw:1 -f:s32_le,2,4=
4100
-o test.wav

under root, but usually my system hangs complete after starting ecasound.
 Only once it worked and it also reported that some data are lost.

So far, now my question: Can I do something against the problem, or do I =
have
to wait for newer alsa-releases or is it more a linux kernel problem? Or =
is
the problem, that my IDE-drives are buffered in memory, and sometime huge
buffers are written back to the harddisk and the alsa driver doesn't get =
time
to write out his buffer? Is it more a problem of the userspace (arecord) =
or
of the alsa-driver?
Or can anybody explain the problem roughly? I think my 2 GHz processor sh=
ould
be completely bored by transporting 44.1kHz * 2 * 16 / 8  =3D 176400 Byte=
s/s
from the sound card to the IDE disk.

For any advice I'm lucky


  Mark


My system:
Software
Suse linux-kernel 2.4.19,
Alsa 0.9 RC5

Hardware
Terratec Soundcard EWX 24/96
Athlon XP 2000



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html

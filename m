From: <leif@sm5bsz.com>
Subject: oss compatibility
Date: Tue, 25 Jan 2005 01:01:44 +0100
Message-ID: <CFEIKLJOPPJLBFPEJHKOEECBEBAA.leif@sm5bsz.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Linrad as an SDR package, filtering decoding radio signals in a PC.
It uses soundcards to read wideband audio into the computer, typically
a Delta 44 can supply 2 channels of 90 kHz bandwidth with a very good
dynamic range. http://www.sm5bsz.com/linuxdsp/linrad.htm

It would certainly be most welcome if alsa could be used for
the Linrad device drivers, but there are still some small
compatibility problems that most probably would be very
easy to resolv.

To get the full performance from (so called) 24 bit soundcards
such as Delta 44 it is not enough to read 16 bits only. The original
soundcard.h does not support any 32 bit format but 4-Front supplies
drivers that can use a format AFMT_S32_LE. It would be a very good
idea if the alsa-oss compatibility routine could support this format
or allow some other way of specifying 32 bits.=20

Another problem is that calls to ioctl to set speed, number of channels
and other things do not return the value actually accepted by the=20
hardware as the oss manual says it should. The Linrad program follows
the instructions in the oss manual and tries to set a very high sampling
speed to get a return value that is the highest possible speed.
A Delta 44 will return 96000 Hz in some oss versions although it will
return whatever value set by ossmix in other versions. Linrad uses this
strategy to get max and min speeds, no of channels and supported
formats (no of bits). This does not work under alsa since all sound
cards seem to be identical, supporting everything. As a consequence
the user has to take decisions based on knowledge of the hardware
actually present inside his box. This is a problem to new-comers who
are reluctant to install Linux in the first place.

It would certainly be a very good thing if alsa could be fully =
compatible
with oss. Some day I hope Linrad will be rewritten, but it seems to
be a good idea to keep the oss interface for a couple of years to come
because Linrad is efficient enough to run on Pentium and Pentium MMX=20
computers on which it is difficult (or impossible) to install
modern Linux distributions. Computers that are obsolete for MS Windows
can be converted to excellent radio receivers using SuSE 7.3, RedHat =
7.1,=20
Mandrake 8.1 or similar and novices will not be able to install alsa
on such systems so it is better to keep the oss interface that works
well.

I am the single author of Linrad, I am not a programmer at all, I just
use a small sub-set of the C language and some assembly. I have good
hope that I will get help from others to rewrite the code from a rather
messy single thread to a easily understandable multi-threaded
structure that could perhaps take advantage of some alsa features that
are above my level as a programmer.

The programming techniques of Linrad may be at a very low level (in
several meanings of the sentence) but the processing actually done
is quite sophisticated, it includes interference recognition and
coherent processing as well as highly optimised fft routines. It would
certainly be very good if it would work directly under new Linux
distributions without the need for paying for an oss license.

It seems to me that the corrections needed are quite small:-)

  Regards

  Leif Asbrink

PS. I tried to subscribe to the list, but failed. (There is no =
postmaster
at my domain for spam reasons.) I hope the contents of this mail reaches =

some of the people involved with the alsa development. My E-mail address =

can be found in a gif file at http://www.sm5bsz.com/ in case something =
is
unclear. DS.



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl

From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Fri, 14 Nov 2003 02:43:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311140246.14873.pwk.linuxfan@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
List-Id: alsa-devel@alsa-project.org

WARNING: Unsanitized content follows.
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi guys,

In the last few days I have been reading a lot about how to mix streams int=
o=20
one in order to allow *weak* soundcards to play multiple streams, even thou=
gh=20
they cant do that in hardware. This seems to be doable with dmix. Also, I=
=20
have thought about the situation where the capture devices are used up, for=
=20
this I found the plugin "dsnoop".=20
After thinking a bit about the situation I thought the following would be a=
=20
great idea (a feature suggestion to alsa):

Alsa knows howmany playback and howmany capture devices it has, and it also=
=20
knows howmany times they can be opened. So, the result are two numbers:
The amount of streams that can be played back in hardware, AND
The amount of times an application can open a capture stream.

So, these are two numbers - and basicly all is fine as long as you dont wan=
t=20
to excede them, but if you do, you need to use dmix or dsnoop. Why not use=
=20
dmix and dsnoop automaticly when necessary ? Wouldnt it be possible to have=
=20
every application play through something like a "smartdmix", that would jus=
t=20
pass on the sound-streams to real-world devices, as long as there are still=
=20
playback devices that can handle annother stream...once the user opens a=20
playback stream while there is no *free*slot* for it, the "smartdmix" would=
=20
start mixing this stream with one of the already existing streams, making i=
t=20
possible to play back although the hardware wouldnt have supported the extr=
a=20
stream.
Same idea with the capture part...as long as there are still capture device=
s a=20
utility called "smartdsnoop" would just pass on the capture stream directly=
=20
from the existing capture device, and only once the first application is=20
opened that claims to need to capture and for which there is no free captur=
e=20
device, smartdsnoop would split one capture stream into two - and so be abl=
e=20
to serve this new application.

After all this babble, here is what I expect from the above:
- - Near zero overhead as long as the system uses the soundcard in the limi=
ts=20
the soundcard provides.
- - Support for any amount of playback and capture streams, no matter on wh=
at=20
soundcard (provided of course the soundcard has at least one playback and o=
ne=20
capture device :D).
- - Near zero configuration/tuning work needed to be done by the user, all =
done=20
by smartdmix and smartdsnoop.
- - Low cpu and latency misuse  - since the *mixing* or *spliting* capabili=
ties=20
are only activated when needed, and deactivated when not used anymore.

Hope to hear your opinions on this,
Peter
- --=20
Take what you can use and let the rest go by.
		-- Ken Kesey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tDNJg2ieGvTmHiURAl0XAJ9iEIqiEQAfhGElsAh8ddNtBu9YKQCbB7qF
jx5IU70naqNZrMbYtejShFY=3D
=3DdFm/
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/

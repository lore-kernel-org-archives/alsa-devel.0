From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: C-Media	CMI9761A REV
Date: Sat, 19 Feb 2005 16:26:53 +0000
Message-ID: <1108830414.26083.19.camel@bastov>
References: <1108782279.23185.38.camel@bastov>  <4216B80C.2090507@gmx.de>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4216B80C.2090507@gmx.de>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: t.schorpp@gmx.de, webmaster@alsa-project.org
Cc: Jakob Schurdak <jakobs@myrealbox.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,
Alsa-webmaster please read the end of message and improve your
http://www.alsa-project.org/download.php page !

Well mine is:
lspci -v
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: ASRock Incorporation: Unknown device 9739
lspci -n
00:11.5 Class 0401: 1106:3059 (rev 60)

I finished to test last sources of the CVS, I back to first state, no
improves, no master again.

For Jakob and alsa-webmaster, a little fast How to compile alsa from
CVS:

yum -y install gettext-devel.i386 ( you will need this for cvscompile
alsa-utils and you will need autotools )=20

service alsasound stop (or rmmod all snd-*)

cvs -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa login
(enter)
cvs -z3 -q -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa=
-driver
cvs -z3 -q -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa=
-kernel
cvs -z3 -q -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa=
-lib
cvs -z3 -q -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa co alsa=
-utils
cd alsa-driver
cvscompile (stop when enter in configure, because will compile drives
for all cards and we just need for our via82xx)=20
./configure --with-cards=3Ddummy,via82xx --with-sequencer=3Dyes --with-is=
apnp=3Dno
make
make install
modprobe snd-via82xx

cd ../alsa-lib
cvscompile && make install && ldconfig
cd ../alsa-utils
cvscompile && make install=20

regards,

On Sat, 2005-02-19 at 04:52 +0100, thomas schorpp wrote:
> Sergio Monteiro Basto wrote:
>=20
> > I have one ASRock P4VT8+ with CMedia CMI9761 (not the same of Jakob) =
but
> > same rev. of sound card.
> > 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/=
8235/8237 AC97 Audio Controller (rev 60)
>=20
> BTW, THATS NOT THE CODEC, only a interface.
>=20
> this is it:
>=20
> lspci -v
>=20
>   0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.=20
> VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
>          Subsystem: Unknown device 1849:9761 <--------------------
>=20
> tom
>=20
--=20
S=E9rgio M.B.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick

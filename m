From: maser rati <maseriyer@yahoo.com>
Subject: Re: Question about AT73C213.conf
Date: Wed, 21 Feb 2007 20:18:38 -0800 (PST)
Message-ID: <762036.45596.qm@web37709.mail.mud.yahoo.com>
References: <718259.33692.qm@web37714.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0513368156=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <718259.33692.qm@web37714.mail.mud.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============0513368156==
Content-Type: multipart/alternative; boundary="0-831388511-1172117918=:45596"
Content-Transfer-Encoding: 7bit

--0-831388511-1172117918=:45596
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


 Following up, the kernel was compiled using gcc 3.4 instead of gcc 4.1 a=
nd the alsa driver seems to work better. This is a toolchain problem, acc=
ording to Atmel and our distribution vendor.
=20
 But, we get the following error messages:
=20
 -bash-3.1# aplay -D default Noise.wav
 Playing WAVE 'Noise.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, M=
ono
 ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to find =
an usable access for 'default'
 aplay: set_params:909: Channels count non available
=20
 Could it be possible that there is something fishy going on with the als=
a-lib ?
=20
 Appreciate your input..
=20
 Thanks,
 iyer
=20
=20
=20
=20
=20
=20
=20
=20

maser rati <lazardo12@yahoo.com> wrote: Hi Takashi,
=20
 Omitting the --prefix =3D/board-rfs, DESTDIR=3D/board-rfs was passed in =
make install, and on checking, it seemed that the bin, lib, share and inc=
lude components of the alsa-lib were installed under /board-rfs/usr=20
=20
 However on running an application, this is got=20
=20
 -bash-3.1# ./soundtest default
 ALSA lib pcm_params.c:2152:(snd_pcm_hw_refine_slave) Slave PCM not usabl=
e
 cannot initialize hardware parameter structure (Invalid argument)
=20
 Setting the environment variable $LIBASOUND_DEBUG to 1 does not cause an=
y debugging information to be displayed to stderr. (I double checked via =
#echo to make sure LIBASOUND_DEBUG was set to 1)
=20
 I'm clueless, am I doing anything wrong ?
=20
 Thanks much,
 iyer
=20
=20

Takashi Iwai <tiwai@suse.de> wrote: At Wed, 14 Feb 2007 12:32:35 -0800  (=
PST),
maser rati wrote:
>=20
> The installation was done via the configure command, make and make inst=
all.
>=20
> How to enable the alsa-files to install to a specific directory, board-=
rfs ? On trying
> different options in the ./configure script; --prefix=3D/board-rfs exac=
tly installs the
> alsa-lib components to it.

But --prefix=3DXXX overrides the path embedded in the code.  For
installing to another root, passing DESTDIR=3DXXX at make install is the
standard procedure.

> Moreover on running aplay, it was found that atrace wasn't able to loca=
te alsa.conf,
> with the location being at at /etc/alsa, so the contents of /etc/alsa w=
ere moved to /
> usr/share/alsa. However it says that the setup is corrupt. Please find =
attached the
> strace for aplay; your valuable input is appreciated.

This is a different thing.  Now the system files are properly set and
alsa-lib reads them.  But, the driver  returns an error for the
required PCM setting.

Try to set $LIBASOUND_DEBUG to 1.  Then each hw_params error will be
displayed to stderr.  See alsa-lib/NOTES for details.


Takashi

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

  =20

---------------------------------
Have a burning question? Go to Yahoo! Answers and get answers from real p=
eople who know.----------------------------------------------------------=
---------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


=20
---------------------------------
Bored stiff? Loosen up...
Download and play hundreds of games for free on Yahoo! Games.
--0-831388511-1172117918=:45596
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<br> Following up, the kernel was compiled using gcc 3.4 instead of gcc 4=
.1 and the alsa driver seems to work better. This is a toolchain problem,=
 according to Atmel and our distribution vendor.<br> <br> But, we get the=
 following error messages:<br> <br> -bash-3.1# aplay -D default Noise.wav=
<br> Playing WAVE 'Noise.wav' : Signed 16 bit Little Endian, Rate 48000 H=
z, Mono<br> ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unab=
le to find an usable access for 'default'<br> aplay: set_params:909: Chan=
nels count non available<br> <br> Could it be possible that there is some=
thing fishy going on with the alsa-lib ?<br> <br> Appreciate your input..=
<br> <br> Thanks,<br> iyer<br> <br> <br> <br> <br> <br> <br> <br> <br><br=
><b><i>maser rati &lt;lazardo12@yahoo.com&gt;</i></b> wrote:<blockquote c=
lass=3D"replbq" style=3D"border-left: 2px solid rgb(16, 16, 255); margin-=
left: 5px; padding-left: 5px;"> Hi Takashi,<br> <br> Omitting the --prefi=
x =3D/board-rfs, DESTDIR=3D/board-rfs was
 passed in make install, and on checking, it seemed that the bin, lib, sh=
are and include components of the alsa-lib were installed under /board-rf=
s/usr <br> <br> However on running an application, this is got <br> <br> =
-bash-3.1# ./soundtest default<br> ALSA lib pcm_params.c:2152:(snd_pcm_hw=
_refine_slave) Slave PCM not usable<br> cannot initialize hardware parame=
ter structure (Invalid argument)<br> <br> Setting the environment variabl=
e $LIBASOUND_DEBUG to 1 does not cause any debugging information to be di=
splayed to stderr. (I double checked via #echo to make sure LIBASOUND_DEB=
UG was set to 1)<br> <br> I'm clueless, am I doing anything wrong ?<br> <=
br> Thanks much,<br> iyer<br> <br> <br><br><b><i>Takashi Iwai &lt;tiwai@s=
use.de&gt;</i></b> wrote:<blockquote class=3D"replbq" style=3D"border-lef=
t: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> At =
Wed, 14 Feb 2007 12:32:35 -0800  (PST),<br>maser rati wrote:<br>&gt; <br>=
&gt; The installation was done via the
 configure command, make and make install.<br>&gt; <br>&gt; How to enable=
 the alsa-files to install to a specific directory, board-rfs ? On trying=
<br>&gt; different options in the ./configure script; --prefix=3D/board-r=
fs exactly installs the<br>&gt; alsa-lib components to it.<br><br>But --p=
refix=3DXXX overrides the path embedded in the code.  For<br>installing t=
o another root, passing DESTDIR=3DXXX at make install is the<br>standard =
procedure.<br><br>&gt; Moreover on running aplay, it was found that atrac=
e wasn't able to locate alsa.conf,<br>&gt; with the location being at at =
/etc/alsa, so the contents of /etc/alsa were moved to /<br>&gt; usr/share=
/alsa. However it says that the setup is corrupt. Please find attached th=
e<br>&gt; strace for aplay; your valuable input is appreciated.<br><br>Th=
is is a different thing.  Now the system files are properly set and<br>al=
sa-lib reads them.  But, the driver  returns an error for the<br>required=
 PCM setting.<br><br>Try to set
 $LIBASOUND_DEBUG to 1.  Then each hw_params error will be<br>displayed t=
o stderr.  See alsa-lib/NOTES for details.<br><br><br>Takashi<br><br>----=
---------------------------------------------------------------------<br>=
Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.n=
et's Techsay panel and you'll get the chance to share your<br>opinions on=
 IT &amp; business topics through brief surveys-and earn cash<br>http://w=
ww.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;CID=3D=
DEVDEV<br>_______________________________________________<br>Alsa-devel m=
ailing list<br>Alsa-devel@lists.sourceforge.net<br>https://lists.sourcefo=
rge.net/lists/listinfo/alsa-devel<br></blockquote><br><div>   </div><hr s=
ize=3D"1">Have a burning question? Go to <a href=3D"http://answers.yahoo.=
com/;_ylc=3DX3oDMTFvbGNhMGE3BF9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA21ha=
WxfdGFnbGluZQRzbGsDbWFpbF90YWcx">Yahoo! Answers</a> and get answers from =
real people who
 know.-------------------------------------------------------------------=
------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join Sou=
rceForge.net's Techsay panel and you'll get the chance to share your<br>o=
pinions on IT &amp; business topics through brief surveys-and earn cash<b=
r>http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&=
amp;CID=3DDEVDEV_______________________________________________<br>Alsa-d=
evel mailing list<br>Alsa-devel@lists.sourceforge.net<br>https://lists.so=
urceforge.net/lists/listinfo/alsa-devel<br></blockquote><br><p>&#32;

<hr size=3D1><a href=3D"http://us.rd.yahoo.com/evt=3D49935/*http://games.=
yahoo.com">Bored stiff?</a> Loosen up...<br><a href=3D"http://us.rd.yahoo=
.com/evt=3D49935/*http://games.yahoo.com">Download and play hundreds of g=
ames for free</a> on Yahoo! Games.
--0-831388511-1172117918=:45596--


--===============0513368156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0513368156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0513368156==--

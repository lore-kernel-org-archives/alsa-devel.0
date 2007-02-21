From: maser rati <lazardo12@yahoo.com>
Subject: Re: Question about AT73C213.conf
Date: Tue, 20 Feb 2007 17:47:15 -0800 (PST)
Message-ID: <718259.33692.qm@web37714.mail.mud.yahoo.com>
References: <s5hmz3fa48v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1677855482=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hmz3fa48v.wl%tiwai@suse.de>
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

--===============1677855482==
Content-Type: multipart/alternative; boundary="0-1190738591-1172022435=:33692"
Content-Transfer-Encoding: 7bit

--0-1190738591-1172022435=:33692
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Takashi,
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

Takashi Iwai <tiwai@suse.de> wrote: At Wed, 14 Feb 2007 12:32:35 -0800 (P=
ST),
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
alsa-lib reads them.  But, the driver returns an error for the
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
eople who know.
--0-1190738591-1172022435=:33692
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Takashi,<br> <br> Omitting the --prefix =3D/board-rfs, DESTDIR=3D/boar=
d-rfs was passed in make install, and on checking, it seemed that the bin=
, lib, share and include components of the alsa-lib were installed under =
/board-rfs/usr <br> <br> However on running an application, this is got <=
br> <br> -bash-3.1# ./soundtest default<br> ALSA lib pcm_params.c:2152:(s=
nd_pcm_hw_refine_slave) Slave PCM not usable<br> cannot initialize hardwa=
re parameter structure (Invalid argument)<br> <br> Setting the environmen=
t variable $LIBASOUND_DEBUG to 1 does not cause any debugging information=
 to be displayed to stderr. (I double checked via #echo to make sure LIBA=
SOUND_DEBUG was set to 1)<br> <br> I'm clueless, am I doing anything wron=
g ?<br> <br> Thanks much,<br> iyer<br> <br> <br><br><b><i>Takashi Iwai &l=
t;tiwai@suse.de&gt;</i></b> wrote:<blockquote class=3D"replbq" style=3D"b=
order-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5=
px;"> At Wed, 14 Feb 2007 12:32:35 -0800
 (PST),<br>maser rati wrote:<br>&gt; <br>&gt; The installation was done v=
ia the configure command, make and make install.<br>&gt; <br>&gt; How to =
enable the alsa-files to install to a specific directory, board-rfs ? On =
trying<br>&gt; different options in the ./configure script; --prefix=3D/b=
oard-rfs exactly installs the<br>&gt; alsa-lib components to it.<br><br>B=
ut --prefix=3DXXX overrides the path embedded in the code.  For<br>instal=
ling to another root, passing DESTDIR=3DXXX at make install is the<br>sta=
ndard procedure.<br><br>&gt; Moreover on running aplay, it was found that=
 atrace wasn't able to locate alsa.conf,<br>&gt; with the location being =
at at /etc/alsa, so the contents of /etc/alsa were moved to /<br>&gt; usr=
/share/alsa. However it says that the setup is corrupt. Please find attac=
hed the<br>&gt; strace for aplay; your valuable input is appreciated.<br>=
<br>This is a different thing.  Now the system files are properly set and=
<br>alsa-lib reads them.  But, the driver
 returns an error for the<br>required PCM setting.<br><br>Try to set $LIB=
ASOUND_DEBUG to 1.  Then each hw_params error will be<br>displayed to std=
err.  See alsa-lib/NOTES for details.<br><br><br>Takashi<br><br>---------=
----------------------------------------------------------------<br>Take =
Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's =
Techsay panel and you'll get the chance to share your<br>opinions on IT &=
amp; business topics through brief surveys-and earn cash<br>http://www.te=
chsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;CID=3DDEVDE=
V<br>_______________________________________________<br>Alsa-devel mailin=
g list<br>Alsa-devel@lists.sourceforge.net<br>https://lists.sourceforge.n=
et/lists/listinfo/alsa-devel<br></blockquote><br><p>&#32;

<hr size=3D1>Have a burning question? Go to <a href=3D"http://answers.yah=
oo.com/;_ylc=3DX3oDMTFvbGNhMGE3BF9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA2=
1haWxfdGFnbGluZQRzbGsDbWFpbF90YWcx">Yahoo! Answers</a> and get answers fr=
om real people who know.
--0-1190738591-1172022435=:33692--


--===============1677855482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1677855482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1677855482==--

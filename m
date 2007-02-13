From: maser rati <maseriyer@yahoo.com>
Subject: Re: Question about AT73C213.conf
Date: Mon, 12 Feb 2007 20:01:19 -0800 (PST)
Message-ID: <5883.53789.qm@web37712.mail.mud.yahoo.com>
References: <s5hejovmszi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0205556710=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hejovmszi.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============0205556710==
Content-Type: multipart/alternative; boundary="0-1103748752-1171339279=:53789"
Content-Transfer-Encoding: 7bit

--0-1103748752-1171339279=:53789
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for your email, Takashi.
=20
 The config files (ainit.conf, alsa.conf) are found in board-rfs/etc/alsa=
; not in /board-rfs/share/alsa/ and its sub directories. I'm not sure if =
this is the correct location for the config files. If not, do let me know=
.
=20
 /dev/snd has the sound devices controlC0  pcmC0D0p  timer .
=20
 On playing a soundtest executable (random sound generator):
  -bash-3.1# ./soundtest default
 ALSA lib pcm.c:2143:(snd_pcm_open_noupdate) Unknown PCM default
 cannot open audio device default (No such file or directory)
=20
 Could this be tied in with the location of the config files ?
=20
 Thanks in advance...
=20
 iyer
=20
=20
=20
=20

Takashi Iwai <tiwai@suse.de> wrote: At Sun, 11 Feb 2007 21:25:32 -0800 (P=
ST),
maser rati wrote:
>=20
> Hello Takashi,
>=20
> I was wondering if you have any suggestions regarding
> the email thread below.
>=20
> Appreciate your input.

Maybe you missed my last reply.  Attached again.


At Tue, 6 Feb 2007 10:21:18 -0800 (PST),
maser rati wrote:
>=20
> Takashi,
>=20
> Thanks for your response..
>=20
> Here are the steps followed in installing the alsa-lib on an ARM board:=
=20
>=20
> ALSA-lib install steps:
>=20
> [root@localhost alsa-lib-1.0.12]# CC=3Darmv5l-linux-gcc ./configure --b=
uild=3Di386-linux
> --prefix=3D/board-rfs --host=3Darmv5l-linux --target=3Darmv5l-linux --e=
nable-shared=3Dyes
> --enable-static=3Dno --disable-hwdep --disable-instr --with-headers=3D/=
board-rfs/usr/
> include/

Is /board-rfs the correct path?  If you pass --prefix=3D/board-rfs, this
patch will be built into the binary, so the alsa-lib eventually
searchs for config files under /board-rfs/share/alsa/ and its sub
directories.


Takashi

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job ea=
sier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel




=20
---------------------------------
Food fight? Enjoy some healthy debate
in the Yahoo! Answers Food & Drink Q&A.
--0-1103748752-1171339279=:53789
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for your email, Takashi.<br> <br> The config files (ainit.conf, al=
sa.conf) are found in board-rfs/etc/alsa; not in /board-rfs/share/alsa/ a=
nd its sub directories. I'm not sure if this is the correct location for =
the config files. If not, do let me know.<br> <br> /dev/snd has the sound=
 devices controlC0&nbsp; pcmC0D0p&nbsp; timer .<br> <br> On playing a sou=
ndtest executable (random sound generator):<br> &nbsp;-bash-3.1# ./soundt=
est default<br> ALSA lib pcm.c:2143:(snd_pcm_open_noupdate) Unknown PCM d=
efault<br> cannot open audio device default (No such file or directory)<b=
r> <br> Could this be tied in with the location of the config files ?<br>=
 <br> Thanks in advance...<br> <br> iyer<br> <br> <br> <br> <br><br><b><i=
>Takashi Iwai &lt;tiwai@suse.de&gt;</i></b> wrote:<blockquote class=3D"re=
plbq" style=3D"border-left: 2px solid rgb(16, 16, 255); margin-left: 5px;=
 padding-left: 5px;"> At Sun, 11 Feb 2007 21:25:32 -0800 (PST),<br>maser =
rati wrote:<br>&gt; <br>&gt; Hello
 Takashi,<br>&gt; <br>&gt; I was wondering if you have any suggestions re=
garding<br>&gt; the email thread below.<br>&gt; <br>&gt; Appreciate your =
input.<br><br>Maybe you missed my last reply.  Attached again.<br><br><br=
>At Tue, 6 Feb 2007 10:21:18 -0800 (PST),<br>maser rati wrote:<br>&gt; <b=
r>&gt; Takashi,<br>&gt; <br>&gt; Thanks for your response..<br>&gt; <br>&=
gt; Here are the steps followed in installing the alsa-lib on an ARM boar=
d: <br>&gt; <br>&gt; ALSA-lib install steps:<br>&gt; <br>&gt; [root@local=
host alsa-lib-1.0.12]# CC=3Darmv5l-linux-gcc ./configure --build=3Di386-l=
inux<br>&gt; --prefix=3D/board-rfs --host=3Darmv5l-linux --target=3Darmv5=
l-linux --enable-shared=3Dyes<br>&gt; --enable-static=3Dno --disable-hwde=
p --disable-instr --with-headers=3D/board-rfs/usr/<br>&gt; include/<br><b=
r>Is /board-rfs the correct path?  If you pass --prefix=3D/board-rfs, thi=
s<br>patch will be built into the binary, so the alsa-lib eventually<br>s=
earchs for config files under /board-rfs/share/alsa/ and
 its sub<br>directories.<br><br><br>Takashi<br><br>----------------------=
---------------------------------------------------<br>Using Tomcat but n=
eed to do more? Need to support web services, security?<br>Get stuff done=
 quickly with pre-integrated technology to make your job easier.<br>Downl=
oad IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br>=
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D2630=
57&amp;dat=3D121642<br>_______________________________________________<br=
>Alsa-devel mailing list<br>Alsa-devel@lists.sourceforge.net<br>https://l=
ists.sourceforge.net/lists/listinfo/alsa-devel<br></blockquote><br><BR><B=
R><p>&#32;

<hr size=3D1><a href=3D"http://answers.yahoo.com/dir/index;_ylc=3DX3oDMTF=
vbGNhMGE3BF9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA21haWxfdGFnbGluZQRzbGsD=
bWFpbF90YWcx?link=3Dask&sid=3D396545367">Food fight?</a> Enjoy some healt=
hy debate<br>in the <a href=3D"http://answers.yahoo.com/dir/index;_ylc=3D=
X3oDMTFvbGNhMGE3BF9TAzM5NjU0NTEwOARfcwMzOTY1NDUxMDMEc2VjA21haWxfdGFnbGluZ=
QRzbGsDbWFpbF90YWcx?link=3Dask&sid=3D396545367">Yahoo! Answers Food & Dri=
nk Q&A.</a>
--0-1103748752-1171339279=:53789--


--===============0205556710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0205556710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0205556710==--

From: maser rati <lazardo12@yahoo.com>
Subject: Re: Question about AT73C213.conf
Date: Tue, 6 Feb 2007 10:21:18 -0800 (PST)
Message-ID: <986463.63422.qm@web37709.mail.mud.yahoo.com>
References: <s5h7iuvw71y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0968477669=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h7iuvw71y.wl%tiwai@suse.de>
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

--===============0968477669==
Content-Type: multipart/alternative; boundary="0-97026648-1170786078=:63422"
Content-Transfer-Encoding: 7bit

--0-97026648-1170786078=:63422
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Takashi,
=20
 Thanks for your response..
=20
 Here are the steps followed in installing the alsa-lib on an ARM board: =
=20
=20
 ALSA-lib install steps:
=20
 [root@localhost alsa-lib-1.0.12]# CC=3Darmv5l-linux-gcc ./configure --bu=
ild=3Di386-linux --prefix=3D/board-rfs --host=3Darmv5l-linux --target=3Da=
rmv5l-linux --enable-shared=3Dyes --enable-static=3Dno --disable-hwdep --=
disable-instr --with-headers=3D/board-rfs/usr/include/
=20
 [root@localhost alsa-lib-1.0.12]# make TARGET_ARCH=3Darm=20
=20
 [root@localhost alsa-lib-1.0.12]# make install_root=3D/board-rfs prefix=3D=
"/board-rfs" install
=20
 Appreciate your input.
=20
 -iyer

Takashi Iwai <tiwai@suse.de> wrote: At Mon, 5 Feb 2007 17:05:23 -0800 (PS=
T),
maser rati wrote:
>=20
> Hello,
>=20
> We are trying to get the audio chip (AT73C213) that comes on the AT91SA=
M9261-EK
> development board working. alsa-lib and alsa-utils, version 1.0.12 are =
currently
> installed.
>=20
> # aplay -l shows that the audio chip is recognized as a playback device=
 (and has a
> driver).
> # aplay -L fails; there aren't any PCM devices configured.
> # alsaconf fails too.
>=20
> We can't seem to find .conf files for any Atmel chips among the Alsa do=
cs and files.
>=20
> I assume the missing .conf file is the issue. Has anyone been successfu=
l with this?

Basically it should work even without the dedicated card's *.conf file
as alsa-lib takes pcm/default.conf.  How did you install alsa-lib and
co?


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
Don't be flakey. Get Yahoo! Mail for Mobile and=20
always stay connected to friends.
--0-97026648-1170786078=:63422
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Takashi,<br> <br> Thanks for your response..<br> <br> Here are the steps =
followed in installing the alsa-lib on an ARM board:&nbsp; <br> <br> ALSA=
-lib install steps:<br> <br> [root@localhost alsa-lib-1.0.12]# CC=3Darmv5=
l-linux-gcc ./configure --build=3Di386-linux --prefix=3D/board-rfs --host=
=3Darmv5l-linux --target=3Darmv5l-linux --enable-shared=3Dyes --enable-st=
atic=3Dno --disable-hwdep --disable-instr --with-headers=3D/board-rfs/usr=
/include/<br> <br> [root@localhost alsa-lib-1.0.12]# make TARGET_ARCH=3Da=
rm <br> <br> [root@localhost alsa-lib-1.0.12]# make install_root=3D/board=
-rfs prefix=3D"/board-rfs" install<br> <br> Appreciate your input.<br> <b=
r> -iyer<br><br><b><i>Takashi Iwai &lt;tiwai@suse.de&gt;</i></b> wrote:<b=
lockquote class=3D"replbq" style=3D"border-left: 2px solid rgb(16, 16, 25=
5); margin-left: 5px; padding-left: 5px;"> At Mon, 5 Feb 2007 17:05:23 -0=
800 (PST),<br>maser rati wrote:<br>&gt; <br>&gt; Hello,<br>&gt; <br>&gt; =
We are trying to get the audio chip (AT73C213) that comes on the
 AT91SAM9261-EK<br>&gt; development board working. alsa-lib and alsa-util=
s, version 1.0.12 are currently<br>&gt; installed.<br>&gt; <br>&gt; # apl=
ay -l shows that the audio chip is recognized as a playback device (and h=
as a<br>&gt; driver).<br>&gt; # aplay -L fails; there aren't any PCM devi=
ces configured.<br>&gt; # alsaconf fails too.<br>&gt; <br>&gt; We can't s=
eem to find .conf files for any Atmel chips among the Alsa docs and files=
.<br>&gt; <br>&gt; I assume the missing .conf file is the issue. Has anyo=
ne been successful with this?<br><br>Basically it should work even withou=
t the dedicated card's *.conf file<br>as alsa-lib takes pcm/default.conf.=
  How did you install alsa-lib and<br>co?<br><br><br>Takashi<br><br>-----=
--------------------------------------------------------------------<br>U=
sing Tomcat but need to do more? Need to support web services, security?<=
br>Get stuff done quickly with pre-integrated technology to make your job=
 easier.<br>Download IBM WebSphere
 Application Server v.1.0.1 based on Apache Geronimo<br>http://sel.as-us.=
falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057&amp;dat=3D1216=
42<br>_______________________________________________<br>Alsa-devel maili=
ng list<br>Alsa-devel@lists.sourceforge.net<br>https://lists.sourceforge.=
net/lists/listinfo/alsa-devel<br></blockquote><br><p>&#32;

<hr size=3D1>Don't be flakey. <a href=3D"http://us.rd.yahoo.com/evt=3D439=
09/*http://mobile.yahoo.com/mail">Get Yahoo! Mail for Mobile</a> and <br>=
<a href=3D"http://us.rd.yahoo.com/evt=3D43909/*http://mobile.yahoo.com/ma=
il">always stay connected</a> to friends.
--0-97026648-1170786078=:63422--


--===============0968477669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0968477669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0968477669==--

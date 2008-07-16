From: Landis McGauhey <b3zdomny@hotmail.com>
Subject: Re: is this card supported by ALSA?
Date: Wed, 16 Jul 2008 13:15:19 -0700
Message-ID: <BLU137-W701C780DA17174DEA342E958F0@phx.gbl>
References: <BLU137-W51E7DF3E0152023F07FC0C958F0@phx.gbl>
	<487E42ED.7050000@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0353188262=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <487E42ED.7050000@keyaccess.nl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, devel <alsa-devel@alsa-project.org>, alsa@sc8-sf-spam2.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============0353188262==
Content-Type: multipart/alternative;
	boundary="_7268d7d8-eb1b-4f15-84d0-1ccdfbb3ae44_"

--_7268d7d8-eb1b-4f15-84d0-1ccdfbb3ae44_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




> Date: Wed=2C 16 Jul 2008 20:50:21 +0200
> From: rene.herman@keyaccess.nl
> To: b3zdomny@hotmail.com
> CC: tiwai@suse.de=3B alsa-user@lists.sourceforge.net=3B alsa-devel@alsa-p=
roject.org=3B alsa@sc8-sf-spam2.sourceforge.net
> Subject: Re: [Alsa-user] is this card supported by ALSA?
>=20
> On 16-07-08 20:00=2C Landis McGauhey wrote:
>=20
> > OK=2C this is interesting:
> >=20
> > # patch -p1 -r < ens1371-ac97_reset_hack.diff=3D
> > bash:ens1371-ac97_reset_hack.diff: No such file or directory
> >=20
> > # patch -p1 -r < ens1371-ac97.diff
> > bash: ens1371-ac97.diff: No such file or directory
> >=20
> > Go figure.
>=20
> Of course. You've done this a number of times now=2C so I took for grante=
d=20
> that by now you'd understand to put in the path yourself. You saved=20
> these diff's from earlier mssages.
>=20
> > Attached are two high-res pix of the card. The smallest chips were
> > just too darned small for me to read the printing=3B maybe you can
> > magnify the pix and make something of them.
>=20
> A CT4730. You have an onboard amp (and it's disabled -- setting both the=
=20
> jumpers to the SPK position enables it but keeping it disabled is better=
=20
> if you don't really need it=3B these opamps suck).
>=20
> Moreover=2C the AC97 codec seems integrated in the EV1938. Just found a=20
> patch for FreeBSD following up a similar report for your card. Will look=
=20
> at it tomorrow.
>=20
> Rene.


OK=2C thanks!  As for the "patch -p1 -r" commands=2C I see.  I already had =
sent the diff's to the recycle bin=2C so following your message=2C I restor=
ed them and then ran the commands again with the paths.  They erred out wit=
h a complaint that "option requires an argument -- r".  I'm reading the man=
ual now=2C I'll figure it out=2C you go get some sleep!

as always=2C many thanks and best regards=2C

Landis
 =20
_________________________________________________________________
Time for vacation? WIN what you need- enter now!
http://www.gowindowslive.com/summergiveaway/?ocid=3Dtag_jlyhm=

--_7268d7d8-eb1b-4f15-84d0-1ccdfbb3ae44_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
FONT-SIZE: 10pt=3B
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class=3D'hmmessage'>
<br><br>&gt=3B Date: Wed=2C 16 Jul 2008 20:50:21 +0200<br>&gt=3B From: rene=
.herman@keyaccess.nl<br>&gt=3B To: b3zdomny@hotmail.com<br>&gt=3B CC: tiwai=
@suse.de=3B alsa-user@lists.sourceforge.net=3B alsa-devel@alsa-project.org=
=3B alsa@sc8-sf-spam2.sourceforge.net<br>&gt=3B Subject: Re: [Alsa-user] is=
 this card supported by ALSA?<br>&gt=3B <br>&gt=3B On 16-07-08 20:00=2C Lan=
dis McGauhey wrote:<br>&gt=3B <br>&gt=3B &gt=3B OK=2C this is interesting:<=
br>&gt=3B &gt=3B <br>&gt=3B &gt=3B # patch -p1 -r &lt=3B ens1371-ac97_reset=
_hack.diff=3D<br>&gt=3B &gt=3B bash:ens1371-ac97_reset_hack.diff: No such f=
ile or directory<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B # patch -p1 -r &lt=3B e=
ns1371-ac97.diff<br>&gt=3B &gt=3B bash: ens1371-ac97.diff: No such file or =
directory<br>&gt=3B &gt=3B <br>&gt=3B &gt=3B Go figure.<br>&gt=3B <br>&gt=
=3B Of course. You've done this a number of times now=2C so I took for gran=
ted <br>&gt=3B that by now you'd understand to put in the path yourself. Yo=
u saved <br>&gt=3B these diff's from earlier mssages.<br>&gt=3B <br>&gt=3B =
&gt=3B Attached are two high-res pix of the card. The smallest chips were<b=
r>&gt=3B &gt=3B just too darned small for me to read the printing=3B maybe =
you can<br>&gt=3B &gt=3B magnify the pix and make something of them.<br>&gt=
=3B <br>&gt=3B A CT4730. You have an onboard amp (and it's disabled -- sett=
ing both the <br>&gt=3B jumpers to the SPK position enables it but keeping =
it disabled is better <br>&gt=3B if you don't really need it=3B these opamp=
s suck).<br>&gt=3B <br>&gt=3B Moreover=2C the AC97 codec seems integrated i=
n the EV1938. Just found a <br>&gt=3B patch for FreeBSD following up a simi=
lar report for your card. Will look <br>&gt=3B at it tomorrow.<br>&gt=3B <b=
r>&gt=3B Rene.<br><br><br>OK=2C thanks!&nbsp=3B As for the "patch -p1 -r" c=
ommands=2C I see.&nbsp=3B I already had sent the diff's to the recycle bin=
=2C so following your message=2C I restored them and then ran the commands =
again with the paths.&nbsp=3B They erred out with a complaint that "option =
requires an argument -- r".&nbsp=3B I'm reading the manual now=2C I'll figu=
re it out=2C you go get some sleep!<br><br>as always=2C many thanks and bes=
t regards=2C<br><br>Landis<br>  <br /><hr />Time for vacation? WIN what you=
 need. <a href=3D'http://www.gowindowslive.com/summergiveaway/?ocid=3Dtag_j=
lyhm' target=3D'_new'>Enter Now!</a></body>
</html>=

--_7268d7d8-eb1b-4f15-84d0-1ccdfbb3ae44_--


--===============0353188262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0353188262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============0353188262==--

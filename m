From: Landis McGauhey <b3zdomny@hotmail.com>
Subject: Re: is this card supported by ALSA?
Date: Fri, 18 Jul 2008 10:46:34 -0700
Message-ID: <BLU137-W90D8E7DA2FF2B8A04B42795890@phx.gbl>
References: <BLU137-W51E7DF3E0152023F07FC0C958F0@phx.gbl>
	<487E42ED.7050000@keyaccess.nl> <4880C552.50706@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1952571534=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <4880C552.50706@keyaccess.nl>
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

--===============1952571534==
Content-Type: multipart/alternative;
	boundary="_fe1c8cb5-6a1f-4a05-b871-1b24750bce07_"

--_fe1c8cb5-6a1f-4a05-b871-1b24750bce07_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




> Date: Fri=2C 18 Jul 2008 18:31:14 +0200
> From: rene.herman@keyaccess.nl
> To: b3zdomny@hotmail.com
> CC: tiwai@suse.de=3B alsa-user@lists.sourceforge.net=3B alsa-devel@alsa-p=
roject.org=3B alsa@sc8-sf-spam2.sourceforge.net
> Subject: Re: [Alsa-user] is this card supported by ALSA?
>=20
> On 16-07-08 20:50=2C Rene Herman wrote:
>=20
> > Moreover=2C the AC97 codec seems integrated in the EV1938. Just found a
> > patch for FreeBSD following up a similar report for your card. Will
> > look at it tomorrow.
>=20
> Nothing interesting. Ready to give up on this. There is a communication=20
> problem with the AC97 codec and that's the kind of thing which is almost=
=20
> impossible to debug via email=2C especially since apparently this is not=
=20
> different for the OSS driver=3B it's also not getting back a valid ID at=
=20
> least.
>=20
> I do wonder a bit if that might mean that the only difference is the=20
> ALSA "mute by default" behaviour. The attached patch does away with the=20
> default muting of the AC97 controls. You'd apply it as before (after=20
> reverting the previous 2 patches as written earlier)=2C "make"=2C "make=20
> modules_install" and then load snd-ens1371:
>=20
> # modprobe -r es1371
> # modprobe -r snd-ens1371
> # modprobe snd-ens1371
>=20
> and then "aplay foo.wav" (without first starting alsamixer). If no=20
> sound=2C adjust levels in alsamixer=2C retry aplay=2C if no sound=2C rebo=
ot (to=20
> get the card to a startup state) and retry after the above 3 modprobes.
>=20
> If for some unimagineable reason you still need "alsaconf" instead of=20
> just modprobe snd-ens1371 to load the driver=2C adjust accordingly. Have=
=20
> no idea why that would be the case.
>=20
> If as expected you still have no sound I give up. Stared at this stuff=2C=
=20
> but am not seeing anything stand out. If you ever decide to replace the=20
> card and can find an ALSA developer in your neighbourhood to donate it=20
> to that could be interesting. I've never seen an EV1938 locally here=3B=20
> distribution is probably limited to the US.
>=20
> Rene.

Thank you so much=2C Rene.  I will do these procedures=2C but in the meanti=
me I have OSS in full swing.  Do I need to do something to turn off or unin=
stall OSS before proceeding with the above procedures?  Thank you.

Best regards from North-Central California where the forest fires are incre=
asingly under control and our skies are finally more clear=2C

Landis

_________________________________________________________________
Time for vacation? WIN what you need- enter now!
http://www.gowindowslive.com/summergiveaway/?ocid=3Dtag_jlyhm=

--_fe1c8cb5-6a1f-4a05-b871-1b24750bce07_
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
<br><br>&gt=3B Date: Fri=2C 18 Jul 2008 18:31:14 +0200<br>&gt=3B From: rene=
.herman@keyaccess.nl<br>&gt=3B To: b3zdomny@hotmail.com<br>&gt=3B CC: tiwai=
@suse.de=3B alsa-user@lists.sourceforge.net=3B alsa-devel@alsa-project.org=
=3B alsa@sc8-sf-spam2.sourceforge.net<br>&gt=3B Subject: Re: [Alsa-user] is=
 this card supported by ALSA?<br>&gt=3B <br>&gt=3B On 16-07-08 20:50=2C Ren=
e Herman wrote:<br>&gt=3B <br>&gt=3B &gt=3B Moreover=2C the AC97 codec seem=
s integrated in the EV1938. Just found a<br>&gt=3B &gt=3B patch for FreeBSD=
 following up a similar report for your card. Will<br>&gt=3B &gt=3B look at=
 it tomorrow.<br>&gt=3B <br>&gt=3B Nothing interesting. Ready to give up on=
 this. There is a communication <br>&gt=3B problem with the AC97 codec and =
that's the kind of thing which is almost <br>&gt=3B impossible to debug via=
 email=2C especially since apparently this is not <br>&gt=3B different for =
the OSS driver=3B it's also not getting back a valid ID at <br>&gt=3B least=
.<br>&gt=3B <br>&gt=3B I do wonder a bit if that might mean that the only d=
ifference is the <br>&gt=3B ALSA "mute by default" behaviour. The attached =
patch does away with the <br>&gt=3B default muting of the AC97 controls. Yo=
u'd apply it as before (after <br>&gt=3B reverting the previous 2 patches a=
s written earlier)=2C "make"=2C "make <br>&gt=3B modules_install" and then =
load snd-ens1371:<br>&gt=3B <br>&gt=3B # modprobe -r es1371<br>&gt=3B # mod=
probe -r snd-ens1371<br>&gt=3B # modprobe snd-ens1371<br>&gt=3B <br>&gt=3B =
and then "aplay foo.wav" (without first starting alsamixer). If no <br>&gt=
=3B sound=2C adjust levels in alsamixer=2C retry aplay=2C if no sound=2C re=
boot (to <br>&gt=3B get the card to a startup state) and retry after the ab=
ove 3 modprobes.<br>&gt=3B <br>&gt=3B If for some unimagineable reason you =
still need "alsaconf" instead of <br>&gt=3B just modprobe snd-ens1371 to lo=
ad the driver=2C adjust accordingly. Have <br>&gt=3B no idea why that would=
 be the case.<br>&gt=3B <br>&gt=3B If as expected you still have no sound I=
 give up. Stared at this stuff=2C <br>&gt=3B but am not seeing anything sta=
nd out. If you ever decide to replace the <br>&gt=3B card and can find an A=
LSA developer in your neighbourhood to donate it <br>&gt=3B to that could b=
e interesting. I've never seen an EV1938 locally here=3B <br>&gt=3B distrib=
ution is probably limited to the US.<br>&gt=3B <br>&gt=3B Rene.<br><br>Than=
k you so much=2C Rene.&nbsp=3B I will do these procedures=2C but in the mea=
ntime I have OSS in full swing.&nbsp=3B Do I need to do something to turn o=
ff or uninstall OSS before proceeding with the above procedures?&nbsp=3B Th=
ank you.<br><br>Best regards from North-Central California where the forest=
 fires are increasingly under control and our skies are finally more clear=
=2C<br><br>Landis<br><br /><hr />Time for vacation? WIN what you need. <a h=
ref=3D'http://www.gowindowslive.com/summergiveaway/?ocid=3Dtag_jlyhm' targe=
t=3D'_new'>Enter Now!</a></body>
</html>=

--_fe1c8cb5-6a1f-4a05-b871-1b24750bce07_--


--===============1952571534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1952571534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============1952571534==--

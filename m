From: Landis McGauhey <b3zdomny@hotmail.com>
Subject: Re: is this card supported by ALSA?
Date: Tue, 15 Jul 2008 08:38:37 -0700
Message-ID: <BLU137-W402750FD6BFEAFA9165812958C0@phx.gbl>
References: <BLU137-W526424D3E9A79DA1437849959A0@phx.gbl>
	<48701633.7040601@keyaccess.nl>	<loom.20080708T141841-614@post.gmane.org>
	<4873AB3B.1070403@keyaccess.nl>	<4873CED6.2040704@keyaccess.nl>
	<4873D033.8010604@keyaccess.nl>
	<BLU137-W434EEB6A014E95FD1E225C95910@phx.gbl>
	<48769D84.1050102@keyaccess.nl>
	<BLU137-W51DDE8E1756609BBE5CF7F95910@phx.gbl>
	<4876A0DE.2050803@keyaccess.nl>
	<BLU137-W23A4FF48E97AC32476FD6095900@phx.gbl>
	<4876AC75.2010305@keyaccess.nl>
	<BLU137-W541C318CC744C4BF6461DE95900@phx.gbl>	<4876B329.80700@keyaccess.nl>
	<BLU137-W3234537335E7D553F03AF195900@phx.gbl>
	<48798CF7.6020303@keyaccess.nl>	<loom.20080714T232812-533@post.gmane.org>
	<487BEB3D.6000209@keyaccess.nl>	<s5hvdz7uwb6.wl%tiwai@suse.de>
	<s5hod4zxm9v.wl%tiwai@suse.de> <487CB73D.4050808@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2145659147=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <487CB73D.4050808@keyaccess.nl>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, devel <alsa-devel@alsa-project.org>, ALSA@sc8-sf-spam2.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============2145659147==
Content-Type: multipart/alternative;
	boundary="_7339e849-ee0d-4a5b-81ba-ba29d8221b54_"

--_7339e849-ee0d-4a5b-81ba-ba29d8221b54_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable




> Date: Tue=2C 15 Jul 2008 16:42:05 +0200
> From: rene.herman@keyaccess.nl
> To: b3zdomny@hotmail.com
> CC: tiwai@suse.de=3B alsa-user@lists.sourceforge.net=3B alsa-devel@alsa-p=
roject.org
> Subject: Re: [Alsa-user] is this card supported by ALSA?
>=20
<snip>

OK=2C ran alsaconf and it detected the card and finished without error.  Pl=
us=2C when it loaded the driver=2C there was a loud "click" in the speakers=
.  I don't think that has happened before.

Then=2C the audio tests:

# speaker-test

speaker-test 1.0.16

Playback device is default
Stream parameters are 48000Hz=2C S16_LE=2C 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2048 to 16384
Period size range from 1024 to 1024
Using max buffer size 16384
Periods =3D 4
was set period_size =3D 1024
was set buffer_size =3D 16384
 0 - Front Left
Time per period =3D 2.664700
 0 - Front Left

but with silence.

# aplay /usr/share/sounds/startup3.wav
Playing WAVE '/usr/share/sounds/startup3.wav' : Signed 16 bit Little Endian=
=2C Rate 44100 Hz=2C Stereo
aplay: set_params:1017: unable to install sw params:
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 940
xfer_align: 940
silence_threshold: 0
silence_size: 0
boundary: 986447872

but with silence.

tried running audacity.  according to kde system guard process table=2C aud=
acity was running=2C but it did not appear on the screen.   Used kde system=
 guard process table to kill audacity.

ran xmms.  song played without error=2C but with silence.

Now I am going to do the blacklisting you suggested and reboot to see if th=
at makes any difference.  I will let you know what happens.

Landis=20

_________________________________________________________________
The i=92m Talkaton. Can 30-days of conversation change the world?
http://www.imtalkathon.com/?source=3DEML_WLH_Talkathon_ChangeWorld=

--_7339e849-ee0d-4a5b-81ba-ba29d8221b54_
Content-Type: text/html; charset="Windows-1252"
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
<br><br>&gt=3B Date: Tue=2C 15 Jul 2008 16:42:05 +0200<br>&gt=3B From: rene=
.herman@keyaccess.nl<br>&gt=3B To: b3zdomny@hotmail.com<br>&gt=3B CC: tiwai=
@suse.de=3B alsa-user@lists.sourceforge.net=3B alsa-devel@alsa-project.org<=
br>&gt=3B Subject: Re: [Alsa-user] is this card supported by ALSA?<br>&gt=
=3B <br>&lt=3Bsnip&gt=3B<br><br>OK=2C ran alsaconf and it detected the card=
 and finished without error.&nbsp=3B Plus=2C when it loaded the driver=2C t=
here was a loud "click" in the speakers.&nbsp=3B I don't think that has hap=
pened before.<br><br>Then=2C the audio tests:<br><br># speaker-test<br><br>=
speaker-test 1.0.16<br><br>Playback device is default<br>Stream parameters =
are 48000Hz=2C S16_LE=2C 1 channels<br>Using 16 octaves of pink noise<br>Ra=
te set to 48000Hz (requested 48000Hz)<br>Buffer size range from 2048 to 163=
84<br>Period size range from 1024 to 1024<br>Using max buffer size 16384<br=
>Periods =3D 4<br>was set period_size =3D 1024<br>was set buffer_size =3D 1=
6384<br>&nbsp=3B0 - Front Left<br>Time per period =3D 2.664700<br>&nbsp=3B0=
 - Front Left<br><br>but with silence.<br><br># aplay /usr/share/sounds/sta=
rtup3.wav<br>Playing WAVE '/usr/share/sounds/startup3.wav' : Signed 16 bit =
Little Endian=2C Rate 44100 Hz=2C Stereo<br>aplay: set_params:1017: unable =
to install sw params:<br>start_mode: DATA<br>xrun_mode: STOP<br>tstamp_mode=
: NONE<br>period_step: 1<br>sleep_min: 0<br>avail_min: 940<br>xfer_align: 9=
40<br>silence_threshold: 0<br>silence_size: 0<br>boundary: 986447872<br><br=
>but with silence.<br><br>tried running audacity.&nbsp=3B according to kde =
system guard process table=2C audacity was running=2C but it did not appear=
 on the screen.&nbsp=3B&nbsp=3B Used kde system guard process table to kill=
 audacity.<br><br>ran xmms.&nbsp=3B song played without error=2C but with s=
ilence.<br><br>Now I am going to do the blacklisting you suggested and rebo=
ot to see if that makes any difference.&nbsp=3B I will let you know what ha=
ppens.<br><br>Landis <br><br /><hr />The i=92m Talkaton. Can 30-days of con=
versation change the world? <a href=3D'http://www.imtalkathon.com/?source=
=3DEML_WLH_Talkathon_ChangeWorld' target=3D'_new'>Find out now.</a></body>
</html>=

--_7339e849-ee0d-4a5b-81ba-ba29d8221b54_--


--===============2145659147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============2145659147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============2145659147==--

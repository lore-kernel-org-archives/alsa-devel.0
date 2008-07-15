From: Landis McGauhey <b3zdomny@hotmail.com>
Subject: Re: is this card supported by ALSA?
Date: Tue, 15 Jul 2008 08:25:07 -0700
Message-ID: <BLU137-W34E0AFAD1183AF146DF6F8958C0@phx.gbl>
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
Content-Type: multipart/mixed; boundary="===============1165620187=="
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

--===============1165620187==
Content-Type: multipart/alternative;
	boundary="_dc68107b-61d5-4964-8178-3db7bbc12762_"

--_dc68107b-61d5-4964-8178-3db7bbc12762_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




> Date: Tue=2C 15 Jul 2008 16:42:05 +0200
> From: rene.herman@keyaccess.nl
> To: b3zdomny@hotmail.com
> CC: tiwai@suse.de=3B alsa-user@lists.sourceforge.net=3B alsa-devel@alsa-p=
roject.org
> Subject: Re: [Alsa-user] is this card supported by ALSA?
<snip>

OK=2C interim report:

the patch=2C the make=2C the makemodules=2C and the modprobes all proceeded=
 without error.

ran alsamixer and verified all functions were unmuted and raised

then=2C the audio-test attempts:

# aplay /usr/share/sounds/startup3.wav
ALSA lib pcm_dmix.c:864:(snd_pcm_dmix_open) unable to open slave
aplay: main:564: audio open error: No such file or directory

# speaker-test

speaker-test 1.0.16

Playback device is default
Stream parameters are 48000Hz=2C S16_LE=2C 1 channels
Using 16 octaves of pink noise
ALSA lib pcm_dmix.c:864:(snd_pcm_dmix_open) unable to open slave
Playback open error: -2=2CNo such file or directory


So now I'm going to run alsaconf and see if that changes things.  I'll let =
you know what happens.

Landis

_________________________________________________________________
Use video conversation to talk face-to-face with Windows Live Messenger.
http://www.windowslive.com/messenger/connect_your_way.html?ocid=3DTXT_TAGLM=
_WL_Refresh_messenger_video_072008=

--_dc68107b-61d5-4964-8178-3db7bbc12762_
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
<br><br>&gt=3B Date: Tue=2C 15 Jul 2008 16:42:05 +0200<br>&gt=3B From: rene=
.herman@keyaccess.nl<br>&gt=3B To: b3zdomny@hotmail.com<br>&gt=3B CC: tiwai=
@suse.de=3B alsa-user@lists.sourceforge.net=3B alsa-devel@alsa-project.org<=
br>&gt=3B Subject: Re: [Alsa-user] is this card supported by ALSA?<br>&lt=
=3Bsnip&gt=3B<br><br>OK=2C interim report:<br><br>the patch=2C the make=2C =
the makemodules=2C and the modprobes all proceeded without error.<br><br>ra=
n alsamixer and verified all functions were unmuted and raised<br><br>then=
=2C the audio-test attempts:<br><br># aplay /usr/share/sounds/startup3.wav<=
br>ALSA lib pcm_dmix.c:864:(snd_pcm_dmix_open) unable to open slave<br>apla=
y: main:564: audio open error: No such file or directory<br><br># speaker-t=
est<br><br>speaker-test 1.0.16<br><br>Playback device is default<br>Stream =
parameters are 48000Hz=2C S16_LE=2C 1 channels<br>Using 16 octaves of pink =
noise<br>ALSA lib pcm_dmix.c:864:(snd_pcm_dmix_open) unable to open slave<b=
r>Playback open error: -2=2CNo such file or directory<br><br><br>So now I'm=
 going to run alsaconf and see if that changes things.&nbsp=3B I'll let you=
 know what happens.<br><br>Landis<br><br /><hr />Use video conversation to =
talk face-to-face with Windows Live Messenger. <a href=3D'http://www.window=
slive.com/messenger/connect_your_way.html?ocid=3DTXT_TAGLM_WL_Refresh_messe=
nger_video_072008' target=3D'_new'>Get started.</a></body>
</html>=

--_dc68107b-61d5-4964-8178-3db7bbc12762_--


--===============1165620187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1165620187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============1165620187==--

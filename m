From: Landis McGauhey <b3zdomny@hotmail.com>
Subject: Re: [alsa-devel]  is this card supported by ALSA?
Date: Wed, 16 Jul 2008 05:11:38 -0700
Message-ID: <BLU137-W311697CF83DD975CC9DCD1958F0@phx.gbl>
References: <BLU137-W110C592A46588437241F1A958C0@phx.gbl>
	<487DBC70.1000307@keyaccess.nl>  <s5hk5fm1414.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1915790569=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <s5hk5fm1414.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--===============1915790569==
Content-Type: multipart/alternative;
	boundary="_cc1dd036-3037-4df7-ae32-86db4f0dd48d_"

--_cc1dd036-3037-4df7-ae32-86db4f0dd48d_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




> Date: Wed=2C 16 Jul 2008 13:07:03 +0200
> From: tiwai@suse.de
> To: rene.herman@keyaccess.nl
> CC: b3zdomny@hotmail.com=3B alsa-user@lists.sourceforge.net=3B alsa-devel=
@alsa-project.org
> Subject: Re: [alsa-devel] [Alsa-user] is this card supported by ALSA?
<snip>
>=20
> Well=2C from The fact that this is repeated numbers=2C I guess this is a
> result of (still) wrong codec communication.  Likely the previous
> number remains to the next read.
>=20
> I guess my patch did something wrong=2C too -- at least=2C waiting for SR=
C
> up/down shouldn't be with sleep but a busy loop.
>=20
<snip>
>=20
> Yeah=2C the kernel messages are really important.  Some messages should
> appear if the codec access timeout occured.  Then it can explains why
> zero is read for many registers.
>=20
>=20
> Takashi

Thank you very much for your patience and persistence=2C Takashi.  If we ca=
n arrive at a solution it should benefit the entire community as this card=
=2C unless I'm mistaken=2C is very common.

best regards=2C

Landis

PS -- to Rene & Takashi:  today I am taking delivery of an external USB sou=
nd card for my old laptop with WinXP (the headphone socket completely wore =
out from use=2C the plug falls right out of it!).  Wouldn't it be ironic if=
 the new USB unit works with ALSA here on my desktop?!?

_________________________________________________________________
Use video conversation to talk face-to-face with Windows Live Messenger.
http://www.windowslive.com/messenger/connect_your_way.html?ocid=3DTXT_TAGLM=
_WL_Refresh_messenger_video_072008=

--_cc1dd036-3037-4df7-ae32-86db4f0dd48d_
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
<br><br>&gt=3B Date: Wed=2C 16 Jul 2008 13:07:03 +0200<br>&gt=3B From: tiwa=
i@suse.de<br>&gt=3B To: rene.herman@keyaccess.nl<br>&gt=3B CC: b3zdomny@hot=
mail.com=3B alsa-user@lists.sourceforge.net=3B alsa-devel@alsa-project.org<=
br>&gt=3B Subject: Re: [alsa-devel] [Alsa-user] is this card supported by A=
LSA?<br>&lt=3Bsnip&gt=3B<br>&gt=3B <br>&gt=3B Well=2C from The fact that th=
is is repeated numbers=2C I guess this is a<br>&gt=3B result of (still) wro=
ng codec communication.  Likely the previous<br>&gt=3B number remains to th=
e next read.<br>&gt=3B <br>&gt=3B I guess my patch did something wrong=2C t=
oo -- at least=2C waiting for SRC<br>&gt=3B up/down shouldn't be with sleep=
 but a busy loop.<br>&gt=3B <br>&lt=3Bsnip&gt=3B<br>&gt=3B <br>&gt=3B Yeah=
=2C the kernel messages are really important.  Some messages should<br>&gt=
=3B appear if the codec access timeout occured.  Then it can explains why<b=
r>&gt=3B zero is read for many registers.<br>&gt=3B <br>&gt=3B <br>&gt=3B T=
akashi<br><br>Thank you very much for your patience and persistence=2C Taka=
shi.&nbsp=3B If we can arrive at a solution it should benefit the entire co=
mmunity as this card=2C unless I'm mistaken=2C is very common.<br><br>best =
regards=2C<br><br>Landis<br><br>PS -- to Rene &amp=3B Takashi:&nbsp=3B toda=
y I am taking delivery of an external USB sound card for my old laptop with=
 WinXP (the headphone socket completely wore out from use=2C the plug falls=
 right out of it!).&nbsp=3B Wouldn't it be ironic if the new USB unit works=
 with ALSA here on my desktop?!?<br><br /><hr />Use video conversation to t=
alk face-to-face with Windows Live Messenger. <a href=3D'http://www.windows=
live.com/messenger/connect_your_way.html?ocid=3DTXT_TAGLM_WL_Refresh_messen=
ger_video_072008' target=3D'_new'>Get started.</a></body>
</html>=

--_cc1dd036-3037-4df7-ae32-86db4f0dd48d_--


--===============1915790569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1915790569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============1915790569==--

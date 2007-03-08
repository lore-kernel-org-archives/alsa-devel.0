From: Julian Cable <julian_cable@yahoo.com>
Subject: amixer bug
Date: Thu, 8 Mar 2007 11:58:06 -0800 (PST)
Message-ID: <320082.14718.qm@web35607.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0763884184=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============0763884184==
Content-Type: multipart/alternative; boundary="0-892848063-1173383886=:14718"

--0-892848063-1173383886=:14718
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0A  I defined a new SNDRV_CTL_ELEM_IFACE_MIXER in the hdsp driver and t=
ried to use it from amixer and got some strange behaviour. I set the contro=
l up as follows:=0A=0Astatic int snd_hdsp_info_dds_offset(struct snd_kcontr=
ol *kcontrol, struct snd_ctl_elem_info *uinfo)=0A{=0A    uinfo->type =3D SN=
DRV_CTL_ELEM_TYPE_INTEGER;=0A    uinfo->count =3D 1;=0A    uinfo->value.int=
eger.min =3D -100;=0A    uinfo->value.integer.max =3D 100;=0A    return 0;=
=0A}=0A=0A=0Aamixer correctly indicates that the default 0 value is equival=
ent to 50%. If I set the value using the % syntax all is well:=0A=0A0% -> -=
100=0A25% -> -50=0A50% -> 0=0A100% -> 100=0A=0ABut if I use the absolute no=
tation then it rejects negative numbers.=0A=0AIf I use the incremental nota=
tion something even stranger happens. If the current value is positive, all=
 is well. If the current value is +5 and I decrement by 10 then it correctl=
y sets to -5, but if the current value is -5 and I decrement by 10 it sets =
the value to +100 (ie the maximum).=0A=0ASo there are two problems:=0A=0A1)=
 negative numbers are not allowed on the command line=0A2) decrementing doe=
sn't work when the current value is negative.=0A=0AI tried to raise this as=
 a bug but I've forgotten my password and bugzilla refuses to send a remind=
er to my registered account (this one).=0Acheers=0A=0AJulian=0A=0A=0A=0A=0A=
=09=0A=09=0A=09=09=0A______________________________________________________=
_____ =0ANew Yahoo! Mail is the ultimate force in competitive emailing. Fin=
d out more at the Yahoo! Mail Championships. Plus: play games and win prize=
s. =0Ahttp://uk.rd.yahoo.com/evt=3D44106/*http://mail.yahoo.net/uk 
--0-892848063-1173383886=:14718
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><div>Hi,<br>&nbsp; I defined a new SNDRV_CTL_ELEM_IFACE_MIX=
ER in the hdsp driver and tried to use it from amixer and got some strange =
behaviour. I set the control up as follows:<br><br>static int snd_hdsp_info=
_dds_offset(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)=
<br>{<br>&nbsp;&nbsp;&nbsp; uinfo-&gt;type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;=
<br>&nbsp;&nbsp;&nbsp; uinfo-&gt;count =3D 1;<br>&nbsp;&nbsp;&nbsp; uinfo-&=
gt;value.integer.min =3D -100;<br>&nbsp;&nbsp;&nbsp; uinfo-&gt;value.intege=
r.max =3D 100;<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br><br>amixer corre=
ctly indicates that the default 0 value is equivalent to 50%. If I set the =
value using the % syntax all is well:<br><br>0% -&gt; -100<br>25% -&gt; -50=
<br>50% -&gt; 0<br>100% -&gt; 100<br><br>But if I use the absolute notation=
 then it rejects negative
 numbers.<br><br>If I use the incremental notation something even stranger =
happens. If the current value is positive, all is well. If the current valu=
e is +5 and I decrement by 10 then it correctly sets to -5, but if the curr=
ent value is -5 and I decrement by 10 it sets the value to +100 (ie the max=
imum).<br><br>So there are two problems:<br><br>1) negative numbers are not=
 allowed on the command line<br>2) decrementing doesn't work when the curre=
nt value is negative.<br><br>I tried to raise this as a bug but I've forgot=
ten my password and bugzilla refuses to send a reminder to my registered ac=
count (this one).<br>cheers<br><br>Julian<br></div></div><br>=0A=09=09<hr s=
ize=3D1> =0AWhat kind of emailer are you? Find out today - get a free analy=
sis of your email personality. Take the quiz at the <a href=3D"http://uk.rd=
.yahoo.com/mail/uk/taglines/default/championships/quiz/*http://uk.rd.yahoo.=
com/evt=3D44106/*http://mail.yahoo.net/uk/">Yahoo! Mail Championship</a>.</=
body></html>
--0-892848063-1173383886=:14718--


--===============0763884184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0763884184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0763884184==--

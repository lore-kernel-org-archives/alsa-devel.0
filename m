From: Niels Christian =?ISO-8859-1?Q?=D8rgaard?= <nc@blahzone.dk>
Subject: Hoping someone can help me (Assertion `frames <=
 snd_pcm_mmap_avail(pcm)' failed.)
Date: Wed, 10 Mar 2004 18:32:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078939970.13994.28.camel@Nc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AyOqO1eftTdqHX3ZswLu"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-AyOqO1eftTdqHX3ZswLu
Content-Type: multipart/alternative; boundary="=-lBT/Y44JvwLBqUOePOdD"


--=-lBT/Y44JvwLBqUOePOdD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey ....

This is the nth day I'm stuck reading the ALSA-documentation over and
over again, and I'm at a loss figuring out whats wrong.

Basically, I have a running thread capturing data from an ALSA-device,
and within useconds I get: "samptest: pcm.c:5889: snd_pcm_mmap_commit:
Assertion `frames <=3D snd_pcm_mmap_avail(pcm)' failed." (samptest is the
name of my executable)

The reason for me being so confused is that this occures at the call
"snd_pcm_readi(snd_pcm_t *, void *, snd_pcm_uframes_t )", which for
starters ain't mmap :)  I use "snd_pcm_delay(snd_pcm_t *,
snd_pcm_sframes_t *)" to verify that there is sufficient data in the
queue, before calling readi(), since I halfway expected that the above
error in some obscure way was from me trying to read too much from the
queue, but this one just informs me that there are the 385 samples
(24ms), which happens to be the buffer-size (periods set to 4,
buffersize_near set to 48). I have tried to pass "385","48" and the
result of delay() as the amount, just to make sure.
I have found that if I increase my buffer-size to 3 times its current
level, I can avoid the above error (at least for the some seconds I
leave it running), but this incurs an unacceptably high latency. I
currently require that latency be kept quite low, and with OSS I have no
problem having a buffer-size ~=3D 6 usec. Unfortunately, I tend to get
overruns when I increase my buffer-size to a level where I do not get
the above error.

I hope someone can help me, or point me in the direction of a
documentation I can understand and use (honestly, too often I've found
that the documentation is "insufficient" - at least for me)

Cheers,
 /Niels Chr.

--=20

My sense of self is fragile as it is without someone stealing me from me.

--=-lBT/Y44JvwLBqUOePOdD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; CHARSET=3DUTF-8">
  <META NAME=3D"GENERATOR" CONTENT=3D"GtkHTML/3.0.9">
</HEAD>
<BODY>
Hey ....<BR>
<BR>
This is the nth day I'm stuck reading the ALSA-documentation over and over =
again, and I'm at a loss figuring out whats wrong.<BR>
<BR>
Basically, I have a running thread capturing data from an ALSA-device, and =
within useconds I get: &quot;samptest: pcm.c:5889: snd_pcm_mmap_commit: Ass=
ertion `frames &lt;=3D snd_pcm_mmap_avail(pcm)' failed.&quot; (samptest is =
the name of my executable)<BR>
<BR>
The reason for me being so confused is that this occures at the call &quot;=
<A HREF=3D"http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html=
#a25"><U>snd_pcm_readi</U></A>(<A HREF=3D"http://www.alsa-project.org/alsa-=
doc/alsa-lib/group___p_c_m.html#a19"><U>snd_pcm_t</U></A> *, void *, <A HRE=
F=3D"http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#a17">=
<U>snd_pcm_uframes_t</U></A> )&quot;, which for starters ain't mmap :)&nbsp=
; I use &quot;<A HREF=3D"http://www.alsa-project.org/alsa-doc/alsa-lib/grou=
p___p_c_m.html#a14"><U>snd_pcm_delay</U></A>(<A HREF=3D"http://www.alsa-pro=
ject.org/alsa-doc/alsa-lib/group___p_c_m.html#a19"><U>snd_pcm_t</U></A> *, =
<A HREF=3D"http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html=
#a18"><U>snd_pcm_sframes_t</U></A> *)&quot; to verify that there is suffici=
ent data in the queue, before calling <A HREF=3D"http://www.alsa-project.or=
g/alsa-doc/alsa-lib/group___p_c_m.html#a25"><U>readi</U></A>(), since I hal=
fway expected that the above error in some obscure way was from me trying t=
o read too much from the queue, but this one just informs me that there are=
 the 385 samples (24ms), which happens to be the buffer-size (periods set t=
o 4, buffersize_near set to 48). I have tried to pass &quot;385&quot;,&quot=
;48&quot; and the result of <A HREF=3D"http://www.alsa-project.org/alsa-doc=
/alsa-lib/group___p_c_m.html#a14"><U>delay</U></A>() as the amount, just to=
 make sure.<BR>
I have found that if I increase my buffer-size to 3 times its current level=
, I can avoid the above error (at least for the some seconds I leave it run=
ning), but this incurs an unacceptably high latency. I currently require th=
at latency be kept quite low, and with OSS I have no problem having a buffe=
r-size ~=3D 6 usec. Unfortunately, I tend to get overruns when I increase m=
y buffer-size to a level where I do not get the above error.<BR>
<BR>
I hope someone can help me, or point me in the direction of a documentation=
 I can understand and use (honestly, too often I've found that the document=
ation is &quot;insufficient&quot; - at least for me)<BR>
<BR>
Cheers,<BR>
 /Niels Chr.<BR>
<BR>
<TABLE CELLSPACING=3D"0" CELLPADDING=3D"0" WIDTH=3D"100%">
<TR>
<TD>
<PRE>--=20

My sense of self is fragile as it is without someone stealing me from me.</=
PRE>
</TD>
</TR>
</TABLE>

</BODY>
</HTML>

--=-lBT/Y44JvwLBqUOePOdD--

--=-AyOqO1eftTdqHX3ZswLu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAT1FBq9NfCmuAMosRAl/oAJ9WBv/c//Uf6VIkpVg4jy88WBIaCACfUOpw
Q7O+zSMc3G6xIBf0trUwrFg=
=pYL2
-----END PGP SIGNATURE-----

--=-AyOqO1eftTdqHX3ZswLu--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

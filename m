From: "Steve Finney" <sfinney@healthhero.com>
Subject: pcm_oss.c bug?
Date: Wed, 12 Apr 2006 19:06:02 -0600
Message-ID: <F23ABFFDB8261D40A6F6D30EA0148825308F5E@VS6.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C65E96.6F040D5C"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C65E96.6F040D5C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm totally new to ALSA, but I've encountered a situation where
snd_pcm_oss_get_formats() is returning ENOMEM, and =
snd_pcm_oss_set_format()
doesn't seem to handle it properly. Proposed patch for 1.0.11.rc5:

Signed-off-by: Steven Finney <sfinney@healthhero.com>

--- alsa-kernel/core/oss/pcm_oss.c.orig 2006-04-12 17:55:29.229269992 =
-0700
+++ alsa-kernel/core/oss/pcm_oss.c      2006-04-12 17:56:45.394691088 =
-0700
@@ -1242,6 +1242,8 @@ static int snd_pcm_oss_set_format(struct

        if (format !=3D AFMT_QUERY) {
                formats =3D snd_pcm_oss_get_formats(pcm_oss_file);
+               if (formats < 0)
+                       return formats;
                if (!(formats & format))
                        format =3D AFMT_U8;
                for (idx =3D 1; idx >=3D 0; --idx) {


------_=_NextPart_001_01C65E96.6F040D5C
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>pcm_oss.c bug?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I'm totally new to ALSA, but I've encountered a =
situation where<BR>
snd_pcm_oss_get_formats() is returning ENOMEM, and =
snd_pcm_oss_set_format()<BR>
doesn't seem to handle it properly. Proposed patch for 1.0.11.rc5:<BR>
<BR>
Signed-off-by: Steven Finney &lt;sfinney@healthhero.com&gt;<BR>
<BR>
--- alsa-kernel/core/oss/pcm_oss.c.orig 2006-04-12 17:55:29.229269992 =
-0700<BR>
+++ alsa-kernel/core/oss/pcm_oss.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2006-04-12 17:56:45.394691088 -0700<BR>
@@ -1242,6 +1242,8 @@ static int snd_pcm_oss_set_format(struct<BR>
<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (format !=3D AFMT_QUERY) =
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; formats =3D snd_pcm_oss_get_formats(pcm_oss_file);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (formats &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
formats;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; if (!(formats &amp; format))<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; format =
=3D AFMT_U8;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; for (idx =3D 1; idx &gt;=3D 0; --idx) {<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C65E96.6F040D5C--




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

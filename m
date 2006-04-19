From: "Steve Finney" <sfinney@healthhero.com>
Subject: /dev/dsp exclusive open?
Date: Wed, 19 Apr 2006 12:06:56 -0600
Message-ID: <F23ABFFDB8261D40A6F6D30EA0148825308F62@VS6.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C663DC.0BC8BBF0"
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

------_=_NextPart_001_01C663DC.0BC8BBF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In various docs, I thought I had seen references to the fact that
only one process should be able to open /dev/dsp (OSS). I'm running ALSA =
1.0.10rc1
(Linux kernel 2.6.14.3), and it appears as if it is possible to open
/dev/dsp twice (two separate processes), but the _third_ open will
return EBUSY. Is this a bug or a feature?

Thanks,
sf

------_=_NextPart_001_01C663DC.0BC8BBF0
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
<TITLE>/dev/dsp exclusive open?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>In various docs, I thought I had seen references to =
the fact that<BR>
only one process should be able to open /dev/dsp (OSS). I'm running ALSA =
1.0.10rc1<BR>
(Linux kernel 2.6.14.3), and it appears as if it is possible to open<BR>
/dev/dsp twice (two separate processes), but the _third_ open will<BR>
return EBUSY. Is this a bug or a feature?<BR>
<BR>
Thanks,<BR>
sf</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C663DC.0BC8BBF0--




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

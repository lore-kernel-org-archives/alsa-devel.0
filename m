From: "Nikhil Rao" <nikhil_p_rao@hotmail.com>
Subject: mmap and pcm plugin for format conversion
Date: Sun, 27 Nov 2005 18:39:49 -0800
Message-ID: <BAY103-DAV1354B536944C991A75631AC2480@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0025_01C5F381.F26DA590"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

------=_NextPart_000_0025_01C5F381.F26DA590
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I am developing a driver for a card that supports unsigned big endian 16 =
bit format. To enable this to work=20
with the wav file format (S16LE), I want to use the pcm plugin for =
format conversion.

Is this possible to do without mmap  support in the driver ?

When I had disabled mmap in the info field in the snd_pcm_hardware_t =
structure, ALSA quits with the message
"unable to find an usable access for plughw:1,1"

when I enable mmap in the info field, the driver gets called but the =
code crashes since mmap is not supported.

Please let me know if I need to provide more information.

I am working with ALSA version 1.0.6.

Thanks,
Nikhil
------=_NextPart_000_0025_01C5F381.F26DA590
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1523" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am developing a driver for =
a&nbsp;card that=20
supports unsigned big endian 16 bit format. To enable this to work =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>with the wav file format (S16LE), I =
want to use the=20
pcm plugin for format conversion.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is this possible to do without mmap =
&nbsp;support=20
in the driver ?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>When I had disabled mmap in the info =
field in the=20
snd_pcm_hardware_t structure, ALSA quits with the message</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>"unable to find an usable access for=20
plughw:1,1"</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>when I enable mmap in the info field, =
the driver=20
gets called but the code crashes since mmap is not =
supported.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Please let me know if I need to provide =
more=20
information.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am working with ALSA version =
1.0.6.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Nikhil</FONT></DIV></BODY></HTML>

------=_NextPart_000_0025_01C5F381.F26DA590--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click

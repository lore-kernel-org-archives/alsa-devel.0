From: "John Shepherd" <g99s2711@campus.ru.ac.za>
Subject: accessing sw data buffers in card driver?
Date: Tue, 5 Nov 2002 18:02:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <007301c284e4$c833c0c0$2b7be792@ict.ru.ac.za>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0070_01C284F5.8B7E0120"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_0070_01C284F5.8B7E0120
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

hi,

um ....how do i extract the audio buffers from memory inside say a card =
driver, like the snd-dummy.  i am just experimenting with ALSA to see if =
it is possible to stream the audio data to the 1394 bus...
so i just need to know how to get the data out of the buffer...

i assume a call to this gets the size out:

snd_pcm_lib_buffer_bytes(substream);


what pcm_function will return the *buffer?  do i access it through =
runtime->dma_area?

thanx,
john.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
John Shepherd=20

Dept. of Computer Science
Rhodes University
Grahamstown
South Africa
6140.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

------=_NextPart_000_0070_01C284F5.8B7E0120
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2920.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT color=3D#0000ff size=3D2>hi,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#0000ff size=3D2>um ....how do i extract the audio =
buffers from=20
memory inside say a card driver, like the snd-dummy.&nbsp; i am just=20
experimenting with ALSA to see if it is possible to stream the audio =
data to the=20
1394 bus...</FONT></DIV>
<DIV><FONT color=3D#0000ff size=3D2>so i just need to know how to get =
the data out=20
of the buffer...</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#0000ff size=3D2>i assume a call to this gets the =
size=20
out:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#0000ff face=3D"Courier New"=20
size=3D2>snd_pcm_lib_buffer_bytes(substream);</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#0000ff size=3D2>what pcm_function will return the =
<FONT=20
face=3D"Courier New">*buffer</FONT>?&nbsp; do i access it through <FONT=20
face=3D"Courier New">runtime-&gt;dma_area</FONT>?</FONT></DIV>
<DIV><FONT color=3D#0000ff face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT color=3D#0000ff face=3D"Times New Roman CE" =
size=3D2>thanx,</FONT></DIV>
<DIV><FONT color=3D#0000ff size=3D2>john.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#0000ff =
size=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<BR>John=20
Shepherd </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#0000ff size=3D2>Dept. of Computer Science<BR>Rhodes=20
University<BR>Grahamstown<BR>South=20
Africa<BR>6140.<BR>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT></DIV></BODY></HTML>

------=_NextPart_000_0070_01C284F5.8B7E0120--



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en

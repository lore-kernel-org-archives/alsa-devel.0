From: "Julian Cable" <julian.cable@bbc.co.uk>
Subject: ice1712 docs
Date: Wed, 17 Nov 2004 09:14:05 -0000
Message-ID: <071EC75C295B4C4282D6564FC4DE872402051577@bbcxue203.national.core.bbc.co.uk>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4CC85.C9A041B8"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
content-class: urn:content-classes:message
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

------_=_NextPart_001_01C4CC85.C9A041B8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

  I got a php error submitting this to the driver page so here is the
text in case it got lost:

This is what I've found in discussions with Takashi Iwai at SuSE:

Due to peculiarities of the ICE1712 chip there is a problem using
the kernel OSS support. OSS applications can only use one stereo
channel, which for most cards would not be the IEC958 channel.

If you want to use OSS and have access to all the channels then the
aoss user level OSS emulation is more flexible as it lets the
libasound stuff do its thing. This needs normal dynamically linked
applications and will not work on closed source statically linked
applications.

The aoss "trick" works by defining pcm.dsp<n> alsa devices and then
calling the program with the following:

% aoss your-own-app
=20
For example, for a VX442 (2 stereo analog and 1 stereo IEC958),
define the following in ~/.asoundrc or /etc/asound.conf:
=20
pcm.dsp0 {
  type plug
   slave.pcm "front"
}=20
=20
pcm.dsp1 {
    type route
    ttable.0.2 1
    ttable.1.3 1
   slave.pcm {
      type hw
      card 0
  }
}=20
=20
pcm.dsp2 {
  type plug
  slave.pcm "iec958"
}


Julian Cable
Project Manager, Transmission & Distribution, BBC World Service
T: +44 (0)20 755 73651  F: + 44 (0)20 713 797559
Mob: +44(0) 77 399 20066
* Room 217 NW, Bush House, Strand, PO Box 76, London, WC2B 4PH
http://www.bbc.co.uk/worldservice


http://www.bbc.co.uk/

This e-mail (and any attachments) is confidential and may contain
personal views which are not the views of the BBC unless specifically
stated.
If you have received it in error, please delete it from your system.=20
Do not use, copy or disclose the information in any way nor act in
reliance on it and notify the sender immediately. Please note that the
BBC monitors e-mails sent or received.=20
Further communication will signify your consent to this.

------_=_NextPart_001_01C4CC85.C9A041B8
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-asci=
i">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.0.6556.0=
">
<TITLE>ice1712 docs</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><FONT SIZE=3D2 FACE=3D"Courier New">Hi,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; I got a php error submittin=
g this to the driver page so here is the text in case it got lost:</FONT>=

</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">This is what I&#8217;ve found in d=
iscussions with Takashi Iwai at SuSE:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">Due to peculiarities of the ICE171=
2 chip there is a problem using</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">the kernel OSS support. OSS appli=
cations can only use one stereo</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">channel, which for most cards wou=
ld not be the IEC958 channel.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">If you want to use OSS and have ac=
cess to all the channels then the</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">aoss user level OSS emulation is =
more flexible as it lets the</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">libasound stuff do its thing. Thi=
s needs normal dynamically linked</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">applications and will not work on=
 closed source statically linked</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">applications.</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">The aoss &quot;trick&quot; works b=
y defining pcm.dsp&lt;n&gt; alsa devices and then</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">calling the program with the foll=
owing:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">% aoss your-own-app</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">For example, for a VX442 (2 stere=
o analog and 1 stereo IEC958),</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">define the following in ~/.asound=
rc or /etc/asound.conf:</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">pcm.dsp0 {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; type plug</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; slave.pcm &quot;fron=
t&quot;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">} </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">pcm.dsp1 {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; type route</FO=
NT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; ttable.0.2 1</=
FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp; ttable.1.3 1</=
FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp; slave.pcm {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ty=
pe hw</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ca=
rd 0</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; }</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">} </FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">pcm.dsp2 {</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; type plug</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">&nbsp; slave.pcm &quot;iec958&quo=
t;</FONT>

<BR><FONT SIZE=3D2 FACE=3D"Courier New">}</FONT>
</P>
<BR>

<P><B><I><FONT COLOR=3D"#0000FF" SIZE=3D1 FACE=3D"Arial">Julian Cable</FO=
NT></I></B><I></I>

<BR><I><FONT COLOR=3D"#0000FF" SIZE=3D1 FACE=3D"Arial">Project Manager, T=
ransmission &amp; Distribution, BBC World Service</FONT></I>

<BR><I><FONT COLOR=3D"#0000FF" SIZE=3D1 FACE=3D"Arial">T: +44 (0)20 755 7=
3651&nbsp; F: + 44 (0)20 713 797559</FONT></I>

<BR><I><FONT COLOR=3D"#0000FF" SIZE=3D1 FACE=3D"Arial">Mob: +44(0) 77 399=
 20066</FONT></I>

<BR><FONT COLOR=3D"#0000FF" SIZE=3D2 FACE=3D"Wingdings">*</FONT><I></I><I=
></I><I><FONT COLOR=3D"#0000FF" SIZE=3D1 FACE=3D"Arial"> Room 217 NW, Bus=
h House, Strand, PO Box 76, London, WC2B 4PH</FONT></I>

<BR><I></I><A HREF=3D"http://www.bbc.co.uk/worldservice"><I><U></U><U><FO=
NT COLOR=3D"#0000FF" SIZE=3D1 FACE=3D"Arial">http://www.bbc.co.uk/worldse=
rvice</FONT></U></I></A><I></I>
</P>

<br>http://www.bbc.co.uk/<br><br>This e-mail (and any attachments) is con=
fidential and may contain<br>personal views which are not the views of th=
e BBC unless specifically<br>stated.<br>If you have received it in error,=
 please delete it from your system. <br>Do not use, copy or disclose the =
information in any way nor act in<br>reliance on it and notify the sender=
 immediately. Please note that the<br>BBC monitors e-mails sent or receiv=
ed. <br>Further communication will signify your consent to this.</BODY>
</HTML>=

------_=_NextPart_001_01C4CC85.C9A041B8--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8

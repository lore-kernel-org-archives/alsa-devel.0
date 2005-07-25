From: "Alfredo" <alfredo@vida-software.com>
Subject: ALSA and event notification schemas
Date: Mon, 25 Jul 2005 19:09:14 +0200
Message-ID: <0416c7e824e16a44987863eda70d4199@vida-software.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_15724_00019169.00026500"
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
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

------_=_NextPart_15724_00019169.00026500
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello, I'm involved in a development project consisting of a
multimedia/networked component using event driven model in a C++ Linux
environment (1 thread than manages all the events using an event loop).

 

The events that the component must handle are:

1. Sockets events.

2. Timer events.

3. Audio events ( event =3D when the next buffer is filled with audio from
the user, notify the component. Then the component will transfer the
audio buffer using a udp socket to another distributed component).

4. Key press and release events (Push To Talk key)

 

What is the best way to handle all this events in a Linux environment?

I have found that libevent is a very interesting library:
http://www.monkey.org/~provos/libevent/

"The libevent API provides a mechanism to execute a callback function
when a specific event occurs on a file descriptor or after a timeout has
been reached".

This resolves the sockets and timer events. I'm not sure if this
approach works well with ALSA (for audio events). I have read that ALSA
provides asynch IO (and callbacks mechanishm), but I don't know if it
fits well with libevent approach.

Is there any way use ALSA to handle audio events (like buffer is filled
with audio from the microphone) and handle the rest of the events in the
same process in a Linux environment?

 

Another question: Does ALSA support AMR or GSM codecs?

 

Your help is really very apreciated.




------_=_NextPart_15724_00019169.00026500
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>


<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 3.0cm 70.85pt 3.0cm;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DES link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Hello, I'm involved in a development project
consisting of a multimedia/networked component using event driven model in =
a
C++ Linux environment (1 thread than manages all the events using an event
loop).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>The events that the component must handle are:<o:=
p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>1. Sockets events.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>2. Timer events.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>3. Audio events ( event =3D when the next buffer =
is
filled with audio from the user, notify the component. Then the component w=
ill
transfer the audio buffer using a udp socket to another distributed compone=
nt).<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>4. Key press and release events (Push To Talk key=
)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>What is the best way to handle all this events in=
 a
Linux environment?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>I have found that libevent is a very interesting
library: http://www.monkey.org/~provos/libevent/<o:p></o:p></span></font></=
p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>&quot;The libevent API provides a mechanism to ex=
ecute
a callback function when a specific event occurs on a file descriptor or af=
ter
a timeout has been reached&quot;.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>This resolves the sockets and timer events. I'm n=
ot
sure if this approach works well with ALSA (for audio events). I have read =
that
ALSA provides asynch IO (and callbacks mechanishm), but I don't know if it =
fits
well with libevent approach.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Is there any way use ALSA to handle audio events
(like buffer is filled with audio from the microphone) and handle the rest =
of
the events in the same process in a Linux environment?<o:p></o:p></span></f=
ont></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Another question: Does ALSA support AMR or GSM
codecs?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>Your help is really very apreciated.<o:p></o:p></=
span></font></p>

</div>

</body>

</html>


------_=_NextPart_15724_00019169.00026500--




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

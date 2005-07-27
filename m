From: "Alfredo" <alfredo@vida-software.com>
Subject: Little question about ALSA callbacks
Date: Wed, 27 Jul 2005 11:28:26 +0200
Message-ID: <a6ad962c7a723f49966db2fe23f87517@vida-software.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_6334_00018467.00000041"
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

------_=_NextPart_6334_00018467.00000041
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello, I have read the article "Introduction to Sound Programming with
ALSA from Linux Journal. This article explains:

 

// Starts here:
------------------------------------------------------------------------
-------------------------------------------

"In the previous examples, the PCM streams were operating in blocking
mode, that is, the calls would not return until the data had been
transferred. In an interactive event-driven application, this situation
could lock up the application for unacceptably long periods of time.
ALSA allows opening a stream in nonblocking mode where the read and
write functions return immediately. If data transfers are pending and
the calls cannot be processed, ALSA returns an error code of EBUSY.

Many graphical applications use callbacks to handle events. ALSA
supports opening a PCM stream in asynchronous mode. This allows
registering a callback function to be called when a period of sample
data has been transferred." 

// Finishes here:
------------------------------------------------------------------------
-------

I'm developing an event driven Linux server that will use ALSA library.
Please, could you point me to some resources in order to learn how to
use alsa in asynchronous mode (the event driven mechanism will be based
in poll()).

Clemens Ladisch helped me suggesting that I must use poll to wait for
events in different file descriptors. I need to be notified when audio
buffer has been recorded. I need to learn how to use ALSA in conjunction
with poll.

I'm a Linux developer beginner and I'm glad to use ALSA.

Thank you very much ;-)




------_=_NextPart_6334_00018467.00000041
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
p
	{mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:12.0pt;
	font-family:"Times New Roman";}
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
10.0pt;font-family:Arial'>Hello, I have read the article &#8220;Introductio=
n to
Sound Programming with ALSA from Linux Journal. This article explains:<o:p>=
</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB style=
=3D'font-size:
10.0pt;font-family:Arial'>// Starts here:
---------------------------------------------------------------------------=
----------------------------------------<o:p></o:p></span></font></p>

<p><font size=3D2 face=3DArial><span lang=3DEN-GB style=3D'font-size:10.0pt=
;font-family:
Arial'>&#8220;</span></font><span lang=3DEN-GB>In the previous examples, th=
e PCM
streams were operating in blocking mode, that is, the calls would not retur=
n
until the data had been transferred. In an interactive event-driven
application, this situation could lock up the application for unacceptably =
long
periods of time. ALSA allows opening a stream in nonblocking mode where the
read and write functions return immediately. If data transfers are pending =
and
the calls cannot be processed, ALSA returns an error code of EBUSY.<o:p></o=
:p></span></p>

<p><font size=3D3 face=3D"Times New Roman"><span lang=3DEN-GB style=3D'font=
-size:12.0pt'>Many
graphical applications use callbacks to handle events. ALSA supports openin=
g a
PCM stream in asynchronous mode. This allows registering a callback functio=
n to
be called when a period of sample data has been transferred.</span></font><=
font
size=3D2 face=3DArial><span lang=3DEN-GB style=3D'font-size:10.0pt;font-fam=
ily:Arial'>&#8220;
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span lang=3DE=
N-GB
style=3D'font-size:12.0pt'>// Finishes here:
---------------------------------------------------------------------------=
----</span></font><font
size=3D2 face=3DArial><span lang=3DEN-GB style=3D'font-size:10.0pt;font-fam=
ily:Arial'><o:p></o:p></span></font></p>

<p><font size=3D2 face=3DArial><span lang=3DEN-GB style=3D'font-size:10.0pt=
;font-family:
Arial'>I&#8217;m developing an event driven Linux server that will use ALSA
library. Please, could you point me to some resources in order to learn how=
 to
use alsa in asynchronous mode (the event driven mechanism will be based in
poll()).<o:p></o:p></span></font></p>

<p><font size=3D2 face=3DArial><span lang=3DEN-GB style=3D'font-size:10.0pt=
;font-family:
Arial'>Clemens Ladisch helped me suggesting that I must use poll to wait fo=
r
events in different file descriptors. I need to be notified when audio buff=
er
has been recorded. I need to learn how to use ALSA in conjunction with poll=
.<o:p></o:p></span></font></p>

<p><font size=3D2 face=3DArial><span lang=3DEN-GB style=3D'font-size:10.0pt=
;font-family:
Arial'>I&#8217;m a Linux developer beginner and I&#8217;m glad to use ALSA.=
<o:p></o:p></span></font></p>

<p><font size=3D2 face=3DArial><span lang=3DEN-GB style=3D'font-size:10.0pt=
;font-family:
Arial'>Thank you very much ;-)<o:p></o:p></span></font></p>

</div>

</body>

</html>


------_=_NextPart_6334_00018467.00000041--




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: Is there a convention for mapping codec vendor's
 register::bit names to alsa control names?
Date: Fri, 23 Feb 2007 09:54:46 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8AF@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8A1@sea-exch-01.na.corp.dmxmusic.com>
	<s5hslcy78vw.wl%tiwai@suse.de>
	<F8FB97052F1BEF409F7842E960E49B5AAAF8A7@sea-exch-01.na.corp.dmxmusic.com>
	<s5h649s9a07.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1371906193=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============1371906193==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75773.D4E0E642"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75773.D4E0E642
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

PLz forgive if you see this twice, outlook web access is tormenting me =
further


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Fri 2/23/2007 7:19 AM
To: John Utz
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Is there a convention for mapping codec =
vendor's register::bit names to alsa control names?
=20
At Thu, 22 Feb 2007 10:04:20 -0800,
John Utz wrote:
>=20
> * If no, we can hardcode these bits in the initialization sequence.
>=20
> these bits form a matrix that configure some combinations of mic ins, =
line ins and
> surround outputs.
>=20
> In the case of somebody that has a full collection of =
plugins/plugouts, their surround
> output might not work as expected.
>=20
> And, that person might want to sometimes change the line in and the =
speaker out to be
> more mic inputs.
>=20
> So surfacing flexibility to the end user is important.
>=20
> The problem with surfacing this is that matrix is pretty hard to =
follow:
>=20
> 1. the doc has some bugs; ie SM51 and SMIC are not the names of the =
bits
>=20
> 2. the collection of choices is so strange that it looks like the =
result of running a
> gate minimization program instead of choosing the matrix based on user =
need :-)
>=20
>     Controller Bit     MICIN                 I/O
> SM51 SM51SW SMIC 20XL 20XR     MIC1 MIC2  MIC3    LL   LR
>  0        0        0 MIC1 MIC1 MIC1   -    -      LL   LR
>  0        0        1 MIC1 MIC3 MIC1   -   MIC3    LL   LR
>  0        1        0 MIC2 MIC2   -  MIC2   -      LL   LR
>  0        1        1 MIC1 MIC2 MIC1 MIC2   -      LL   LR
>  1        0        0 MIC3 MIC3 CEN   LFE  MIC3   SURL SURR
>  1        0        1 MIC3 MIC3 CENT  LFE  MIC3    LL   LR
>  1        1        0 MIC1 MIC1 Mic1       LFE    SURL SURR
>  1        1        1 MIC1 MIC2 MIC1 MIC2- LFE    SURL SURR
>=20
> If somebody can make sense of this by assigning a simple meaning to =
each input bit in
> this karnaugh map then i'd welcome that insight!
>=20
> However, having looked at this for several hours, I think this is =
already minimized.

* Well, too minimized to understand quite what they mean :)
* Could you explain a bit more detail?


yes, certainly! this matrix is called 'Mixer Table'


The bit's are as follows, complete with documentation mistakes :


SM51 is a mistake, it's listed in the docs as SM51EN. it has a 1 line =
decription:

  'Smart 5.1 feature (See Mixer Table)'


SM51SW is corrent, it has a 1 line description:

  'Smart 5.1 feature (See Mixer Table)'


SMIC is a mistake, it's listed in the docs as MS, it has a 1 line =
description:

  'Microphone Select (See Table Below)'


20XL i have NO IDEA what this is.

20XR i have NO IDEA what this is.


MIC{1,2,3} i ASSUME are routing for different mic inputs


L{L,R} i am pretty sure is Line In Left and Right

S{L,R} is Surround Left and Right

CEN and LFE are Center and Low Frequency Enhancement


These are the different choices in the matrix, i dont like the idea of =
arbitrarily picking a setup that turns on surround and ignores the other =
choices.

My current code surfaces all 3 bits:

  AC97_SINGLE("Smart 5.1 Control A", 0x20,  8, 1, 0),
  AC97_SINGLE("Smart 5.1 Control B", 0x7a, 15, 1, 0),
  AC97_SINGLE("Smart 5.1 Control C", 0x7a, 14, 1, 0)

I havent come up with any better idea.

tnx for any thoughts you may have.


johnu

* Takashi



------_=_NextPart_001_01C75773.D4E0E642
Content-Type: text/html;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7638.1">
<TITLE>RE: [Alsa-devel] Is there a convention for mapping codec vendor's =
register::bit names to alsa control names?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>PLz forgive if you see this twice, outlook web access =
is tormenting me further<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Takashi Iwai [<A =
HREF=3D"mailto:tiwai@suse.de">mailto:tiwai@suse.de</A>]<BR>
Sent: Fri 2/23/2007 7:19 AM<BR>
To: John Utz<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] Is there a convention for mapping codec =
vendor's register::bit names to alsa control names?<BR>
<BR>
At Thu, 22 Feb 2007 10:04:20 -0800,<BR>
John Utz wrote:<BR>
&gt;<BR>
&gt; * If no, we can hardcode these bits in the initialization =
sequence.<BR>
&gt;<BR>
&gt; these bits form a matrix that configure some combinations of mic =
ins, line ins and<BR>
&gt; surround outputs.<BR>
&gt;<BR>
&gt; In the case of somebody that has a full collection of =
plugins/plugouts, their surround<BR>
&gt; output might not work as expected.<BR>
&gt;<BR>
&gt; And, that person might want to sometimes change the line in and the =
speaker out to be<BR>
&gt; more mic inputs.<BR>
&gt;<BR>
&gt; So surfacing flexibility to the end user is important.<BR>
&gt;<BR>
&gt; The problem with surfacing this is that matrix is pretty hard to =
follow:<BR>
&gt;<BR>
&gt; 1. the doc has some bugs; ie SM51 and SMIC are not the names of the =
bits<BR>
&gt;<BR>
&gt; 2. the collection of choices is so strange that it looks like the =
result of running a<BR>
&gt; gate minimization program instead of choosing the matrix based on =
user need :-)<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Controller Bit&nbsp;&nbsp;&nbsp;&nbsp; =
MICIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O<BR>
&gt; SM51 SM51SW SMIC 20XL 20XR&nbsp;&nbsp;&nbsp;&nbsp; MIC1 MIC2&nbsp; =
MIC3&nbsp;&nbsp;&nbsp; LL&nbsp;&nbsp; LR<BR>
&gt;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 MIC1 MIC1 MIC1&nbsp;&nbsp; =
-&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LL&nbsp;&nbsp; =
LR<BR>
&gt;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 MIC1 MIC3 MIC1&nbsp;&nbsp; =
-&nbsp;&nbsp; MIC3&nbsp;&nbsp;&nbsp; LL&nbsp;&nbsp; LR<BR>
&gt;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 MIC2 MIC2&nbsp;&nbsp; =
-&nbsp; MIC2&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LL&nbsp;&nbsp; =
LR<BR>
&gt;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 MIC1 MIC2 MIC1 =
MIC2&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LL&nbsp;&nbsp; LR<BR>
&gt;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 MIC3 MIC3 CEN&nbsp;&nbsp; =
LFE&nbsp; MIC3&nbsp;&nbsp; SURL SURR<BR>
&gt;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 MIC3 MIC3 CENT&nbsp; =
LFE&nbsp; MIC3&nbsp;&nbsp;&nbsp; LL&nbsp;&nbsp; LR<BR>
&gt;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 MIC1 MIC1 =
Mic1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LFE&nbsp;&nbsp;&nbsp; SURL =
SURR<BR>
&gt;&nbsp; 1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 MIC1 MIC2 MIC1 MIC2- =
LFE&nbsp;&nbsp;&nbsp; SURL SURR<BR>
&gt;<BR>
&gt; If somebody can make sense of this by assigning a simple meaning to =
each input bit in<BR>
&gt; this karnaugh map then i'd welcome that insight!<BR>
&gt;<BR>
&gt; However, having looked at this for several hours, I think this is =
already minimized.<BR>
<BR>
* Well, too minimized to understand quite what they mean :)<BR>
* Could you explain a bit more detail?<BR>
<BR>
<BR>
yes, certainly! this matrix is called 'Mixer Table'<BR>
<BR>
<BR>
The bit's are as follows, complete with documentation mistakes :<BR>
<BR>
<BR>
SM51 is a mistake, it's listed in the docs as SM51EN. it has a 1 line =
decription:<BR>
<BR>
&nbsp; 'Smart 5.1 feature (See Mixer Table)'<BR>
<BR>
<BR>
SM51SW is corrent, it has a 1 line description:<BR>
<BR>
&nbsp; 'Smart 5.1 feature (See Mixer Table)'<BR>
<BR>
<BR>
SMIC is a mistake, it's listed in the docs as MS, it has a 1 line =
description:<BR>
<BR>
&nbsp; 'Microphone Select (See Table Below)'<BR>
<BR>
<BR>
20XL i have NO IDEA what this is.<BR>
<BR>
20XR i have NO IDEA what this is.<BR>
<BR>
<BR>
MIC{1,2,3} i ASSUME are routing for different mic inputs<BR>
<BR>
<BR>
L{L,R} i am pretty sure is Line In Left and Right<BR>
<BR>
S{L,R} is Surround Left and Right<BR>
<BR>
CEN and LFE are Center and Low Frequency Enhancement<BR>
<BR>
<BR>
These are the different choices in the matrix, i dont like the idea of =
arbitrarily picking a setup that turns on surround and ignores the other =
choices.<BR>
<BR>
My current code surfaces all 3 bits:<BR>
<BR>
&nbsp; AC97_SINGLE(&quot;Smart 5.1 Control A&quot;, 0x20,&nbsp; 8, 1, =
0),<BR>
&nbsp; AC97_SINGLE(&quot;Smart 5.1 Control B&quot;, 0x7a, 15, 1, 0),<BR>
&nbsp; AC97_SINGLE(&quot;Smart 5.1 Control C&quot;, 0x7a, 14, 1, 0)<BR>
<BR>
I havent come up with any better idea.<BR>
<BR>
tnx for any thoughts you may have.<BR>
<BR>
<BR>
johnu<BR>
<BR>
* Takashi<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75773.D4E0E642--



--===============1371906193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1371906193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1371906193==--

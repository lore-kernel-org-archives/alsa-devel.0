From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: Is there a convention for mapping codec vendor's
 register::bit names to alsa control names?
Date: Thu, 22 Feb 2007 10:04:20 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8A7@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8A1@sea-exch-01.na.corp.dmxmusic.com>
	<s5hslcy78vw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0585475153=="
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

--===============0585475153==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C756AB.E0464121"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C756AB.E0464121
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I have to escape from the non standards compliant hell of Outlook Web =
Access. :-(

I have no way of correctly citing other than typing all the characters =
in myself, that's too lame.

So plz forgive my quasi-cite :-)

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Thu 2/22/2007 3:02 AM
To: John Utz
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Is there a convention for mapping codec =
vendor's register::bit names to alsa control names?
=20
At Wed, 21 Feb 2007 14:11:11 -0800,
John Utz wrote:
>=20
> I have some improvements to the VIA 1617a support submitted a few =
weeks ago by daniel
> jacobowitz (they are in 1.0.14rc2).
>=20
> I have added 4 new controls, 3 of which are required to support =
enabling VIA's
> 'Smart51' for the 1617a:
>=20
> static const struct snd_kcontrol_new snd_ac97_controls_vt1617a[] =3D {
>   AC97_SINGLE("Center/LFE Exch",   0x5a,  8, 1, 0),

* You don't have to shorten the word.  The mixer element has a long
* enough space (up to 43 letters).

Okay

> /* these bits form a matrix that allows for the limited configuration =
of
>  * outputs and inputs to enable surround sound input
>   AC97_SINGLE("Microphone Select", 0x20,  8, 1, 0),

* An enum type control would be suitable for this kind of controls (if
* really needed).

what would the enum look like?

>   AC97_SINGLE("Smart 5.1 Switch",  0x7a, 15, 1, 0),
>   AC97_SINGLE("Smart 5.1 Enable",  0x7a, 14, 1, 0)
> };
>=20
> These are the names that Uncle Via's hard working engineers have =
assigned to these
> bits in their released documentation but surfacing these names in the =
ui looks to me
> to be a usability nightmare :-(
>=20
> To wit; enabling surround sound on a board that only has 3 jacks =
requires setting
>=20
>    "Microphone Select" to 0
>    "Smart 5.1 Switch"  to 1
>    "Smart 5.1 Enable"  to 1

* Is there any case that you need to turn off these bits?

yes! on any system that has specific surround outputs in addition to the =
mic and line in then this would probably be a bad idea.

* If no, we can hardcode these bits in the initialization sequence.

these bits form a matrix that configure some combinations of mic ins, =
line ins and surround outputs.

In the case of somebody that has a full collection of plugins/plugouts, =
their surround output might not work as expected.

And, that person might want to sometimes change the line in and the =
speaker out to be more mic inputs.

So surfacing flexibility to the end user is important.

The problem with surfacing this is that matrix is pretty hard to follow:

1. the doc has some bugs; ie SM51 and SMIC are not the names of the bits

2. the collection of choices is so strange that it looks like the result =
of running a gate minimization program instead of choosing the matrix =
based on user need :-)

    Controller Bit     MICIN                 I/O
SM51 SM51SW SMIC 20XL 20XR     MIC1 MIC2  MIC3    LL   LR
 0        0        0 MIC1 MIC1 MIC1   -    -      LL   LR
 0        0        1 MIC1 MIC3 MIC1   -   MIC3    LL   LR
 0        1        0 MIC2 MIC2   -  MIC2   -      LL   LR
 0        1        1 MIC1 MIC2 MIC1 MIC2   -      LL   LR
 1        0        0 MIC3 MIC3 CEN   LFE  MIC3   SURL SURR
 1        0        1 MIC3 MIC3 CENT  LFE  MIC3    LL   LR
 1        1        0 MIC1 MIC1 Mic1       LFE    SURL SURR
 1        1        1 MIC1 MIC2 MIC1 MIC2- LFE    SURL SURR

If somebody can make sense of this by assigning a simple meaning to each =
input bit in this karnaugh map then i'd welcome that insight!

However, having looked at this for several hours, I think this is =
already minimized.


> *and* one set the existing "Alternate Level to Surround Out" to 0
>=20
> This is super-duper non obvious in alsamixer.

* Strongly agree.
*=20
* Alternatively, if we really need a mixer switch to toggle these bits,
* create combinient one such as "Surround Output Switch", which
* enables/disables all these bits together as a single control.

I that it might be possible to do this correctly, but i think that the =
correct solution space is very small and the 'Works out of the Box for =
Some Folks, Absolutely Infuriates Everybody Else' solution space is =
much, much larger. :-(

*(Actually, such an abstraction could be implemented in alsa-lib side,
* I come to believe that the simplification in the driver is much
* easier.)

This statement parses ambiguously; are you saying that you would prefer =
to see control aggregation should occur in the driver or the lib?

You have been at this code for a very long time and the fact that you =
have come to a conclusion as a result of your substantive experience =
gives your conclusion very great weight.

Having said that :-), IMHO, control aggregation should occur in the =
library and the not in the driver.=20

  Driver is for bitflipping only; exports ioctls (or in the case of my =
beloved freebsd; sysctls).=20

  Lib is for configuring bits for setting up surround and whatnot.

  Lib Plugin is for Data Manipulation; resamp, eq, channel split, etc - =
yes, i know this is=20
  also a hardware function too, it's an imperfect world :-)

Currently, the driver is quite a motley mix of things because hard =
working contributors have made things work as best they could.

tnx!

johnu

* thanks,
*
* Takashi



------_=_NextPart_001_01C756AB.E0464121
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

<P><FONT SIZE=3D2>I have to escape from the non standards compliant hell =
of Outlook Web Access. :-(<BR>
<BR>
I have no way of correctly citing other than typing all the characters =
in myself, that's too lame.<BR>
<BR>
So plz forgive my quasi-cite :-)<BR>
<BR>
-----Original Message-----<BR>
From: Takashi Iwai [<A =
HREF=3D"mailto:tiwai@suse.de">mailto:tiwai@suse.de</A>]<BR>
Sent: Thu 2/22/2007 3:02 AM<BR>
To: John Utz<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] Is there a convention for mapping codec =
vendor's register::bit names to alsa control names?<BR>
<BR>
At Wed, 21 Feb 2007 14:11:11 -0800,<BR>
John Utz wrote:<BR>
&gt;<BR>
&gt; I have some improvements to the VIA 1617a support submitted a few =
weeks ago by daniel<BR>
&gt; jacobowitz (they are in 1.0.14rc2).<BR>
&gt;<BR>
&gt; I have added 4 new controls, 3 of which are required to support =
enabling VIA's<BR>
&gt; 'Smart51' for the 1617a:<BR>
&gt;<BR>
&gt; static const struct snd_kcontrol_new snd_ac97_controls_vt1617a[] =
=3D {<BR>
&gt;&nbsp;&nbsp; AC97_SINGLE(&quot;Center/LFE Exch&quot;,&nbsp;&nbsp; =
0x5a,&nbsp; 8, 1, 0),<BR>
<BR>
* You don't have to shorten the word.&nbsp; The mixer element has a =
long<BR>
* enough space (up to 43 letters).<BR>
<BR>
Okay<BR>
<BR>
&gt; /* these bits form a matrix that allows for the limited =
configuration of<BR>
&gt;&nbsp; * outputs and inputs to enable surround sound input<BR>
&gt;&nbsp;&nbsp; AC97_SINGLE(&quot;Microphone Select&quot;, 0x20,&nbsp; =
8, 1, 0),<BR>
<BR>
* An enum type control would be suitable for this kind of controls =
(if<BR>
* really needed).<BR>
<BR>
what would the enum look like?<BR>
<BR>
&gt;&nbsp;&nbsp; AC97_SINGLE(&quot;Smart 5.1 Switch&quot;,&nbsp; 0x7a, =
15, 1, 0),<BR>
&gt;&nbsp;&nbsp; AC97_SINGLE(&quot;Smart 5.1 Enable&quot;,&nbsp; 0x7a, =
14, 1, 0)<BR>
&gt; };<BR>
&gt;<BR>
&gt; These are the names that Uncle Via's hard working engineers have =
assigned to these<BR>
&gt; bits in their released documentation but surfacing these names in =
the ui looks to me<BR>
&gt; to be a usability nightmare :-(<BR>
&gt;<BR>
&gt; To wit; enabling surround sound on a board that only has 3 jacks =
requires setting<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp; &quot;Microphone Select&quot; to 0<BR>
&gt;&nbsp;&nbsp;&nbsp; &quot;Smart 5.1 Switch&quot;&nbsp; to 1<BR>
&gt;&nbsp;&nbsp;&nbsp; &quot;Smart 5.1 Enable&quot;&nbsp; to 1<BR>
<BR>
* Is there any case that you need to turn off these bits?<BR>
<BR>
yes! on any system that has specific surround outputs in addition to the =
mic and line in then this would probably be a bad idea.<BR>
<BR>
* If no, we can hardcode these bits in the initialization sequence.<BR>
<BR>
these bits form a matrix that configure some combinations of mic ins, =
line ins and surround outputs.<BR>
<BR>
In the case of somebody that has a full collection of plugins/plugouts, =
their surround output might not work as expected.<BR>
<BR>
And, that person might want to sometimes change the line in and the =
speaker out to be more mic inputs.<BR>
<BR>
So surfacing flexibility to the end user is important.<BR>
<BR>
The problem with surfacing this is that matrix is pretty hard to =
follow:<BR>
<BR>
1. the doc has some bugs; ie SM51 and SMIC are not the names of the =
bits<BR>
<BR>
2. the collection of choices is so strange that it looks like the result =
of running a gate minimization program instead of choosing the matrix =
based on user need :-)<BR>
<BR>
&nbsp;&nbsp;&nbsp; Controller Bit&nbsp;&nbsp;&nbsp;&nbsp; =
MICIN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; I/O<BR>
SM51 SM51SW SMIC 20XL 20XR&nbsp;&nbsp;&nbsp;&nbsp; MIC1 MIC2&nbsp; =
MIC3&nbsp;&nbsp;&nbsp; LL&nbsp;&nbsp; LR<BR>
&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 MIC1 MIC1 MIC1&nbsp;&nbsp; =
-&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LL&nbsp;&nbsp; =
LR<BR>
&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 MIC1 MIC3 MIC1&nbsp;&nbsp; =
-&nbsp;&nbsp; MIC3&nbsp;&nbsp;&nbsp; LL&nbsp;&nbsp; LR<BR>
&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 MIC2 MIC2&nbsp;&nbsp; =
-&nbsp; MIC2&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LL&nbsp;&nbsp; =
LR<BR>
&nbsp;0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 MIC1 MIC2 MIC1 =
MIC2&nbsp;&nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LL&nbsp;&nbsp; LR<BR>
&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 MIC3 MIC3 CEN&nbsp;&nbsp; =
LFE&nbsp; MIC3&nbsp;&nbsp; SURL SURR<BR>
&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 MIC3 MIC3 CENT&nbsp; =
LFE&nbsp; MIC3&nbsp;&nbsp;&nbsp; LL&nbsp;&nbsp; LR<BR>
&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 MIC1 MIC1 =
Mic1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LFE&nbsp;&nbsp;&nbsp; SURL =
SURR<BR>
&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 MIC1 MIC2 MIC1 MIC2- =
LFE&nbsp;&nbsp;&nbsp; SURL SURR<BR>
<BR>
If somebody can make sense of this by assigning a simple meaning to each =
input bit in this karnaugh map then i'd welcome that insight!<BR>
<BR>
However, having looked at this for several hours, I think this is =
already minimized.<BR>
<BR>
<BR>
&gt; *and* one set the existing &quot;Alternate Level to Surround =
Out&quot; to 0<BR>
&gt;<BR>
&gt; This is super-duper non obvious in alsamixer.<BR>
<BR>
* Strongly agree.<BR>
*<BR>
* Alternatively, if we really need a mixer switch to toggle these =
bits,<BR>
* create combinient one such as &quot;Surround Output Switch&quot;, =
which<BR>
* enables/disables all these bits together as a single control.<BR>
<BR>
I that it might be possible to do this correctly, but i think that the =
correct solution space is very small and the 'Works out of the Box for =
Some Folks, Absolutely Infuriates Everybody Else' solution space is =
much, much larger. :-(<BR>
<BR>
*(Actually, such an abstraction could be implemented in alsa-lib =
side,<BR>
* I come to believe that the simplification in the driver is much<BR>
* easier.)<BR>
<BR>
This statement parses ambiguously; are you saying that you would prefer =
to see control aggregation should occur in the driver or the lib?<BR>
<BR>
You have been at this code for a very long time and the fact that you =
have come to a conclusion as a result of your substantive experience =
gives your conclusion very great weight.<BR>
<BR>
Having said that :-), IMHO, control aggregation should occur in the =
library and the not in the driver.<BR>
<BR>
&nbsp; Driver is for bitflipping only; exports ioctls (or in the case of =
my beloved freebsd; sysctls).<BR>
<BR>
&nbsp; Lib is for configuring bits for setting up surround and =
whatnot.<BR>
<BR>
&nbsp; Lib Plugin is for Data Manipulation; resamp, eq, channel split, =
etc - yes, i know this is<BR>
&nbsp; also a hardware function too, it's an imperfect world :-)<BR>
<BR>
Currently, the driver is quite a motley mix of things because hard =
working contributors have made things work as best they could.<BR>
<BR>
tnx!<BR>
<BR>
johnu<BR>
<BR>
* thanks,<BR>
*<BR>
* Takashi<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C756AB.E0464121--



--===============0585475153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0585475153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0585475153==--

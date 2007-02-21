From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Is there a convention for mapping codec vendor's
 register::bit names to alsa control names?
Date: Wed, 21 Feb 2007 14:11:11 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8A1@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0269519730=="
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0269519730==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75605.31CBBC52"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75605.31CBBC52
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I have some improvements to the VIA 1617a support submitted a few weeks =
ago by daniel jacobowitz (they are in 1.0.14rc2).

I have added 4 new controls, 3 of which are required to support enabling =
VIA's 'Smart51' for the 1617a:


static const struct snd_kcontrol_new snd_ac97_controls_vt1617a[] =3D {
  AC97_SINGLE("Center/LFE Exch",   0x5a,  8, 1, 0),
/* these bits form a matrix that allows for the limited configuration of
 * outputs and inputs to enable surround sound input
  AC97_SINGLE("Microphone Select", 0x20,  8, 1, 0),
  AC97_SINGLE("Smart 5.1 Switch",  0x7a, 15, 1, 0),
  AC97_SINGLE("Smart 5.1 Enable",  0x7a, 14, 1, 0)
};

These are the names that Uncle Via's hard working engineers have =
assigned to these bits in their released documentation but surfacing =
these names in the ui looks to me to be a usability nightmare :-(

To wit; enabling surround sound on a board that only has 3 jacks =
requires setting

   "Microphone Select" to 0
   "Smart 5.1 Switch"  to 1
   "Smart 5.1 Enable"  to 1

*and* one set the existing "Alternate Level to Surround Out" to 0


This is super-duper non obvious in alsamixer.

Hell, i'd just *coded* the damn thing and i had to poke alsamixer a few =
times to get it right.


So, what's the convention on things like this?

As a developer, i'd prefer that things match the chip docs so i can =
figure out what's going on in the code (thus my previous on-list gripes =
about register naming macros not matching the AC97 standard).

As a user, i'd prefer that it be easy to figure out what the hell i am =
supposed to do to get the hardware to do what i want?


What to do?

tnx!

johnu

As a user, i'd prefer that thing



However,


------_=_NextPart_001_01C75605.31CBBC52
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
<TITLE>Is there a convention for mapping codec vendor's register::bit =
names to alsa control names?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I have some improvements to the VIA 1617a support =
submitted a few weeks ago by daniel jacobowitz (they are in =
1.0.14rc2).<BR>
<BR>
I have added 4 new controls, 3 of which are required to support enabling =
VIA's 'Smart51' for the 1617a:<BR>
<BR>
<BR>
static const struct snd_kcontrol_new snd_ac97_controls_vt1617a[] =3D =
{<BR>
&nbsp; AC97_SINGLE(&quot;Center/LFE Exch&quot;,&nbsp;&nbsp; 0x5a,&nbsp; =
8, 1, 0),<BR>
/* these bits form a matrix that allows for the limited configuration =
of<BR>
&nbsp;* outputs and inputs to enable surround sound input<BR>
&nbsp; AC97_SINGLE(&quot;Microphone Select&quot;, 0x20,&nbsp; 8, 1, =
0),<BR>
&nbsp; AC97_SINGLE(&quot;Smart 5.1 Switch&quot;,&nbsp; 0x7a, 15, 1, =
0),<BR>
&nbsp; AC97_SINGLE(&quot;Smart 5.1 Enable&quot;,&nbsp; 0x7a, 14, 1, =
0)<BR>
};<BR>
<BR>
These are the names that Uncle Via's hard working engineers have =
assigned to these bits in their released documentation but surfacing =
these names in the ui looks to me to be a usability nightmare :-(<BR>
<BR>
To wit; enabling surround sound on a board that only has 3 jacks =
requires setting<BR>
<BR>
&nbsp;&nbsp; &quot;Microphone Select&quot; to 0<BR>
&nbsp;&nbsp; &quot;Smart 5.1 Switch&quot;&nbsp; to 1<BR>
&nbsp;&nbsp; &quot;Smart 5.1 Enable&quot;&nbsp; to 1<BR>
<BR>
*and* one set the existing &quot;Alternate Level to Surround Out&quot; =
to 0<BR>
<BR>
<BR>
This is super-duper non obvious in alsamixer.<BR>
<BR>
Hell, i'd just *coded* the damn thing and i had to poke alsamixer a few =
times to get it right.<BR>
<BR>
<BR>
So, what's the convention on things like this?<BR>
<BR>
As a developer, i'd prefer that things match the chip docs so i can =
figure out what's going on in the code (thus my previous on-list gripes =
about register naming macros not matching the AC97 standard).<BR>
<BR>
As a user, i'd prefer that it be easy to figure out what the hell i am =
supposed to do to get the hardware to do what i want?<BR>
<BR>
<BR>
What to do?<BR>
<BR>
tnx!<BR>
<BR>
johnu<BR>
<BR>
As a user, i'd prefer that thing<BR>
<BR>
<BR>
<BR>
However,<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75605.31CBBC52--



--===============0269519730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0269519730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0269519730==--

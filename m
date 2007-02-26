From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: patch: ac97_patch.c - enable 'Smart 5.1' on VIA
 vt1617a ac97 codec
Date: Mon, 26 Feb 2007 10:25:34 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8B5@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8B4@sea-exch-01.na.corp.dmxmusic.com>
	<s5hhct9ug79.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1526152488=="
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

--===============1526152488==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C759D3.814FB877"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C759D3.814FB877
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable




-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Mon 2/26/2007 6:49 AM
To: John Utz
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] patch: ac97_patch.c - enable 'Smart 5.1' on =
VIA vt1617a ac97 codec
=20
At Fri, 23 Feb 2007 16:44:33 -0800,
John Utz wrote:
>=20
> This patch allows via vt1617a end users to configure what via calls =
Smart 5.1 - a
> mechanism for controlling the 3 bi-directional analog connectors that =
some OEM's use
> instead of a larger collection of dedicated analog input and output =
connectors.
>=20
> As outlined in previous discussion on this list, the outcome matrix =
for togging these
> bits is somewhat arcane and seemingly lacking in cohesion, but with =
only 3 bits, it's
> reasonable to expect that a motivated end user will be able to =
eventually configure
> their own personal setup to their needs.
>=20
> Note that in some instances (such as an epia C7) it is also required =
to disable
> 'alternate surround out' to get surround to work properly.
>=20
> Note that this is my first ever alsa patch and after review by wiser =
craniums it may
> need fixin'. ;-)
>=20
> plz dont hesitate to ask for such corrections!
*
* Well, I still think that these Smart 5.1 controls are too cryptic.
* ...and with this patch, you'll have even three such switches!

Honestly, it's actually 4, because if the alt output thingy isnt turned =
off, then surround routes off to nowhere...

* IMO, it'd be (a little bit) better to have a single control to set up
* these things.  For example, you can give an enum control that has 8
* entries for SM51A,B,C setups.

Happy to oblige, I'll study up on AC97_ENUM_* and try to make this =
possible.

* Takashi



------_=_NextPart_001_01C759D3.814FB877
Content-Type: text/html;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7651.59">
<TITLE>RE: [Alsa-devel] patch: ac97_patch.c - enable 'Smart 5.1' on VIA =
vt1617a ac97 codec</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----<BR>
From: Takashi Iwai [<A =
HREF=3D"mailto:tiwai@suse.de">mailto:tiwai@suse.de</A>]<BR>
Sent: Mon 2/26/2007 6:49 AM<BR>
To: John Utz<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] patch: ac97_patch.c - enable 'Smart 5.1' on =
VIA vt1617a ac97 codec<BR>
<BR>
At Fri, 23 Feb 2007 16:44:33 -0800,<BR>
John Utz wrote:<BR>
&gt;<BR>
&gt; This patch allows via vt1617a end users to configure what via calls =
Smart 5.1 - a<BR>
&gt; mechanism for controlling the 3 bi-directional analog connectors =
that some OEM's use<BR>
&gt; instead of a larger collection of dedicated analog input and output =
connectors.<BR>
&gt;<BR>
&gt; As outlined in previous discussion on this list, the outcome matrix =
for togging these<BR>
&gt; bits is somewhat arcane and seemingly lacking in cohesion, but with =
only 3 bits, it's<BR>
&gt; reasonable to expect that a motivated end user will be able to =
eventually configure<BR>
&gt; their own personal setup to their needs.<BR>
&gt;<BR>
&gt; Note that in some instances (such as an epia C7) it is also =
required to disable<BR>
&gt; 'alternate surround out' to get surround to work properly.<BR>
&gt;<BR>
&gt; Note that this is my first ever alsa patch and after review by =
wiser craniums it may<BR>
&gt; need fixin'. ;-)<BR>
&gt;<BR>
&gt; plz dont hesitate to ask for such corrections!<BR>
*<BR>
* Well, I still think that these Smart 5.1 controls are too cryptic.<BR>
* ...and with this patch, you'll have even three such switches!<BR>
<BR>
Honestly, it's actually 4, because if the alt output thingy isnt turned =
off, then surround routes off to nowhere...<BR>
<BR>
* IMO, it'd be (a little bit) better to have a single control to set =
up<BR>
* these things.&nbsp; For example, you can give an enum control that has =
8<BR>
* entries for SM51A,B,C setups.<BR>
<BR>
Happy to oblige, I'll study up on AC97_ENUM_* and try to make this =
possible.<BR>
<BR>
* Takashi<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C759D3.814FB877--



--===============1526152488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1526152488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1526152488==--

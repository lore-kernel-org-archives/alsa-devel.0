From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: doesn anybody actually ever assign to
 snd_ac97.indep_surround?
Date: Fri, 23 Feb 2007 10:40:20 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8B0@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8AD@sea-exch-01.na.corp.dmxmusic.com>
	<s5h8xeo9a9n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1915183755=="
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

--===============1915183755==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7577A.1251BFFF"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7577A.1251BFFF
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable




-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Fri 2/23/2007 7:14 AM
To: John Utz
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] doesn anybody actually ever assign to =
snd_ac97.indep_surround?
=20

* The basic idea behind this implementation is that you set up the
* surround setting dynamically.  There are two switches to play
* important roles that are created usually:
*=20
* 1. Surround Jack Mode
* 	enum: Shared / Independent
* 2. Channel Mode
*	enum: 2ch / 4ch / 6ch
*
* When "Shared" is selected, the ac97 patch should set up the codec chip
* for the bidirectional pins.  Inputs are turned to be surround outputs
* according to the the current status of channel mode (2, 4, 6ch).
* OTOH, when "Independent" is selected, it means that the board has
* separate surround jacks, so the inputs are always inputs.
* You should have update_jacks callback to update the jack status
* appropriately.  This callback is called when the above mixer switches
* are changed.  In the update_jacks callback, you can use helper
* function is_shared_surrout() and is_shared_clfeout() that tell you
* whether the line-in and mic-in jacks should be handled as output or
* not.

this is an incredibly crucial point that motivated my mail in the first =
place!

these helper functions are wrappers around a check to =
ac97->indep_surround.

*who* fills this item out properly?? driver or user?

based on looking at ac97_patch.c::ac97_enum_text_info() it looks like =
the *driver* expects the *user* to tell the driver how the board is =
configured.

is my understanding correct?=20

if not, can somebody point me at a driver that figures this out for =
itself?

tnx!

johnu


* Takashi



------_=_NextPart_001_01C7577A.1251BFFF
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
<TITLE>RE: [Alsa-devel] doesn anybody actually ever assign to =
snd_ac97.indep_surround?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>
<BR>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----<BR>
From: Takashi Iwai [<A =
HREF=3D"mailto:tiwai@suse.de">mailto:tiwai@suse.de</A>]<BR>
Sent: Fri 2/23/2007 7:14 AM<BR>
To: John Utz<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] doesn anybody actually ever assign to =
snd_ac97.indep_surround?<BR>
<BR>
<BR>
* The basic idea behind this implementation is that you set up the<BR>
* surround setting dynamically.&nbsp; There are two switches to play<BR>
* important roles that are created usually:<BR>
*<BR>
* 1. Surround Jack Mode<BR>
* &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum: Shared / Independent<BR>
* 2. Channel Mode<BR>
*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum: 2ch / 4ch / 6ch<BR>
*<BR>
* When &quot;Shared&quot; is selected, the ac97 patch should set up the =
codec chip<BR>
* for the bidirectional pins.&nbsp; Inputs are turned to be surround =
outputs<BR>
* according to the the current status of channel mode (2, 4, 6ch).<BR>
* OTOH, when &quot;Independent&quot; is selected, it means that the =
board has<BR>
* separate surround jacks, so the inputs are always inputs.<BR>
* You should have update_jacks callback to update the jack status<BR>
* appropriately.&nbsp; This callback is called when the above mixer =
switches<BR>
* are changed.&nbsp; In the update_jacks callback, you can use =
helper<BR>
* function is_shared_surrout() and is_shared_clfeout() that tell you<BR>
* whether the line-in and mic-in jacks should be handled as output =
or<BR>
* not.<BR>
<BR>
this is an incredibly crucial point that motivated my mail in the first =
place!<BR>
<BR>
these helper functions are wrappers around a check to =
ac97-&gt;indep_surround.<BR>
<BR>
*who* fills this item out properly?? driver or user?<BR>
<BR>
based on looking at ac97_patch.c::ac97_enum_text_info() it looks like =
the *driver* expects the *user* to tell the driver how the board is =
configured.<BR>
<BR>
is my understanding correct?<BR>
<BR>
if not, can somebody point me at a driver that figures this out for =
itself?<BR>
<BR>
tnx!<BR>
<BR>
johnu<BR>
<BR>
<BR>
* Takashi<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7577A.1251BFFF--



--===============1915183755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1915183755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1915183755==--

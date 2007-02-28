From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: patch: ac97_patch.c - enable 'Smart 5.1' on VIA
 vt1617a ac97 codec - Version 2
Date: Wed, 28 Feb 2007 13:27:09 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8BE@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8BC@sea-exch-01.na.corp.dmxmusic.com>
	<75b66ecd0702281254q5ce4e5d3i1d70182c6120e676@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0942046165=="
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
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0942046165==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75B7F.3416841B"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75B7F.3416841B
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Lee;

thankyou for the prompt and thoughtful suggestion

comment below.


-----Original Message-----
From: rlrevell@gmail.com on behalf of Lee Revell
Sent: Wed 2/28/2007 12:54 PM
To: John Utz
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] patch: ac97_patch.c - enable 'Smart 5.1' on =
VIA vt1617a ac97 codec - Version 2
=20
On 2/28/07, John Utz <John.Utz@dmxmusic.com> wrote:
>  Note that the existing control Alternate Level to Surround Out may =
have to
> be disabled to hear the surround output.

* Shouldn't you update the alsa-lib config file for this card with hooks
* to do this automatically when the surround51 device is used?

That's a very good and eminently reasonable idea. Having said that....

I am deeply hesitant to do anything automagic at this point for several =
reasons:

1. This is my first ever patch and i may have hosed something, so why =
compound my folly? :-)

2. The documentation from via on vt1617a Smart 5.1  is quite mistake =
ridden and getting something to work on my 1 sample of a via epia c-7 =
was an exercise in forensics.

3. Smart 5.1 is not utilized on all boards - recall that i started from =
a patch 2 14rc2 submitted by Daniel Jacobowitz that enabled surround to =
work on a shuttle board with traditional jacks.

4. Board vendors that use Smart 5.1 may be using it differently then how =
things are done on the board that i have - what if they only =
bidirectionaled 1 connector? which one?


Ideally, fixing up the alsa-lib conf file should come after some results =
from the field.

tnx!

johnu


* Lee



------_=_NextPart_001_01C75B7F.3416841B
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
vt1617a ac97 codec - Version 2</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hello Lee;<BR>
<BR>
thankyou for the prompt and thoughtful suggestion<BR>
<BR>
comment below.<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: rlrevell@gmail.com on behalf of Lee Revell<BR>
Sent: Wed 2/28/2007 12:54 PM<BR>
To: John Utz<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] patch: ac97_patch.c - enable 'Smart 5.1' on =
VIA vt1617a ac97 codec - Version 2<BR>
<BR>
On 2/28/07, John Utz &lt;John.Utz@dmxmusic.com&gt; wrote:<BR>
&gt;&nbsp; Note that the existing control Alternate Level to Surround =
Out may have to<BR>
&gt; be disabled to hear the surround output.<BR>
<BR>
* Shouldn't you update the alsa-lib config file for this card with =
hooks<BR>
* to do this automatically when the surround51 device is used?<BR>
<BR>
That's a very good and eminently reasonable idea. Having said =
that....<BR>
<BR>
I am deeply hesitant to do anything automagic at this point for several =
reasons:<BR>
<BR>
1. This is my first ever patch and i may have hosed something, so why =
compound my folly? :-)<BR>
<BR>
2. The documentation from via on vt1617a Smart 5.1&nbsp; is quite =
mistake ridden and getting something to work on my 1 sample of a via =
epia c-7 was an exercise in forensics.<BR>
<BR>
3. Smart 5.1 is not utilized on all boards - recall that i started from =
a patch 2 14rc2 submitted by Daniel Jacobowitz that enabled surround to =
work on a shuttle board with traditional jacks.<BR>
<BR>
4. Board vendors that use Smart 5.1 may be using it differently then how =
things are done on the board that i have - what if they only =
bidirectionaled 1 connector? which one?<BR>
<BR>
<BR>
Ideally, fixing up the alsa-lib conf file should come after some results =
from the field.<BR>
<BR>
tnx!<BR>
<BR>
johnu<BR>
<BR>
<BR>
* Lee<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75B7F.3416841B--



--===============0942046165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0942046165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0942046165==--

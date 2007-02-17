From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: why would i *not* be able to update a register in
 ac97#0-0+regs when it's read write?
Date: Fri, 16 Feb 2007 17:52:15 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF897@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF896@sea-exch-01.na.corp.dmxmusic.com>
	<75b66ecd0702161724ncd340a8o1feea138fa98963c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1211011420=="
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

--===============1211011420==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75236.3FB35497"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75236.3FB35497
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

please forgive the lack of proper citing, i am stuck using outlook web =
access

-----Original Message-----
From: rlrevell@gmail.com on behalf of Lee Revell
Sent: Fri 2/16/2007 5:24 PM
To: John Utz
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] why would i *not* be able to update a register =
in ac97#0-0+regs when it's read write?
=20
On 2/16/07, John Utz <John.Utz@dmxmusic.com> wrote:
>
>
>
>
> Hello;
>
>  I have debugging turned on (--with-debug=3Ddetect) and the file is =
listed as
> writable:

You want to use --with-debug=3Dfull.  detect only enables debug code in
ALSA's card detection.



i think the configure help should be changed; what would you conclude =
from this list:

 --with-debug=3Dlevel      give the debug level (none,basic,full,detect)

to me, this certainly implies detect>full>basic>none


>  i believe that i want to set these to the 01 setting so that i can =
get
> surround out from Universal Audio Jacks on our MSI motherboard samples
>
>  am i barking up the wrong tree here?

Not sure - can you state the exact problem you are trying to solve?


there are two issues:

1. attempting to write to registers that are documented to be read-write =
doesnt
   result in a change of value; how do i debug this?

2. i have an msi motherboard with a via8237Rplus and a vt1618 8ch codec. =
it has only
   three plugs on the back that default to a stereo out, line in and mic =
in.

   they are supposed to be 'Universal Audio Jacks' and thus =
reconfigurable in the manner  =20
   mentioned in the documentation that i listed previously - i wont =
really know if i have this=20
   write until i get the write to work



Lee



------_=_NextPart_001_01C75236.3FB35497
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
<TITLE>RE: [Alsa-devel] why would i *not* be able to update a register =
in ac97#0-0+regs when it's read write?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>please forgive the lack of proper citing, i am stuck =
using outlook web access<BR>
<BR>
-----Original Message-----<BR>
From: rlrevell@gmail.com on behalf of Lee Revell<BR>
Sent: Fri 2/16/2007 5:24 PM<BR>
To: John Utz<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] why would i *not* be able to update a register =
in ac97#0-0+regs when it's read write?<BR>
<BR>
On 2/16/07, John Utz &lt;John.Utz@dmxmusic.com&gt; wrote:<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt;<BR>
&gt; Hello;<BR>
&gt;<BR>
&gt;&nbsp; I have debugging turned on (--with-debug=3Ddetect) and the =
file is listed as<BR>
&gt; writable:<BR>
<BR>
You want to use --with-debug=3Dfull.&nbsp; detect only enables debug =
code in<BR>
ALSA's card detection.<BR>
<BR>
<BR>
<BR>
i think the configure help should be changed; what would you conclude =
from this list:<BR>
<BR>
&nbsp;--with-debug=3Dlevel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; give the debug =
level (none,basic,full,detect)<BR>
<BR>
to me, this certainly implies detect&gt;full&gt;basic&gt;none<BR>
<BR>
<BR>
&gt;&nbsp; i believe that i want to set these to the 01 setting so that =
i can get<BR>
&gt; surround out from Universal Audio Jacks on our MSI motherboard =
samples<BR>
&gt;<BR>
&gt;&nbsp; am i barking up the wrong tree here?<BR>
<BR>
Not sure - can you state the exact problem you are trying to solve?<BR>
<BR>
<BR>
there are two issues:<BR>
<BR>
1. attempting to write to registers that are documented to be read-write =
doesnt<BR>
&nbsp;&nbsp; result in a change of value; how do i debug this?<BR>
<BR>
2. i have an msi motherboard with a via8237Rplus and a vt1618 8ch codec. =
it has only<BR>
&nbsp;&nbsp; three plugs on the back that default to a stereo out, line =
in and mic in.<BR>
<BR>
&nbsp;&nbsp; they are supposed to be 'Universal Audio Jacks' and thus =
reconfigurable in the manner&nbsp;&nbsp;<BR>
&nbsp;&nbsp; mentioned in the documentation that i listed previously - i =
wont really know if i have this<BR>
&nbsp;&nbsp; write until i get the write to work<BR>
<BR>
<BR>
<BR>
Lee<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75236.3FB35497--



--===============1211011420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1211011420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1211011420==--

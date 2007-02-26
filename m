From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: Patch: alsa-driver/hgcompile - check for a user
 set ALSAKERNELDIR first then set default
Date: Mon, 26 Feb 2007 10:49:37 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8B6@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8B3@sea-exch-01.na.corp.dmxmusic.com>
	<s5hirdpugnr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0510547656=="
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

--===============0510547656==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C759D7.2BE5F6EF"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C759D7.2BE5F6EF
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I've made the suggested change, will submit it after i test it sometime =
this evening.

i have to make sure it works correctly against three dirs instead of =
just two so it will take a bit longer to test.


-----Original Message-----
From: alsa-devel-bounces@lists.sourceforge.net on behalf of Takashi Iwai
Sent: Mon 2/26/2007 6:39 AM
To: John Utz
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Patch: alsa-driver/hgcompile - check for a =
user set ALSAKERNELDIR first then set default
=20
At Fri, 23 Feb 2007 16:07:18 -0800,
John Utz wrote:
>=20
> This patch simplifies the alsa-kernel discovery logic and provides =
better error
> reporting in the event of not finding $ALSAKERNELDIR/last.c
>=20
> Signed off by John L. Utz III john.utz@dmxmusic.com
> (tho why my uneducated opinion matters is beyond me)
>=20
>=20
> diff -r 62c0e3989241 hgcompile
> --- a/hgcompile	Thu Feb 22 13:24:18 2007 +0100
> +++ b/hgcompile	Fri Feb 23 15:54:24 2007 -0800
> @@ -27,17 +27,26 @@ fi
>  #  cd ..
>  #fi
> =20
> -# check for alsa-kernel directory
> -if [ -d alsa-kernel -a -f alsa-kernel/last.c ]; then
> -  ALSAKERNELDIR=3D"alsa-kernel"
> -else
> -  test -z $ALSAKERNELDIR && ALSAKERNELDIR=3D../alsa-kernel
> -  if [ ! -d $ALSAKERNELDIR -o ! -f $ALSAKERNELDIR/last.c ]; then
> -    echo "No alsa-kernel is found."
> -    echo "Please specify the correct location via ALSAKERNELDIR =
environment variable."
> +# check for caller set alsa-kernel directory, if empty set to default
> +
> +if [ -z $ALSAKERNELDIR ]; then
> +    ALSAKERNELDIR=3D../alsa-kernel
> +fi
> +
> +ALSACHKFILE=3D$ALSAKERNELDIR/last.c
> +
> +echo "ALSA Kernel Directory is: $ALSAKERNELDIR, checking for =
checkfile: $ALSACHKFILE"

./alsa-kernel should be in the higher priority than ../alsa-kernel.
Please add the check as found in the original version.
Otherwise the patch looks good.

Thanks,

Takashi

-------------------------------------------------------------------------=

Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share =
your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel



------_=_NextPart_001_01C759D7.2BE5F6EF
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
<TITLE>RE: [Alsa-devel] Patch: alsa-driver/hgcompile - check for a user =
set ALSAKERNELDIR first then set default</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>I've made the suggested change, will submit it after i =
test it sometime this evening.<BR>
<BR>
i have to make sure it works correctly against three dirs instead of =
just two so it will take a bit longer to test.<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: alsa-devel-bounces@lists.sourceforge.net on behalf of Takashi =
Iwai<BR>
Sent: Mon 2/26/2007 6:39 AM<BR>
To: John Utz<BR>
Cc: alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] Patch: alsa-driver/hgcompile - check for a =
user set ALSAKERNELDIR first then set default<BR>
<BR>
At Fri, 23 Feb 2007 16:07:18 -0800,<BR>
John Utz wrote:<BR>
&gt;<BR>
&gt; This patch simplifies the alsa-kernel discovery logic and provides =
better error<BR>
&gt; reporting in the event of not finding $ALSAKERNELDIR/last.c<BR>
&gt;<BR>
&gt; Signed off by John L. Utz III john.utz@dmxmusic.com<BR>
&gt; (tho why my uneducated opinion matters is beyond me)<BR>
&gt;<BR>
&gt;<BR>
&gt; diff -r 62c0e3989241 hgcompile<BR>
&gt; --- a/hgcompile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thu Feb 22 =
13:24:18 2007 +0100<BR>
&gt; +++ b/hgcompile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fri Feb 23 =
15:54:24 2007 -0800<BR>
&gt; @@ -27,17 +27,26 @@ fi<BR>
&gt;&nbsp; #&nbsp; cd ..<BR>
&gt;&nbsp; #fi<BR>
&gt;&nbsp;<BR>
&gt; -# check for alsa-kernel directory<BR>
&gt; -if [ -d alsa-kernel -a -f alsa-kernel/last.c ]; then<BR>
&gt; -&nbsp; ALSAKERNELDIR=3D&quot;alsa-kernel&quot;<BR>
&gt; -else<BR>
&gt; -&nbsp; test -z $ALSAKERNELDIR &amp;&amp; =
ALSAKERNELDIR=3D../alsa-kernel<BR>
&gt; -&nbsp; if [ ! -d $ALSAKERNELDIR -o ! -f $ALSAKERNELDIR/last.c ]; =
then<BR>
&gt; -&nbsp;&nbsp;&nbsp; echo &quot;No alsa-kernel is found.&quot;<BR>
&gt; -&nbsp;&nbsp;&nbsp; echo &quot;Please specify the correct location =
via ALSAKERNELDIR environment variable.&quot;<BR>
&gt; +# check for caller set alsa-kernel directory, if empty set to =
default<BR>
&gt; +<BR>
&gt; +if [ -z $ALSAKERNELDIR ]; then<BR>
&gt; +&nbsp;&nbsp;&nbsp; ALSAKERNELDIR=3D../alsa-kernel<BR>
&gt; +fi<BR>
&gt; +<BR>
&gt; +ALSACHKFILE=3D$ALSAKERNELDIR/last.c<BR>
&gt; +<BR>
&gt; +echo &quot;ALSA Kernel Directory is: $ALSAKERNELDIR, checking for =
checkfile: $ALSACHKFILE&quot;<BR>
<BR>
./alsa-kernel should be in the higher priority than ../alsa-kernel.<BR>
Please add the check as found in the original version.<BR>
Otherwise the patch looks good.<BR>
<BR>
Thanks,<BR>
<BR>
Takashi<BR>
<BR>
-------------------------------------------------------------------------=
<BR>
Take Surveys. Earn Cash. Influence the Future of IT<BR>
Join SourceForge.net's Techsay panel and you'll get the chance to share =
your<BR>
opinions on IT &amp; business topics through brief surveys-and earn =
cash<BR>
<A =
HREF=3D"http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforg=
e&CID=3DDEVDEV">http://www.techsay.com/default.php?page=3Djoin.php&p=3Dso=
urceforge&CID=3DDEVDEV</A><BR>
_______________________________________________<BR>
Alsa-devel mailing list<BR>
Alsa-devel@lists.sourceforge.net<BR>
<A =
HREF=3D"https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://=
lists.sourceforge.net/lists/listinfo/alsa-devel</A><BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C759D7.2BE5F6EF--



--===============0510547656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0510547656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0510547656==--

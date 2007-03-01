From: "John Utz" <John.Utz@dmxmusic.com>
Subject: Re: what criteria should be used to choose between
 snd_ac97_update_bits, snd_ac97_write, snd_ac97_write_cache ?
Date: Thu, 1 Mar 2007 11:34:31 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8C0@sea-exch-01.na.corp.dmxmusic.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8BB@sea-exch-01.na.corp.dmxmusic.com>
	<1172737540.9561.1177138781@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0219634093=="
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
To: Clemens Ladisch <cladisch@fastmail.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============0219634093==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75C38.B38F86D9"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75C38.B38F86D9
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Once Again;

Thankyou very much Clemens!

johnu


-----Original Message-----
From: Clemens Ladisch [mailto:cladisch@fastmail.net]
Sent: Thu 3/1/2007 12:25 AM
To: John Utz; alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] what criteria should be used to choose between =
snd_ac97_update_bits, snd_ac97_write, snd_ac97_write_cache ?
=20
John Utz wrote:
> are there reasons why one might prefer one of these or the other?

Because reading AC'97 registers is rather slow, there is a cache of
register values.

Use snd_ac97_write() for registers that should not be cached.

Use snd_ac97_write_cache() to write to a register that can be cached,
i.e., later reads can take the value from the cache instead of reading
from the codec.

Use snd_ac97_update() to write to a register where writing the same
value would not have any effect.

Use snd_ac97_update_bits() in the same situation as snd_ac97_update(),
but when you want to update only some bits.

Use snd_ac97_read() for uncached reads; and snd_ac97_read_cache() for
reads from the cache, if possible.


HTH
Clemens



------_=_NextPart_001_01C75C38.B38F86D9
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
<TITLE>RE: [Alsa-devel] what criteria should be used to choose between =
snd_ac97_update_bits, snd_ac97_write, snd_ac97_write_cache ?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Once Again;<BR>
<BR>
Thankyou very much Clemens!<BR>
<BR>
johnu<BR>
<BR>
<BR>
-----Original Message-----<BR>
From: Clemens Ladisch [<A =
HREF=3D"mailto:cladisch@fastmail.net">mailto:cladisch@fastmail.net</A>]<B=
R>
Sent: Thu 3/1/2007 12:25 AM<BR>
To: John Utz; alsa-devel@lists.sourceforge.net<BR>
Subject: Re: [Alsa-devel] what criteria should be used to choose between =
snd_ac97_update_bits, snd_ac97_write, snd_ac97_write_cache ?<BR>
<BR>
John Utz wrote:<BR>
&gt; are there reasons why one might prefer one of these or the =
other?<BR>
<BR>
Because reading AC'97 registers is rather slow, there is a cache of<BR>
register values.<BR>
<BR>
Use snd_ac97_write() for registers that should not be cached.<BR>
<BR>
Use snd_ac97_write_cache() to write to a register that can be =
cached,<BR>
i.e., later reads can take the value from the cache instead of =
reading<BR>
from the codec.<BR>
<BR>
Use snd_ac97_update() to write to a register where writing the same<BR>
value would not have any effect.<BR>
<BR>
Use snd_ac97_update_bits() in the same situation as =
snd_ac97_update(),<BR>
but when you want to update only some bits.<BR>
<BR>
Use snd_ac97_read() for uncached reads; and snd_ac97_read_cache() =
for<BR>
reads from the cache, if possible.<BR>
<BR>
<BR>
HTH<BR>
Clemens<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75C38.B38F86D9--



--===============0219634093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0219634093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0219634093==--

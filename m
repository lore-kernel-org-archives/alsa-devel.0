From: "John Utz" <John.Utz@dmxmusic.com>
Subject: doesn anybody actually ever assign to
	snd_ac97.indep_surround?
Date: Thu, 22 Feb 2007 16:12:50 -0800
Message-ID: <F8FB97052F1BEF409F7842E960E49B5AAAF8AD@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1061397230=="
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

--===============1061397230==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C756DF.5AD31F5F"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C756DF.5AD31F5F
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

It seems to me that this is something that one might want to fill out on =
a per card/motherboar basis, because it appears that there functions =
that try to make decisions based on it's status:

/* system has shared jacks with surround out enabled */
static inline int is_shared_surrout(struct snd_ac97 *ac97)
{
	return !ac97->indep_surround && is_surround_on(ac97);
}

/* system has shared jacks with center/lfe out enabled */
static inline int is_shared_clfeout(struct snd_ac97 *ac97)
{
	return !ac97->indep_surround && is_clfe_on(ac97);
}

/* system has shared jacks with line in enabled */
static inline int is_shared_linein(struct snd_ac97 *ac97)
{
	return !ac97->indep_surround && !is_surround_on(ac97);
}

/* system has shared jacks with mic in enabled */
static inline int is_shared_micin(struct snd_ac97 *ac97)
{
	return !ac97->indep_surround && !is_clfe_on(ac97);
}


so, where do i set this thing? how do i distinguish between a chip =
installed on a board/card with 3 bidirection plugs vs a board with =
several dedicated ins and outs?

or, is this whole thing an idea that is in the code but not actively =
utilized?

tnx!

johnu

------_=_NextPart_001_01C756DF.5AD31F5F
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
<TITLE>doesn anybody actually ever assign to =
snd_ac97.indep_surround?</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>It seems to me that this is something that one might =
want to fill out on a per card/motherboar basis, because it appears that =
there functions that try to make decisions based on it's status:<BR>
<BR>
/* system has shared jacks with surround out enabled */<BR>
static inline int is_shared_surrout(struct snd_ac97 *ac97)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
!ac97-&gt;indep_surround &amp;&amp; is_surround_on(ac97);<BR>
}<BR>
<BR>
/* system has shared jacks with center/lfe out enabled */<BR>
static inline int is_shared_clfeout(struct snd_ac97 *ac97)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
!ac97-&gt;indep_surround &amp;&amp; is_clfe_on(ac97);<BR>
}<BR>
<BR>
/* system has shared jacks with line in enabled */<BR>
static inline int is_shared_linein(struct snd_ac97 *ac97)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
!ac97-&gt;indep_surround &amp;&amp; !is_surround_on(ac97);<BR>
}<BR>
<BR>
/* system has shared jacks with mic in enabled */<BR>
static inline int is_shared_micin(struct snd_ac97 *ac97)<BR>
{<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
!ac97-&gt;indep_surround &amp;&amp; !is_clfe_on(ac97);<BR>
}<BR>
<BR>
<BR>
so, where do i set this thing? how do i distinguish between a chip =
installed on a board/card with 3 bidirection plugs vs a board with =
several dedicated ins and outs?<BR>
<BR>
or, is this whole thing an idea that is in the code but not actively =
utilized?<BR>
<BR>
tnx!<BR>
<BR>
johnu<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C756DF.5AD31F5F--



--===============1061397230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1061397230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1061397230==--

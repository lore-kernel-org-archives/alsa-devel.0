From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA on Mac Pro
Date: Thu, 14 Dec 2006 18:28:20 -0800
Message-ID: <1166149700.4142.169.camel@razman>
References: <4574866D.5070506@sourcegear.com>
	<45748CF5.8040800@sourcegear.com> <1165275957.32312.103.camel@razman>
	<4574BB17.1020807@sourcegear.com> <1165278602.32312.110.camel@razman>
	<4574EF72.8020207@sourcegear.com> <457828D7.4020908@teamprise.com>
	<1165535200.7530.63.camel@razman>
	<loom.20061211T231028-61@post.gmane.org>
	<1165877711.7530.253.camel@razman>
	<f0d712d60612111704x14717093p6e038641fc6e94e6@mail.gmail.com>
	<1166023329.4142.86.camel@razman>  <45802C28.1020401@sourcegear.com>
	<1166079716.4142.122.camel@razman>  <4581696B.5010908@sourcegear.com>
	<1166115089.4142.141.camel@razman>  <4581C0FB.8010603@sourcegear.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0566381002=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4581C0FB.8010603@sourcegear.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Shaw Terwilliger <sterwill@sourcegear.com>
Cc: Richard Anaya <richard.anaya@gmail.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============0566381002==
Content-Type: multipart/alternative; boundary="=-52CE/ntG9Z+/DwYqAGER"


--=-52CE/ntG9Z+/DwYqAGER
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

At this point, no.  The codec files that you and Richard have provided
show that everything should be working.  The mixer button for headphones
mutes and unmutes the proper jack.

At this point, I'm going to go ahead and push patch 4 into the tree, as
patches 5 & 6 didn't do anything.  I'll just document that headphones
aren't currently working.  I'll pick it up again after 1.0.14, unless
someone else fixes it first.  I need to move on to other systems that
currently have nothing.

At least we have sound.  That is a big step.

Tobin

On Thu, 2006-12-14 at 15:24 -0600, Shaw Terwilliger wrote:

> Tobin Davis wrote:
> > I've been reading the data sheet for that codec, and found that it has 3
> > gpio pins instead of 2.  This patch reverses the last change, and
> > enables that third gpio.  If this doesn't work, I'm at a loss.
> 
> No luck with this one either.  Any other kind of investigation I can do
> for you?
> 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-52CE/ntG9Z+/DwYqAGER
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
At this point, no.&nbsp; The codec files that you and Richard have provided show that everything should be working.&nbsp; The mixer button for headphones mutes and unmutes the proper jack.<BR>
<BR>
At this point, I'm going to go ahead and push patch 4 into the tree, as patches 5 &amp; 6 didn't do anything.&nbsp; I'll just document that headphones aren't currently working.&nbsp; I'll pick it up again after 1.0.14, unless someone else fixes it first.&nbsp; I need to move on to other systems that currently have nothing.<BR>
<BR>
At least we have sound.&nbsp; That is a big step.<BR>
<BR>
Tobin<BR>
<BR>
On Thu, 2006-12-14 at 15:24 -0600, Shaw Terwilliger wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Tobin Davis wrote:</FONT>
<FONT COLOR="#000000">&gt; I've been reading the data sheet for that codec, and found that it has 3</FONT>
<FONT COLOR="#000000">&gt; gpio pins instead of 2.  This patch reverses the last change, and</FONT>
<FONT COLOR="#000000">&gt; enables that third gpio.  If this doesn't work, I'm at a loss.</FONT>

<FONT COLOR="#000000">No luck with this one either.  Any other kind of investigation I can do</FONT>
<FONT COLOR="#000000">for you?</FONT>

</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-52CE/ntG9Z+/DwYqAGER--



--===============0566381002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0566381002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0566381002==--

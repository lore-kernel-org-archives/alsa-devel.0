From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Regression in 2.6.19 and 2.6.20 for snd_hda_intel
Date: Sat, 30 Dec 2006 20:08:14 -0800
Message-ID: <1167538094.9563.230.camel@localhost>
References: <45971053.7040609@lwfinger.net> <45971F39.4060301@gentoo.org>
	<45972EFD.3010103@lwfinger.net>  <45973283.7060801@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1335334225=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5197D2D4
	for <alsa-devel@alsa-project.org>; Sun, 31 Dec 2006 05:08:05 +0100 (MET)
In-Reply-To: <45973283.7060801@gentoo.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Daniel Drake <dsd@gentoo.org>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Stephen Hemminger <shemminger@osdl.org>, Larry Finger <larry.finger@lwfinger.net>
List-Id: alsa-devel@alsa-project.org


--===============1335334225==
Content-Type: multipart/alternative; boundary="=-Tc6tGDWa1UdjCHC6R7H/"


--=-Tc6tGDWa1UdjCHC6R7H/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Which alsa patch was this?  I'm not seeing anything in the hg logs for
this.  Or is this something from the kernel side?

Tobin

On Sat, 2006-12-30 at 22:46 -0500, Daniel Drake wrote:

> Larry Finger wrote:
> > You are correct. Only the "hda_codec-Add independent headphone volume control" needs to be reverted.
> 
> The best course of action is probably to file a report here:
> https://bugtrack.alsa-project.org/alsa-bug
> 
> Daniel
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-Tc6tGDWa1UdjCHC6R7H/
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
Which alsa patch was this?&nbsp; I'm not seeing anything in the hg logs for this.&nbsp; Or is this something from the kernel side?<BR>
<BR>
Tobin<BR>
<BR>
On Sat, 2006-12-30 at 22:46 -0500, Daniel Drake wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Larry Finger wrote:</FONT>
<FONT COLOR="#000000">&gt; You are correct. Only the &quot;hda_codec-Add independent headphone volume control&quot; needs to be reverted.</FONT>

<FONT COLOR="#000000">The best course of action is probably to file a report here:</FONT>
<FONT COLOR="#000000"><A HREF="https://bugtrack.alsa-project.org/alsa-bug">https://bugtrack.alsa-project.org/alsa-bug</A></FONT>

<FONT COLOR="#000000">Daniel</FONT>

<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys - and earn cash</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</A></FONT>
<FONT COLOR="#000000">_______________________________________________</FONT>
<FONT COLOR="#000000">Alsa-devel mailing list</FONT>
<FONT COLOR="#000000"><A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000"><A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
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

--=-Tc6tGDWa1UdjCHC6R7H/--



--===============1335334225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1335334225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1335334225==--

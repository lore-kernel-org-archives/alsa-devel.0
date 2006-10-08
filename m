From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Issue with Intel HDA Sound card 82801G
	(laptop	Medion)
Date: Sun, 08 Oct 2006 09:11:15 -0700
Message-ID: <1160323875.17297.94.camel@razman>
References: <1160227460.4527aa8501646@imp1-g19.free.fr>
	<1160242659.17297.64.camel@razman> <20061008110304.GA30604@trinnov.com>
	<1160323211.17615.100.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1085100130=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1160323211.17615.100.camel@mindpipe>
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


--===============1085100130==
Content-Type: multipart/alternative; boundary="=-ME1wtmsiZTYWz4/W05IN"


--=-ME1wtmsiZTYWz4/W05IN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2006-10-08 at 12:00 -0400, Lee Revell wrote:

> On Sun, 2006-10-08 at 13:03 +0200, Remy Bruno wrote:
> > I have the same sound card (I posted a mail a couple of days ago) and
> > I had
> > indeed the same problem, but it is now partly solved. I found on my
> > Windows XP
> > partition a directory with various GPL code. Among it, I found a file
> > called
> > "alsa-driver-1.0.9b_25a.tar.bz2". I tried to include its hda part
> > (alsa-kernel/pci/hda subdir) into the 1.0.13 driver part (Yes, I know,
> > it's
> > awful!...), and after some minor changes, I got it working, with
> > sound! 
> 
> Please post the changes in the form of a patch against ALSA 1.0.13.
> 

He sent me a copy of the source.  I'm working on making a diff against
1.0.9b (the base code that the changes were apllied to).  It's pretty
ugly so far.  Diff'ing against 1.0.13 is not a viable option, as there
is a lot of diverging code.


> AFAIK all the Realtek changes (which they never bothered to submit) have
> been merged already.
> 

Not true.  I have the latest Realtek drivers as well.  Major changes
were added to 1.0.12 and aren't in HG yet.  I'm also looking at that
this week.

Looks like I'll be busy for a little bit.  I'll keep everyone informed
of my progress.

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-ME1wtmsiZTYWz4/W05IN
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
On Sun, 2006-10-08 at 12:00 -0400, Lee Revell wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">On Sun, 2006-10-08 at 13:03 +0200, Remy Bruno wrote:</FONT>
<FONT COLOR="#000000">&gt; I have the same sound card (I posted a mail a couple of days ago) and</FONT>
<FONT COLOR="#000000">&gt; I had</FONT>
<FONT COLOR="#000000">&gt; indeed the same problem, but it is now partly solved. I found on my</FONT>
<FONT COLOR="#000000">&gt; Windows XP</FONT>
<FONT COLOR="#000000">&gt; partition a directory with various GPL code. Among it, I found a file</FONT>
<FONT COLOR="#000000">&gt; called</FONT>
<FONT COLOR="#000000">&gt; &quot;alsa-driver-1.0.9b_25a.tar.bz2&quot;. I tried to include its hda part</FONT>
<FONT COLOR="#000000">&gt; (alsa-kernel/pci/hda subdir) into the 1.0.13 driver part (Yes, I know,</FONT>
<FONT COLOR="#000000">&gt; it's</FONT>
<FONT COLOR="#000000">&gt; awful!...), and after some minor changes, I got it working, with</FONT>
<FONT COLOR="#000000">&gt; sound! </FONT>

<FONT COLOR="#000000">Please post the changes in the form of a patch against ALSA 1.0.13.</FONT>

</PRE>
</BLOCKQUOTE>
He sent me a copy of the source.&nbsp; I'm working on making a diff against 1.0.9b (the base code that the changes were apllied to).&nbsp; It's pretty ugly so far.&nbsp; Diff'ing against 1.0.13 is not a viable option, as there is a lot of diverging code.<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">AFAIK all the Realtek changes (which they never bothered to submit) have</FONT>
<FONT COLOR="#000000">been merged already.</FONT>

</PRE>
</BLOCKQUOTE>
Not true.&nbsp; I have the latest Realtek drivers as well.&nbsp; Major changes were added to 1.0.12 and aren't in HG yet.&nbsp; I'm also looking at that this week.<BR>
<BR>
Looks like I'll be busy for a little bit.&nbsp; I'll keep everyone informed of my progress.<BR>
<BR>
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

--=-ME1wtmsiZTYWz4/W05IN--



--===============1085100130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1085100130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1085100130==--

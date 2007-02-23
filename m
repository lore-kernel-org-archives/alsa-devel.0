From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Digital Microphones (DMICS) on Intel HD Audio	with
	Sigmatel Codecs
Date: Fri, 23 Feb 2007 15:54:12 -0800
Message-ID: <1172274852.1575.34.camel@razman.gruemaster.com>
References: <5FD5754DDBA0B1499B5A0B4BB54194859F6B31@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0885043947=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB54194859F6B31@fmsmsx411.amr.corp.intel.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Allyn, Mark A" <mark.a.allyn@intel.com>
Cc: mporter@embeddedalley.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0885043947==
Content-Type: multipart/alternative; boundary="=-InbOWCphgObPvKHuM5wc"


--=-InbOWCphgObPvKHuM5wc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I think Matt Porter was working on some systems with that last year.
Not sure what happened to him, as I haven't seen any patches since early
January.  He submitted some digital mic patches against the 9205 codec
code.

I could probably whip something together for you next week.  Send me the
system specs (lspci -s 0:1b -vn and cat /proc/asound/card0/codec*) and
I'll get on it.

Tobin

On Fri, 2007-02-23 at 15:37 -0800, Allyn, Mark A wrote:

> Hello:
>  
> Do any of you know if anyone has ever had alsa working with a digital
> microphone
> on a Sigmatel Codec within the Intel HAD device working; ie; a digital
> microphone
> only, that does not go through the normal analog input and mux?
> 
> Thank you
> 
> Mark Allyn
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-InbOWCphgObPvKHuM5wc
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
I think Matt Porter was working on some systems with that last year.&nbsp; Not sure what happened to him, as I haven't seen any patches since early January.&nbsp; He submitted some digital mic patches against the 9205 codec code.<BR>
<BR>
I could probably whip something together for you next week.&nbsp; Send me the system specs (lspci -s 0:1b -vn and cat /proc/asound/card0/codec*) and I'll get on it.<BR>
<BR>
Tobin<BR>
<BR>
On Fri, 2007-02-23 at 15:37 -0800, Allyn, Mark A wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hello:</FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">Do any of you know if anyone has ever had alsa working with a digital</FONT>
<FONT COLOR="#000000">microphone</FONT>
<FONT COLOR="#000000">on a Sigmatel Codec within the Intel HAD device working; ie; a digital</FONT>
<FONT COLOR="#000000">microphone</FONT>
<FONT COLOR="#000000">only, that does not go through the normal analog input and mux?</FONT>

<FONT COLOR="#000000">Thank you</FONT>

<FONT COLOR="#000000">Mark Allyn</FONT>

<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys-and earn cash</FONT>
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

--=-InbOWCphgObPvKHuM5wc--



--===============0885043947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0885043947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0885043947==--

From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Digital Microphones (DMICS) on Intel
	HD	AudiowithSigmatel Codecs
Date: Mon, 26 Feb 2007 11:35:05 -0800
Message-ID: <1172518505.4789.96.camel@razman.gruemaster.com>
References: <5FD5754DDBA0B1499B5A0B4BB5419485A34BD1@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1196311663=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB5419485A34BD1@fmsmsx411.amr.corp.intel.com>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1196311663==
Content-Type: multipart/alternative; boundary="=-xH6neOKkU500q0Az+0fC"


--=-xH6neOKkU500q0Az+0fC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I see what the problem is.  The documentation doesn't show the digital
mic on the widget diagram for the 9202, and I haven't had any requests
for it on the 9250 series (what this code was originally written for).
The issue is that for some codecs, there is no digital mic port, so
trying to configure a nonexistent port would cause the driver to fail.

I'll get a patch worked up and send it to you as soon as possible.

Tobin

On Mon, 2007-02-26 at 09:33 -0800, Allyn, Mark A wrote:

> This is a STAC 9202 device.
>  
> Here is the lspci segment with the -vn:
>  
> =====================
>  
> 00:1b.0 Class 0403: 8086:27d8 (rev 02)
>         Subsystem: 8384:7632
>         Flags: bus master, fast devsel, latency 0, IRQ 10
>         Memory at 32340000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [60] Message Signalled Interrupts: 64bit+
> Queue=0/0 Enable-
>         Capabilities: [70] Express Unknown type IRQ 0
> 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-xH6neOKkU500q0Az+0fC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
I see what the problem is.&nbsp; The documentation doesn't show the digital mic on the widget diagram for the 9202, and I haven't had any requests for it on the 9250 series (what this code was originally written for).&nbsp; The issue is that for some codecs, there is no digital mic port, so trying to configure a nonexistent port would cause the driver to fail.<BR>
<BR>
I'll get a patch worked up and send it to you as soon as possible.<BR>
<BR>
Tobin<BR>
<BR>
On Mon, 2007-02-26 at 09:33 -0800, Allyn, Mark A wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <TT><FONT COLOR="#000000">This is a STAC 9202 device.</FONT></TT><BR>
    <TT><FONT COLOR="#000000">&nbsp;</FONT></TT><BR>
    <TT><FONT COLOR="#000000">Here is the lspci segment with the -vn:</FONT></TT><BR>
    <TT><FONT COLOR="#000000">&nbsp;</FONT></TT><BR>
    <TT><FONT COLOR="#000000">=====================</FONT></TT><BR>
    <TT><FONT COLOR="#000000">&nbsp;</FONT></TT><BR>
    <TT><FONT COLOR="#000000">00:1b.0 Class 0403: 8086:27d8 (rev 02)</FONT></TT><BR>
    <TT><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subsystem: 8384:7632</FONT></TT><BR>
    <TT><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Flags: bus master, fast devsel, latency 0, IRQ 10</FONT></TT><BR>
    <TT><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Memory at 32340000 (64-bit, non-prefetchable) [size=16K]</FONT></TT><BR>
    <TT><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [50] Power Management version 2</FONT></TT><BR>
    <TT><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [60] Message Signalled Interrupts: 64bit+</FONT></TT><BR>
    <TT><FONT COLOR="#000000">Queue=0/0 Enable-</FONT></TT><BR>
    <TT><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Capabilities: [70] Express Unknown type IRQ 0</FONT></TT><BR>
    <BR>
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

--=-xH6neOKkU500q0Az+0fC--



--===============1196311663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1196311663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1196311663==--

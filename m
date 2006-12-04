From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA on Mac Pro
Date: Mon, 04 Dec 2006 12:51:51 -0800
Message-ID: <1165265511.32312.86.camel@razman>
References: <4574866D.5070506@sourcegear.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1304573500=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4574866D.5070506@sourcegear.com>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1304573500==
Content-Type: multipart/alternative; boundary="=-OubFLMAGee3MRNLJ3scH"


--=-OubFLMAGee3MRNLJ3scH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Well, to start, we'll need to know the exact codec information.  Type
"cat /proc/asound/card0/codec*" to find out.  To add your specific
configuration to the driver (if it isn't in the tree already), we'll
also need the subsystem ID from lspci.  Assuming the audio device is on
pci bus 0:1b.0, type 'lspci -s 0:1b -vn" to get that.

>From there, it's probably just a matter of trying different config
models from the ALSA-Configuration.txt (it's in
alsa-driver-1.0.13/alsa-kernel/Documentation if you downloaded the
driver source, or it is in the kernel documentation).

Tobin Davis

On Mon, 2006-12-04 at 14:34 -0600, Shaw Terwilliger wrote:

> I just got a new Mac Pro (not MacBook Pro) that appears to contain an
> on-board Intel High Definition Audio interface (Realtek variation, as
> far as I can tell via "detect" debug).  The ALSA drivers in 2.6.17
> detect the card correctly and my mixer shows all the right channels, but
> no sound comes out.  I compiled and installed the latest ALSA (1.0.13)
> and have the same issue.  I have only found a few others running Linux
> on the Mac Pro, and they seem to have the same issue.
> 
> Other people have reported the MacBook Pro had similar issues (no sound
> out the line-out jack), and a patch was floating around that rewired
> some of the mixing to make it work.  The MacBook Pro seems to use a
> different HDA implementation (Sigmatel, I think) so I'm not sure if the
> patch logic makes sense on the Mac Pro.
> 
> I figured this list was probably the best place to ask: has anyone
> hacked on this driver before?  Where should I start digging?
> 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-OubFLMAGee3MRNLJ3scH
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Well, to start, we'll need to know the exact codec information.&nbsp; Type &quot;cat /proc/asound/card0/codec*&quot; to find out.&nbsp; To add your specific configuration to the driver (if it isn't in the tree already), we'll also need the subsystem ID from lspci.&nbsp; Assuming the audio device is on pci bus 0:1b.0, type 'lspci -s 0:1b -vn&quot; to get that.<BR>
<BR>
>From there, it's probably just a matter of trying different config models from the ALSA-Configuration.txt (it's in alsa-driver-1.0.13/alsa-kernel/Documentation if you downloaded the driver source, or it is in the kernel documentation).<BR>
<BR>
Tobin Davis<BR>
<BR>
On Mon, 2006-12-04 at 14:34 -0600, Shaw Terwilliger wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">I just got a new Mac Pro (not MacBook Pro) that appears to contain an</FONT>
<FONT COLOR="#000000">on-board Intel High Definition Audio interface (Realtek variation, as</FONT>
<FONT COLOR="#000000">far as I can tell via &quot;detect&quot; debug).  The ALSA drivers in 2.6.17</FONT>
<FONT COLOR="#000000">detect the card correctly and my mixer shows all the right channels, but</FONT>
<FONT COLOR="#000000">no sound comes out.  I compiled and installed the latest ALSA (1.0.13)</FONT>
<FONT COLOR="#000000">and have the same issue.  I have only found a few others running Linux</FONT>
<FONT COLOR="#000000">on the Mac Pro, and they seem to have the same issue.</FONT>

<FONT COLOR="#000000">Other people have reported the MacBook Pro had similar issues (no sound</FONT>
<FONT COLOR="#000000">out the line-out jack), and a patch was floating around that rewired</FONT>
<FONT COLOR="#000000">some of the mixing to make it work.  The MacBook Pro seems to use a</FONT>
<FONT COLOR="#000000">different HDA implementation (Sigmatel, I think) so I'm not sure if the</FONT>
<FONT COLOR="#000000">patch logic makes sense on the Mac Pro.</FONT>

<FONT COLOR="#000000">I figured this list was probably the best place to ask: has anyone</FONT>
<FONT COLOR="#000000">hacked on this driver before?  Where should I start digging?</FONT>

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

--=-OubFLMAGee3MRNLJ3scH--



--===============1304573500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1304573500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1304573500==--

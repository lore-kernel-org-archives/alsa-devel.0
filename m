From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA on Mac Pro
Date: Mon, 04 Dec 2006 16:30:02 -0800
Message-ID: <1165278602.32312.110.camel@razman>
References: <4574866D.5070506@sourcegear.com>
	<1165265511.32312.86.camel@razman>  <45748CF5.8040800@sourcegear.com>
	<1165275957.32312.103.camel@razman> <4574BB17.1020807@sourcegear.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0516953857=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4574BB17.1020807@sourcegear.com>
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


--===============0516953857==
Content-Type: multipart/alternative; boundary="=-gU+t8rHQHcqJLNFLDrzO"


--=-gU+t8rHQHcqJLNFLDrzO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-12-04 at 18:19 -0600, Shaw Terwilliger wrote:


> I've verified that lspci doesn't show any subsystems for the HDA device.
>  It does show (known) subsystems for other devices (USB, SATA, IDE, etc.).
> 

This is strange.  Could you try 'lspci -s  0:1b -vv"?  It should have
something there, but maybe not.

> Kernel messages are from 1.0.13 with --with-debug=full:
> 

I had thought you compiled with "--with-debug=detect".  This actually
gives different output than full debug mode.


> Earlier today with no model arg present, I unmuted and maxed out all the
> mixer channels, and found that with PCM and Surround channels all the
> way up, and external amplifier up, I could hear the music I had playing,
> though it was still very quiet.  So at least one channel is finding the
> line-out jack, quietly.

This is actually good info.  Interesting that sound is coming out from
 the Surround channels.  The low volume could mean that EAPD still needs
to be set.

I'll look more into this tomorrow.  Hopefully I can get a patch for you
to test.

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-gU+t8rHQHcqJLNFLDrzO
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
On Mon, 2006-12-04 at 18:19 -0600, Shaw Terwilliger wrote:<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">I've verified that lspci doesn't show any subsystems for the HDA device.</FONT>
<FONT COLOR="#000000"> It does show (known) subsystems for other devices (USB, SATA, IDE, etc.).</FONT>

</PRE>
</BLOCKQUOTE>
This is strange.&nbsp; Could you try 'lspci -s&nbsp; 0:1b -vv&quot;?&nbsp; It should have something there, but maybe not.
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Kernel messages are from 1.0.13 with --with-debug=full:</FONT>

</PRE>
</BLOCKQUOTE>
I had thought you compiled with &quot;--with-debug=detect&quot;.&nbsp; This actually gives different output than full debug mode.<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Earlier today with no model arg present, I unmuted and maxed out all the</FONT>
<FONT COLOR="#000000">mixer channels, and found that with PCM and Surround channels all the</FONT>
<FONT COLOR="#000000">way up, and external amplifier up, I could hear the music I had playing,</FONT>
<FONT COLOR="#000000">though it was still very quiet.  So at least one channel is finding the</FONT>
<FONT COLOR="#000000">line-out jack, quietly.</FONT>
</PRE>
</BLOCKQUOTE>
This is actually good info.&nbsp; Interesting that sound is coming out from<BR>
 the Surround channels.&nbsp; The low volume could mean that EAPD still needs to be set.<BR>
<BR>
I'll look more into this tomorrow.&nbsp; Hopefully I can get a patch for you to test.<BR>
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

--=-gU+t8rHQHcqJLNFLDrzO--



--===============0516953857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0516953857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0516953857==--

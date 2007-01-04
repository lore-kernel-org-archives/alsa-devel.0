From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: what information to provide for bug report
	of	ALC880 sound card problems ?
Date: Thu, 04 Jan 2007 07:12:09 -0800
Message-ID: <1167923529.28242.103.camel@localhost>
References: <37aUfFwc.1167922328.3333200.postmaster@valombre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0461668802=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <37aUfFwc.1167922328.3333200.postmaster@valombre.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Eric De Vito <eric@valombre.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0461668802==
Content-Type: multipart/alternative; boundary="=-9J1+BhPkrkuahlz6ynko"


--=-9J1+BhPkrkuahlz6ynko
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

To start, what version of alsa are you running
(cat /proc/asound/version)?  You should download at least
alsa-driver-1.0.14rc1.tar.bz2 from the alsa-project.org site.  For
debugging and configuring your system, it is recommended that you build
with "./configure --with-debug=detect --with-cards=hda-intel".

Clear the dmesg log with "dmesg -c" prior to loading the driver.  After
loading, the driver will output some basic information that we need for
development.  Also send "cat /proc/asound/card0/codec*
>Sager9860-codec.txt", and "lspci -s 0:1b -vn" output.

These three things will help us to get your system added quickly.

Thanks,

Tobin

On Thu, 2007-01-04 at 14:52 +0000, Eric De Vito wrote:

> I have a laptop (pentiumIV, Sager9860/D900t model) with an ALC880 Realtek
> integrated sound card. I have problems and bugs with any alsa versions,
> with an Ubuntu Edgy system. What must I provide as informations that may
> be useful for tracking bugs ?
> Thank you
> 
> Eric
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

--=-9J1+BhPkrkuahlz6ynko
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
To start, what version of alsa are you running (cat /proc/asound/version)?&nbsp; You should download at least alsa-driver-1.0.14rc1.tar.bz2 from the alsa-project.org site.&nbsp; For debugging and configuring your system, it is recommended that you build with &quot;./configure --with-debug=detect --with-cards=hda-intel&quot;.<BR>
<BR>
Clear the dmesg log with &quot;dmesg -c&quot; prior to loading the driver.&nbsp; After loading, the driver will output some basic information that we need for development.&nbsp; Also send &quot;cat /proc/asound/card0/codec* &gt;<FONT COLOR="#000000">Sager9860</FONT>-codec.txt&quot;, and &quot;lspci -s 0:1b -vn&quot; output.<BR>
<BR>
These three things will help us to get your system added quickly.<BR>
<BR>
Thanks,<BR>
<BR>
Tobin<BR>
<BR>
On Thu, 2007-01-04 at 14:52 +0000, Eric De Vito wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">I have a laptop (pentiumIV, Sager9860/D900t model) with an ALC880 Realtek</FONT>
<FONT COLOR="#000000">integrated sound card. I have problems and bugs with any alsa versions,</FONT>
<FONT COLOR="#000000">with an Ubuntu Edgy system. What must I provide as informations that may</FONT>
<FONT COLOR="#000000">be useful for tracking bugs ?</FONT>
<FONT COLOR="#000000">Thank you</FONT>

<FONT COLOR="#000000">Eric</FONT>

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

--=-9J1+BhPkrkuahlz6ynko--



--===============0461668802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0461668802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0461668802==--

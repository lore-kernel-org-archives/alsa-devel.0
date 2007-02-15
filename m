From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: trying to get sound working at a mac
	book	pro	(core 2 duo)
Date: Wed, 14 Feb 2007 17:13:20 -0800
Message-ID: <1171502000.7083.23.camel@razman.gruemaster.com>
References: <564d96fb0702141121j185378d1m4c3a192831442fb7@mail.gmail.com>
	<1171482019.7083.8.camel@razman.gruemaster.com>
	<564d96fb0702141209g6b032115pebe2ce1a7e3de57b@mail.gmail.com>
	<564d96fb0702141235p4ed263fdnb14de941be27e334@mail.gmail.com>
	<564d96fb0702141256t55f2febbna1e9bbdf50c200d@mail.gmail.com>
	<s5hire4l6ho.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1169970286=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 59B10362
	for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2007 02:13:22 +0100 (MET)
In-Reply-To: <s5hire4l6ho.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1169970286==
Content-Type: multipart/alternative; boundary="=-83nX02zoY253nL+idl+j"


--=-83nX02zoY253nL+idl+j
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2007-02-14 at 23:27 +0100, Takashi Iwai wrote:

> The driver always takes PCI SSID as a key for table-lookup.
> The codec has its own SSID (and often a different value from PCI SSID)
> as proc shows, but it's not used anywhere in the driver code.
> 
> 

This is the second time I've run into a system that has an HD audio
chip, but doesn't have a unique PCI SSID. The first was the Mac Pro,
where there is no SSID for the HD audio bus (see my patch for ALC885 Mac
Pro - 12/15).

Takashi, we may want to look into a function that uses the codec
subsystem id as a fallback, with the PCI SSID taking precedence.  We
already detect the HD Audio bus, through the PCI ID.  Let me know.


-- 
Tobin Davis <tdavis@dsl-only.net>

--=-83nX02zoY253nL+idl+j
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
On Wed, 2007-02-14 at 23:27 +0100, Takashi Iwai wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <TT><FONT COLOR="#000000">The driver always takes PCI SSID as a key for table-lookup.</FONT></TT><BR>
    <TT><FONT COLOR="#000000">The codec has its own SSID (and often a different value from PCI SSID)</FONT></TT><BR>
    <TT><FONT COLOR="#000000">as proc shows, but it's not used anywhere in the driver code.</FONT></TT><BR>
    <BR>
    <BR>
</BLOCKQUOTE>
This is the second time I've run into a system that has an HD audio chip, but doesn't have a unique PCI SSID. The first was the Mac Pro, where there is no SSID for the HD audio bus (see my patch for ALC885 Mac Pro - 12/15).<BR>
<BR>
Takashi, we may want to look into a function that uses the codec subsystem id as a fallback, with the PCI SSID taking precedence.&nbsp; We already detect the HD Audio bus, through the PCI ID.&nbsp; Let me know.<BR>
<BR>
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

--=-83nX02zoY253nL+idl+j--



--===============1169970286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1169970286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1169970286==--

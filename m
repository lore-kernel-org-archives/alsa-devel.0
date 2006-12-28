From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: BUG in >=1.0.13rc1
Date: Thu, 28 Dec 2006 10:27:53 -0800
Message-ID: <1167330473.9563.83.camel@localhost>
References: <20061227220022.GB28449@volumehost.com>
	<s5hodpoxja6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1033660042=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hodpoxja6.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1033660042==
Content-Type: multipart/alternative; boundary="=-8uNAPg1PKLYacPy/Yif4"


--=-8uNAPg1PKLYacPy/Yif4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This could also explain why my patch for the Stac9250 is breaking.

I've forwarded this fix to my testers.  Hope it fixes their systems.

On Thu, 2006-12-28 at 14:05 +0100, Takashi Iwai wrote:

> Could you try ALSA HG version?
> There was a bug in hda_generic.c that may cause Oops, and got fixed
> recently after 1.0.14rc1.
> 
> 
> Takashi 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-8uNAPg1PKLYacPy/Yif4
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
This could also explain why my patch for the Stac9250 is breaking.<BR>
<BR>
I've forwarded this fix to my testers.&nbsp; Hope it fixes their systems.<BR>
<BR>
On Thu, 2006-12-28 at 14:05 +0100, Takashi Iwai wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <TT><FONT COLOR="#000000">Could you try ALSA HG version?</FONT></TT><BR>
    <TT><FONT COLOR="#000000">There was a bug in hda_generic.c that may cause Oops, and got fixed</FONT></TT><BR>
    <TT><FONT COLOR="#000000">recently after 1.0.14rc1.</FONT></TT><BR>
    <BR>
    <BR>
    <TT><FONT COLOR="#000000">Takashi</FONT></TT><FONT COLOR="#000000"> </FONT><BR>
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

--=-8uNAPg1PKLYacPy/Yif4--



--===============1033660042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1033660042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1033660042==--

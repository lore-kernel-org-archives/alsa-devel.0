From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: are the alsa wiki instructions for
	mercurial	correct?
Date: Wed, 21 Feb 2007 18:20:44 -0800
Message-ID: <1172110844.3728.1.camel@razman.gruemaster.com>
References: <F8FB97052F1BEF409F7842E960E49B5AAAF8A2@sea-exch-01.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0121121030=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <F8FB97052F1BEF409F7842E960E49B5AAAF8A2@sea-exch-01.na.corp.dmxmusic.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: John Utz <John.Utz@dmxmusic.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0121121030==
Content-Type: multipart/alternative; boundary="=-at4v/JkVtqOvJr9e37So"


--=-at4v/JkVtqOvJr9e37So
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

use http://hg.alsa-project.org/alsa-driver and
http://hg.alsa-project.org/alsa-kernel.

The wiki is wrong (and hasn't been updated).

Tobin

On Wed, 2007-02-21 at 17:13 -0800, John Utz wrote:

> i executed the following steps from the wiki:
> 
> # Get a copy of the repository
> cd alsa-hg
> 
> hg clone http://hg-mirror.alsa-project.org/alsa-driver alsa-driver
> hg clone http://hg-mirror.alsa-project.org/alsa-kernel alsa-kernel
> 
> # Get latest
> 
> cd alsa-driver
> hg pull -u
> 
> cd alsa-kernel
> hg pull -u
> 
> # Create a working copy
> hg clone alsa-driver alsa-driver-fixbug1
> cd alsa-driver-fixbug1
> 
> 
> 
> However, all that i seem to be pulling down is the stub file and not
> the real iplementations
> 
> ie:
> 
> [jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l {} \;
> -rw-r--r-- 1 jutz jutz 74 Feb 21
> 17:07 ./alsa-driver/pci/ac97/ac97_patch.c
> -rw-r--r-- 1 jutz jutz 74 Feb 21
> 17:17 ./alsa-driver-2908/pci/ac97/ac97_patch.c
> -rw-r--r-- 1 jutz jutz 74 Feb 21
> 17:13 ./alsa-kernel-2908/pci/ac97/ac97_patch.c
> -rw-r--r-- 1 jutz jutz 74 Feb 21
> 17:07 ./alsa-kernel/pci/ac97/ac97_patch.c
> 
> 
> these are just the files that include the 'real' implementations:
> 
> [jutz@localhost alsa-hg]$ more alsa-driver/pci/ac97/ac97_patch.c
> #define __NO_VERSION__
> #include "../../alsa-kernel/pci/ac97/ac97_patch.c"
> 
> 
> am i doing something wrong or is mercurial missing some stuff?
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________ Alsa-devel mailing list Alsa-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-at4v/JkVtqOvJr9e37So
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
  <TITLE>are the alsa wiki instructions for mercurial correct?</TITLE>
</HEAD>
<BODY>
use <A HREF="http://hg.alsa-project.org/alsa-driver">http://hg.alsa-project.org/alsa-driver</A> and <A HREF="http://hg.alsa-project.org/alsa-kernel.">http://hg.alsa-project.org/alsa-kernel.</A><BR>
<BR>
The wiki is wrong (and hasn't been updated).<BR>
<BR>
Tobin<BR>
<BR>
On Wed, 2007-02-21 at 17:13 -0800, John Utz wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">i executed the following steps from the wiki:</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000"># Get a copy of the repository</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">cd alsa-hg</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">hg clone <A HREF="http://hg-mirror.alsa-project.org/alsa-driver">http://hg-mirror.alsa-project.org/alsa-driver</A> alsa-driver</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">hg clone <A HREF="http://hg-mirror.alsa-project.org/alsa-kernel">http://hg-mirror.alsa-project.org/alsa-kernel</A> alsa-kernel</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000"># Get latest</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">cd alsa-driver</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">hg pull -u</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">cd alsa-kernel</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">hg pull -u</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000"># Create a working copy</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">hg clone alsa-driver alsa-driver-fixbug1</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">cd alsa-driver-fixbug1</FONT></FONT><BR>
    <BR>
    <BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">However, all that i seem to be pulling down is the stub file and not the real iplementations</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">ie:</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">[jutz@localhost alsa-hg]$ find . -name ac97_patch.c -exec ls -l {} \;</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">-rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 ./alsa-driver/pci/ac97/ac97_patch.c</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">-rw-r--r-- 1 jutz jutz 74 Feb 21 17:17 ./alsa-driver-2908/pci/ac97/ac97_patch.c</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">-rw-r--r-- 1 jutz jutz 74 Feb 21 17:13 ./alsa-kernel-2908/pci/ac97/ac97_patch.c</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">-rw-r--r-- 1 jutz jutz 74 Feb 21 17:07 ./alsa-kernel/pci/ac97/ac97_patch.c</FONT></FONT><BR>
    <BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">these are just the files that include the 'real' implementations:</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">[jutz@localhost alsa-hg]$ more alsa-driver/pci/ac97/ac97_patch.c</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">#define __NO_VERSION__</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">#include &quot;../../alsa-kernel/pci/ac97/ac97_patch.c&quot;</FONT></FONT><BR>
    <BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">am i doing something wrong or is mercurial missing some stuff?</FONT></FONT><BR>
    <BR>
<PRE>
<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys-and earn cash</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</A></FONT>
<FONT COLOR="#000000">_______________________________________________ Alsa-devel mailing list <A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A> <A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
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

--=-at4v/JkVtqOvJr9e37So--



--===============0121121030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0121121030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0121121030==--

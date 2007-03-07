From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: [PATCH] hda empty modelname comparison
Date: Wed, 07 Mar 2007 12:04:30 -0800
Message-ID: <1173297870.4531.4.camel@razman.gruemaster.com>
References: <45ED81BE.4080606@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-CMOBqwCETMZvaH/hKCto"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45ED81BE.4080606@amd.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Joachim Deguara <joachim.deguara@amd.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-CMOBqwCETMZvaH/hKCto
Content-Type: multipart/alternative; boundary="=-B0Mfz311duKCwRspLEON"


--=-B0Mfz311duKCwRspLEON
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-03-06 at 15:59 +0100, Joachim Deguara wrote:

> This patch prevents a comparison between a possibly empty modelname
> string in the hda code.
> 
> -Joachim


Unfortunately, the way the original patch was written, the only options
are generic or segfault.  Your patch just removes the segfault, sending
all cards to the generic parser.

I've tested a slightly different approach, based on your empty test,
just reverse logic.  Test it to confirm that it works.  It works on my
system with a Conexant reference board and a Sigmatel STAC9227 (both on
the same system).



Signed off by Tobin Davis <tdavis@dsl-only.net>

--=-B0Mfz311duKCwRspLEON
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
On Tue, 2007-03-06 at 15:59 +0100, Joachim Deguara wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">This patch prevents a comparison between a possibly empty modelname</FONT>
<FONT COLOR="#000000">string in the hda code.</FONT>

<FONT COLOR="#000000">-Joachim</FONT>
</PRE>
</BLOCKQUOTE>
<BR>
Unfortunately, the way the original patch was written, the only options are generic or segfault.&nbsp; Your patch just removes the segfault, sending all cards to the generic parser.<BR>
<BR>
I've tested a slightly different approach, based on your empty test, just reverse logic.&nbsp; Test it to confirm that it works.&nbsp; It works on my system with a Conexant reference board and a Sigmatel STAC9227 (both on the same system).<BR>
<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<BR>
Signed off by Tobin Davis &lt;tdavis@dsl-only.net&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-B0Mfz311duKCwRspLEON--

--=-CMOBqwCETMZvaH/hKCto
Content-Disposition: attachment; filename=generic-fix.patch
Content-Type: text/x-patch; name=generic-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r bf193701a812 pci/hda/hda_codec.c
--- a/pci/hda/hda_codec.c	Mon Feb 26 16:07:42 2007 +0100
+++ b/pci/hda/hda_codec.c	Wed Mar 07 12:02:37 2007 -0800
@@ -573,7 +573,7 @@ int snd_hda_codec_new(struct hda_bus *bu
 							 0);
 	}
 
-	if (strcmp(codec->bus->modelname, "generic"))
+	if (!(codec->bus->modelname && strcmp(codec->bus->modelname, "generic")))
 		codec->preset = find_codec_preset(codec);
 	if (! *bus->card->mixername)
 		snd_hda_get_codec_name(codec, bus->card->mixername,

--=-CMOBqwCETMZvaH/hKCto
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-CMOBqwCETMZvaH/hKCto
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-CMOBqwCETMZvaH/hKCto--

From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Recently committed change to kernel
	2.6.20.2	breaks snd-hda-intel on AOpen EZ482
Date: Sat, 17 Mar 2007 01:22:51 -0700
Message-ID: <1174119771.4484.146.camel@razman.gruemaster.com>
References: <697313.33968.qm@web53613.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-JoxT+u6PuQYCcaj7g60p"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <697313.33968.qm@web53613.mail.yahoo.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Huw Hawkins <huwrh@yahoo.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-JoxT+u6PuQYCcaj7g60p
Content-Type: multipart/alternative; boundary="=-gw8YYrOTiZOVRN8dCmVY"


--=-gw8YYrOTiZOVRN8dCmVY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks.  This was actually discovered earlier this week and a change
specific to ATI chipsets has been made.  Attached is the new patch that
was added to alsa.

Tobin

On Sat, 2007-03-17 at 18:05 +1100, Huw Hawkins wrote:

> Hi,
>   The change under kernel 2.4.20.2 which reduced the
> number of codexs (as in the below bit of the patch
> files) from 4 to 3 stops the sound card properly
> initialising (failed with an error about not finding
> codecs). Bumping it back up to 4 gets me my sound
> devices back again.
> 
> --------------------------------------------------
> 
> diff --git a/sound/pci/hda/hda_intel.c
> b/sound/pci/hda/hda_intel.c
> index 1a7e821..77f8ec7 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -199,7 +199,7 @@ enum { SDI0, SDI1, SDI2, SDI3,
> SDO0, SDO1, SDO2, SDO3 };
> 
>  /* STATESTS int mask: SD2,SD1,SD0 */
>  #define STATESTS_INT_MASK      0x07
> -#define AZX_MAX_CODECS         4
> +#define AZX_MAX_CODECS         3
> 
> -----------------------------------------------
> 
> OUtput os lspci -vv is as follows:
> 
> 00:14.2 Audio device: ATI Technologies Inc SB450 HDA
> Audio (rev 01)
>         Subsystem: AOPEN Inc. Unknown device 0569
>         Control: I/O- Mem+ BusMaster+ SpecCycle-
> MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr-
> DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64, Cache Line Size: 32 bytes
>         Interrupt: pin ? routed to IRQ 16
>         Region 0: Memory at fe024000 (64-bit,
> non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2-
> AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0
> PME-
>         Capabilities: [60] Message Signalled
> Interrupts: Mask- 64bit+ Queue=0/0 Enable-
>                 Address: 0000000000000000  Data: 0000
> 
> ----------------------------------------------
> 
>   I'm not on this list so please CC me in any reply,
> or if more info is required. I couldn't see this in
> the bugtrack, although admittedly I didn't look too
> hard so appologies if it is known.
> 
> Thanks
> 
> Huw
> 
> huwrh at yahoo dot com dot au
> 
> Send instant messages to your online friends http://au.messenger.yahoo.com 
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

--=-gw8YYrOTiZOVRN8dCmVY
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
Thanks.&nbsp; This was actually discovered earlier this week and a change specific to ATI chipsets has been made.&nbsp; Attached is the new patch that was added to alsa.<BR>
<BR>
Tobin<BR>
<BR>
On Sat, 2007-03-17 at 18:05 +1100, Huw Hawkins wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Hi,</FONT>
<FONT COLOR="#000000">  The change under kernel 2.4.20.2 which reduced the</FONT>
<FONT COLOR="#000000">number of codexs (as in the below bit of the patch</FONT>
<FONT COLOR="#000000">files) from 4 to 3 stops the sound card properly</FONT>
<FONT COLOR="#000000">initialising (failed with an error about not finding</FONT>
<FONT COLOR="#000000">codecs). Bumping it back up to 4 gets me my sound</FONT>
<FONT COLOR="#000000">devices back again.</FONT>

<FONT COLOR="#000000">--------------------------------------------------</FONT>

<FONT COLOR="#000000">diff --git a/sound/pci/hda/hda_intel.c</FONT>
<FONT COLOR="#000000">b/sound/pci/hda/hda_intel.c</FONT>
<FONT COLOR="#000000">index 1a7e821..77f8ec7 100644</FONT>
<FONT COLOR="#000000">--- a/sound/pci/hda/hda_intel.c</FONT>
<FONT COLOR="#000000">+++ b/sound/pci/hda/hda_intel.c</FONT>
<FONT COLOR="#000000">@@ -199,7 +199,7 @@ enum { SDI0, SDI1, SDI2, SDI3,</FONT>
<FONT COLOR="#000000">SDO0, SDO1, SDO2, SDO3 };</FONT>

<FONT COLOR="#000000"> /* STATESTS int mask: SD2,SD1,SD0 */</FONT>
<FONT COLOR="#000000"> #define STATESTS_INT_MASK      0x07</FONT>
<FONT COLOR="#000000">-#define AZX_MAX_CODECS         4</FONT>
<FONT COLOR="#000000">+#define AZX_MAX_CODECS         3</FONT>

<FONT COLOR="#000000">-----------------------------------------------</FONT>

<FONT COLOR="#000000">OUtput os lspci -vv is as follows:</FONT>

<FONT COLOR="#000000">00:14.2 Audio device: ATI Technologies Inc SB450 HDA</FONT>
<FONT COLOR="#000000">Audio (rev 01)</FONT>
<FONT COLOR="#000000">        Subsystem: AOPEN Inc. Unknown device 0569</FONT>
<FONT COLOR="#000000">        Control: I/O- Mem+ BusMaster+ SpecCycle-</FONT>
<FONT COLOR="#000000">MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-</FONT>
<FONT COLOR="#000000">        Status: Cap+ 66MHz- UDF- FastB2B- ParErr-</FONT>
<FONT COLOR="#000000">DEVSEL=slow &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR-</FONT>
<FONT COLOR="#000000">        Latency: 64, Cache Line Size: 32 bytes</FONT>
<FONT COLOR="#000000">        Interrupt: pin ? routed to IRQ 16</FONT>
<FONT COLOR="#000000">        Region 0: Memory at fe024000 (64-bit,</FONT>
<FONT COLOR="#000000">non-prefetchable) [size=16K]</FONT>
<FONT COLOR="#000000">        Capabilities: [50] Power Management version 2</FONT>
<FONT COLOR="#000000">                Flags: PMEClk- DSI- D1- D2-</FONT>
<FONT COLOR="#000000">AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)</FONT>
<FONT COLOR="#000000">                Status: D0 PME-Enable- DSel=0 DScale=0</FONT>
<FONT COLOR="#000000">PME-</FONT>
<FONT COLOR="#000000">        Capabilities: [60] Message Signalled</FONT>
<FONT COLOR="#000000">Interrupts: Mask- 64bit+ Queue=0/0 Enable-</FONT>
<FONT COLOR="#000000">                Address: 0000000000000000  Data: 0000</FONT>

<FONT COLOR="#000000">----------------------------------------------</FONT>

<FONT COLOR="#000000">  I'm not on this list so please CC me in any reply,</FONT>
<FONT COLOR="#000000">or if more info is required. I couldn't see this in</FONT>
<FONT COLOR="#000000">the bugtrack, although admittedly I didn't look too</FONT>
<FONT COLOR="#000000">hard so appologies if it is known.</FONT>

<FONT COLOR="#000000">Thanks</FONT>

<FONT COLOR="#000000">Huw</FONT>

<FONT COLOR="#000000">huwrh at yahoo dot com dot au</FONT>

<FONT COLOR="#000000">Send instant messages to your online friends <A HREF="http://au.messenger.yahoo.com">http://au.messenger.yahoo.com</A> </FONT>

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

--=-gw8YYrOTiZOVRN8dCmVY--

--=-JoxT+u6PuQYCcaj7g60p
Content-Disposition: attachment; filename=ATI-fix.patch
Content-Type: text/x-patch; name=ATI-fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


# HG changeset patch
# User tiwai
# Date 1173731446 -3600
# Node ID 5115624fea3145104669f7d94eca6af5c746430a
# Parent e87b2114ceaea19d2d83d646187c01d0ab03cc4e
hda-intel - Fix codec probe with ATI contorllers

ATI controllers may have up to 4 codecs while ICH up to 3.
Thus the earlier fix to change AZX_MAX_CODECS to 3 cause a regression
on some devices that have the audio codec at bit#3.

Now max codecs is defined according to the driver type, either 3 or 4.
Currently 4 is set only to ATI chips.  Other might need the same
change, too.

Patch-level: ASAP

--- a/pci/hda/hda_intel.c	Mon Mar 12 12:54:23 2007 +0100
+++ b/pci/hda/hda_intel.c	Mon Mar 12 21:30:46 2007 +0100
@@ -199,7 +199,6 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO
 
 /* STATESTS int mask: SD2,SD1,SD0 */
 #define STATESTS_INT_MASK	0x07
-#define AZX_MAX_CODECS		3
 
 /* SD_CTL bits */
 #define SD_CTL_STREAM_RESET	0x01	/* stream reset bit */
@@ -966,6 +965,16 @@ static int azx_setup_controller(struct a
  * Codec initialization
  */
 
+static unsigned int azx_max_codecs[] __devinitdata = {
+	[AZX_DRIVER_ICH] = 3,
+	[AZX_DRIVER_ATI] = 4,
+	[AZX_DRIVER_ATIHDMI] = 4,
+	[AZX_DRIVER_VIA] = 3,		/* FIXME: correct? */
+	[AZX_DRIVER_SIS] = 3,		/* FIXME: correct? */
+	[AZX_DRIVER_ULI] = 3,		/* FIXME: correct? */
+	[AZX_DRIVER_NVIDIA] = 3,	/* FIXME: correct? */
+};
+
 static int __devinit azx_codec_create(struct azx *chip, const char *model)
 {
 	struct hda_bus_template bus_temp;
@@ -982,7 +991,7 @@ static int __devinit azx_codec_create(st
 		return err;
 
 	codecs = 0;
-	for (c = 0; c < AZX_MAX_CODECS; c++) {
+	for (c = 0; c < azx_max_codecs[chip->driver_type]; c++) {
 		if ((chip->codec_mask & (1 << c)) & probe_mask) {
 			err = snd_hda_codec_new(chip->bus, c, NULL);
 			if (err < 0)


--=-JoxT+u6PuQYCcaj7g60p
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-JoxT+u6PuQYCcaj7g60p
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-JoxT+u6PuQYCcaj7g60p--

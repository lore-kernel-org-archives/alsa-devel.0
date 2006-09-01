From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: hda_intel broken on my ATI SB450
Date: Fri, 01 Sep 2006 09:00:41 -0700
Message-ID: <1157126441.6974.55.camel@razman>
References: <mailman.49799.1157107301.29847.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0251098587=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.49799.1157107301.29847.alsa-devel@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0251098587==
Content-Type: multipart/alternative; boundary="=-4tZwYvRqLTVdI4WiibXd"


--=-4tZwYvRqLTVdI4WiibXd
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> From: Chuck Ebbert <76306.1226@compuserve.com>
> Subject: [Alsa-devel] hda_intel broken on my ATI SB450
> To: alsa-devel <alsa-devel@alsa-project.org>
> Cc: Takashi Iwai <tiwai@suse.de>
> Using 2.6.18-rc5 and trying to load snd-hda-intel.ko for this
> (supported) device:
> 
> | 00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)
> |        Subsystem: Acer Incorporated [ALI] Unknown device 009f
> |        Flags: bus master, slow devsel, latency 64, IRQ 217
> |        Memory at c0000000 (64-bit, non-prefetchable) [size=16K]
> |        Capabilities: [50] Power Management version 2
> |        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
> 
> I get:
> 
> | hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
> | hda_intel: azx_get_response timeout, switching to single_cmd mode...
> 

This part tells me that you need to download alsa 1.0.12.  I did the
work for this particular board, and the relevant code was checked in
prior to 1.0.12 release.  This code does have one slight issue that I'm
looking into;  The outputs for Rear and Center/LFE are reversed, so
you'll need to swap the blue and pink plugs on the back (they function
properly as line-in & mic).


> Followed by nearly-endless spew of:
> 
> | hda-intel: get_response timeout: IRS=0x0
> | hda_codec: invalid dep_range_val 0:7fff
> | hda_codec: invalid dep_range_val 0:7fff
> | hda-intel: get_response timeout: IRS=0x0
> | hda_codec: invalid dep_range_val 0:7fff
> | hda-intel: get_response timeout: IRS=0x0
> | hda-intel: get_response timeout: IRS=0x0
> 

Latest alsa should also fix this.

> And finally:
> 
> | hda_generic: no proper input path found
> | hda_generic: no proper output path found
> | hda_generic: no PCM found
> 
> How can I debug this?
> 

Start with alsa 1.0.12.  If you are still having problems, let me know.

> -- 
> Chuck
> 
> 


-- 
Tobin Davis <tdavis@dsl-only.net>

--=-4tZwYvRqLTVdI4WiibXd
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">From: Chuck Ebbert &lt;<A HREF="mailto:76306.1226@compuserve.com">76306.1226@compuserve.com</A>&gt;</FONT>
<FONT COLOR="#000000">Subject: [Alsa-devel] hda_intel broken on my ATI SB450</FONT>
<FONT COLOR="#000000">To: alsa-devel &lt;<A HREF="mailto:alsa-devel@alsa-project.org">alsa-devel@alsa-project.org</A>&gt;</FONT>
<FONT COLOR="#000000">Cc: Takashi Iwai &lt;<A HREF="mailto:tiwai@suse.de">tiwai@suse.de</A>&gt;</FONT>
<FONT COLOR="#000000">Using 2.6.18-rc5 and trying to load snd-hda-intel.ko for this</FONT>
<FONT COLOR="#000000">(supported) device:</FONT>

<FONT COLOR="#000000">| 00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)</FONT>
<FONT COLOR="#000000">|        Subsystem: Acer Incorporated [ALI] Unknown device 009f</FONT>
<FONT COLOR="#000000">|        Flags: bus master, slow devsel, latency 64, IRQ 217</FONT>
<FONT COLOR="#000000">|        Memory at c0000000 (64-bit, non-prefetchable) [size=16K]</FONT>
<FONT COLOR="#000000">|        Capabilities: [50] Power Management version 2</FONT>
<FONT COLOR="#000000">|        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-</FONT>

<FONT COLOR="#000000">I get:</FONT>

<FONT COLOR="#000000">| hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...</FONT>
<FONT COLOR="#000000">| hda_intel: azx_get_response timeout, switching to single_cmd mode...</FONT>

</PRE>
</BLOCKQUOTE>
This part tells me that you need to download alsa 1.0.12.&nbsp; I did the work for this particular board, and the relevant code was checked in prior to 1.0.12 release.&nbsp; This code does have one slight issue that I'm looking into;&nbsp; The outputs for Rear and Center/LFE are reversed, so you'll need to swap the blue and pink plugs on the back (they function properly as line-in &amp; mic).<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Followed by nearly-endless spew of:</FONT>

<FONT COLOR="#000000">| hda-intel: get_response timeout: IRS=0x0</FONT>
<FONT COLOR="#000000">| hda_codec: invalid dep_range_val 0:7fff</FONT>
<FONT COLOR="#000000">| hda_codec: invalid dep_range_val 0:7fff</FONT>
<FONT COLOR="#000000">| hda-intel: get_response timeout: IRS=0x0</FONT>
<FONT COLOR="#000000">| hda_codec: invalid dep_range_val 0:7fff</FONT>
<FONT COLOR="#000000">| hda-intel: get_response timeout: IRS=0x0</FONT>
<FONT COLOR="#000000">| hda-intel: get_response timeout: IRS=0x0</FONT>

</PRE>
</BLOCKQUOTE>
Latest alsa should also fix this.
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">And finally:</FONT>

<FONT COLOR="#000000">| hda_generic: no proper input path found</FONT>
<FONT COLOR="#000000">| hda_generic: no proper output path found</FONT>
<FONT COLOR="#000000">| hda_generic: no PCM found</FONT>

<FONT COLOR="#000000">How can I debug this?</FONT>

</PRE>
</BLOCKQUOTE>
Start with alsa 1.0.12.&nbsp; If you are still having problems, let me know.
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">-- </FONT>
<FONT COLOR="#000000">Chuck</FONT>


</PRE>
</BLOCKQUOTE>
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

--=-4tZwYvRqLTVdI4WiibXd--



--===============0251098587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0251098587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0251098587==--

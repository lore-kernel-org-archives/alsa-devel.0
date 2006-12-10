From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA on Mac Pro
Date: Sun, 10 Dec 2006 08:16:04 -0800
Message-ID: <1165767364.7530.148.camel@razman>
References: <4574866D.5070506@sourcegear.com>
	<1165265511.32312.86.camel@razman>	<45748CF5.8040800@sourcegear.com>
	<1165275957.32312.103.camel@razman>	<4574BB17.1020807@sourcegear.com>
	<1165278602.32312.110.camel@razman> <4574EF72.8020207@sourcegear.com>
	<457828D7.4020908@teamprise.com> <1165535200.7530.63.camel@razman>
	<4579BF60.8000601@sourcegear.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1802045722=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4579BF60.8000601@sourcegear.com>
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


--===============1802045722==
Content-Type: multipart/alternative; boundary="=-HnGFUh9jeM3o0/V6API+"


--=-HnGFUh9jeM3o0/V6API+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Could you do a simple test?  I need to see what the autoconfig detects
for pins.  To do this, type:

modprobe -r snd-hda-intel
dmesg -c >/dev/null
modprobe snd-hda-intel model=auto
dmesg >dmesg.out  # send me this output

This should (hopefully) detect which port the headphones are on.  It
won't enable sound, but it is useful for detecting pins from the bios
settings.

Also, when you said sound was coming from the surround channels, do you
know if the front output was coming from that?  To test this, reload the
driver with "model=macpro" and type:
speaker-test -c 6 -t wav -Dplug:surround51

Thanks,

Tobin

On Fri, 2006-12-08 at 13:39 -0600, Shaw Terwilliger wrote:

> Tobin Davis wrote:
> > To test it, start with either the alsa-driver-hg20061130.tar.bz2 or
> > download the recent 1.0.14rc1 and follow these instructions:
> > tar -jxvf alsa-driver-<version>.tar.bz2   # <version> == hg20061130 or
> > 1.0.14rc1
> > cd alsa-driver-<version>/alsa-kernel
> > patch -p1 <macpro.patch.1
> > cd ..
> > ./configure --with-cards=hda-intel --with-debug=detect ; make ; make install
> > dmesg -c
> > modprobe -r snd-hda-intel
> > modprobe snd-hda-intel model=macpro
> > dmesg >dmesg.out
> 
> Patch applies cleanly and builds with 1.0.14rc1, and macpro model
> selection works.  The dmesg dump is attached (though it's pretty terse).
> 
> > Send me a copy of dmesg.out along with any differences that you see.  I
> > may need to tweak which pins get enabled.
> 
> Great news: I have the correct volume!  Here are some mixer oddities:
> 
> - The "Surround" mixer channels actually control what comes out of the
> line-out jack on the back of the Mac Pro (where I have my speakers
> plugged in).  This was the case before.
> 
> - The "Front Mic" mixer channels actually control the line-in jack on
> the back of the Mac Pro (where I have my radio's line-out plugged in).
> 
> - No combination of mixer channel volumes and "Headphone" switch setting
> seems to control the headphone jack on the front of the Mac Pro (can't
> get any sound from it).  Not a big deal for me, but might be for others.
> 
> - The "PC Speaker" mixer channel doesn't control the internal speaker.
> I don't know if this is actually possible in OS X (don't have it installed).
> 
> Also, I don't have an optical cable to test the digital in/out.  Have
> not tested the other analog channels (don't have a mic, etc.).
> 
> Thanks for your work fixing up the driver for the 885.
> 
> -- 
> Shaw Terwilliger <sterwill@teamprise.com>
> Teamprise LLC
> http://teamprise.com/
> 
> 
> 
> 
> plain text document attachment (model-macpro.dmesg.out)
> 
> [352334.966359] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 23 (level, low) -> IRQ 225
> [352334.967289] PCI: Setting latency timer of device 0000:00:1b.0 to 64
> [352335.000095] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696: codec_mask = 0x1
> [352335.177917] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:1743: hda_codec: model 'macpro' is selected

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-HnGFUh9jeM3o0/V6API+
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Could you do a simple test?&nbsp; I need to see what the autoconfig detects for pins.&nbsp; To do this, type:<BR>
<BR>
modprobe -r snd-hda-intel<BR>
dmesg -c &gt;/dev/null<BR>
modprobe snd-hda-intel model=auto<BR>
dmesg &gt;dmesg.out&nbsp; # send me this output<BR>
<BR>
This should (hopefully) detect which port the headphones are on.&nbsp; It won't enable sound, but it is useful for detecting pins from the bios settings.<BR>
<BR>
Also, when you said sound was coming from the surround channels, do you know if the front output was coming from that?&nbsp; To test this, reload the driver with &quot;model=macpro&quot; and type:<BR>
speaker-test -c 6 -t wav -Dplug:surround51<BR>
<BR>
Thanks,<BR>
<BR>
Tobin<BR>
<BR>
On Fri, 2006-12-08 at 13:39 -0600, Shaw Terwilliger wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Tobin Davis wrote:</FONT>
<FONT COLOR="#000000">&gt; To test it, start with either the alsa-driver-hg20061130.tar.bz2 or</FONT>
<FONT COLOR="#000000">&gt; download the recent 1.0.14rc1 and follow these instructions:</FONT>
<FONT COLOR="#000000">&gt; tar -jxvf alsa-driver-&lt;version&gt;.tar.bz2   # &lt;version&gt; == hg20061130 or</FONT>
<FONT COLOR="#000000">&gt; 1.0.14rc1</FONT>
<FONT COLOR="#000000">&gt; cd alsa-driver-&lt;version&gt;/alsa-kernel</FONT>
<FONT COLOR="#000000">&gt; patch -p1 &lt;macpro.patch.1</FONT>
<FONT COLOR="#000000">&gt; cd ..</FONT>
<FONT COLOR="#000000">&gt; ./configure --with-cards=hda-intel --with-debug=detect ; make ; make install</FONT>
<FONT COLOR="#000000">&gt; dmesg -c</FONT>
<FONT COLOR="#000000">&gt; modprobe -r snd-hda-intel</FONT>
<FONT COLOR="#000000">&gt; modprobe snd-hda-intel model=macpro</FONT>
<FONT COLOR="#000000">&gt; dmesg &gt;dmesg.out</FONT>

<FONT COLOR="#000000">Patch applies cleanly and builds with 1.0.14rc1, and macpro model</FONT>
<FONT COLOR="#000000">selection works.  The dmesg dump is attached (though it's pretty terse).</FONT>

<FONT COLOR="#000000">&gt; Send me a copy of dmesg.out along with any differences that you see.  I</FONT>
<FONT COLOR="#000000">&gt; may need to tweak which pins get enabled.</FONT>

<FONT COLOR="#000000">Great news: I have the correct volume!  Here are some mixer oddities:</FONT>

<FONT COLOR="#000000">- The &quot;Surround&quot; mixer channels actually control what comes out of the</FONT>
<FONT COLOR="#000000">line-out jack on the back of the Mac Pro (where I have my speakers</FONT>
<FONT COLOR="#000000">plugged in).  This was the case before.</FONT>

<FONT COLOR="#000000">- The &quot;Front Mic&quot; mixer channels actually control the line-in jack on</FONT>
<FONT COLOR="#000000">the back of the Mac Pro (where I have my radio's line-out plugged in).</FONT>

<FONT COLOR="#000000">- No combination of mixer channel volumes and &quot;Headphone&quot; switch setting</FONT>
<FONT COLOR="#000000">seems to control the headphone jack on the front of the Mac Pro (can't</FONT>
<FONT COLOR="#000000">get any sound from it).  Not a big deal for me, but might be for others.</FONT>

<FONT COLOR="#000000">- The &quot;PC Speaker&quot; mixer channel doesn't control the internal speaker.</FONT>
<FONT COLOR="#000000">I don't know if this is actually possible in OS X (don't have it installed).</FONT>

<FONT COLOR="#000000">Also, I don't have an optical cable to test the digital in/out.  Have</FONT>
<FONT COLOR="#000000">not tested the other analog channels (don't have a mic, etc.).</FONT>

<FONT COLOR="#000000">Thanks for your work fixing up the driver for the 885.</FONT>

<FONT COLOR="#000000">-- </FONT>
<FONT COLOR="#000000">Shaw Terwilliger &lt;<A HREF="mailto:sterwill@teamprise.com">sterwill@teamprise.com</A>&gt;</FONT>
<FONT COLOR="#000000">Teamprise LLC</FONT>
<FONT COLOR="#000000"><A HREF="http://teamprise.com/">http://teamprise.com/</A></FONT>



</PRE>
    <TABLE CELLSPACING="0" CELLPADDING="0" BORDER="1">
<TR>
<TD>
<FONT SIZE="2">plain text document attachment (model-macpro.dmesg.out)</FONT>
</TD>
</TR>
</TABLE>
<PRE>
<FONT COLOR="#000000">[352334.966359] ACPI: PCI Interrupt 0000:00:1b.0[A] -&gt; GSI 23 (level, low) -&gt; IRQ 225</FONT>
<FONT COLOR="#000000">[352334.967289] PCI: Setting latency timer of device 0000:00:1b.0 to 64</FONT>
<FONT COLOR="#000000">[352335.000095] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696: codec_mask = 0x1</FONT>
<FONT COLOR="#000000">[352335.177917] ALSA /data/downloads/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:1743: hda_codec: model 'macpro' is selected</FONT>
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

--=-HnGFUh9jeM3o0/V6API+--



--===============1802045722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1802045722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1802045722==--

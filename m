From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: ALC880 driver
Date: Fri, 15 Dec 2006 07:05:16 -0800
Message-ID: <1166195116.4142.187.camel@razman>
References: <200612150009.kBF09lEZ028693@turbo.physics.adelaide.edu.au>
	<458254DC.4080306@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zKpL46rF6CTdfREwGLRz"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <458254DC.4080306@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Trifon Trifonov <triffon@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, PeiSen Hou <pshou@realtek.com.tw>, Kailang Yang <kailang@realtek.com.tw>, alsa-devel@lists.sourceforge.net, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org


--=-zKpL46rF6CTdfREwGLRz
Content-Type: multipart/alternative; boundary="=-7i9Zx+d2iqLKcZa0AePp"


--=-7i9Zx+d2iqLKcZa0AePp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds the Turbo-X Coeus G610P to the alc880 config table,
based on user provided information.

Signed off by:

Tobin Davis

I had it open and was getting ready for other work.

On Fri, 2006-12-15 at 08:55 +0100, Trifon Trifonov wrote:

> Jonathan Woithe:
> > Hi Trifon
> >
> > [ Alsa-devel list added to CC ]
> >
> >   
> >> I have a Realtek IntelHDA audio card using the ALC880 codec. I am 
> >> runing Ubuntu Linux with kernel version 2.6.17-10.
> >> When I first installed Ubuntu, it correctly recognised my card, but I 
> >> could hear audio only through the right speaker. I looked in my kern.log 
> >> and found a message that it is recognised as ALC880, but the vendor is 
> >> unknown. I inspected the file patch_realtek.c for possible board config 
> >> types and experimented with all of them. Some were not working at all, 
> >> some were working again with only right speaker, some were working with 
> >> both speakers, but microphone input is not working. Finally, I found 
> >> that the W810 config is right for me -- everything is working stereo and 
> >> also the input. I have no problems with the card, just wanted to share 
> >> the knowledge so maybe you can add automatic detection for my type of 
> >> card to work on the W810 config.
> >> Please, write to me what kind of additional information do you need 
> >> for that.
> >>     
> >
> > Could you please provide the following information:
> >
> >  1) The make and model of your laptop
> >   
> I don't think this will help, because my laptop is not a very popular 
> brand, it was assembled in Greece. But anyway, the brand is Turbo-X 
> Coeus, model is G610P.
> >  2) The output of the following commands:
> >
> >       lspci
> >       lspci -nv
> >
> >     Depending on your system's configuration you may have to include the
> >     full path when running lspci - for example, "/sbin/lspci".
> >   
> You forgot to mention that I have to sudo first to get all the info :) I 
> attach the required files, hope they help.
> 
> Best,
>   Trifon
> 
> plain text document attachment (lspci.txt)
> 
> 00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express Memory Controller Hub (rev 03)
> 00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express PCI Express Root Port (rev 03)
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
> 00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 02)
> 00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 02)
> 00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 02)
> 00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02)
> 00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 02)
> 00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 02)
> 00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 02)
> 00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02)
> 00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
> 00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 02)
> 00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controller IDE (rev 02)
> 00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
> 01:00.0 VGA compatible controller: ATI Technologies Inc Unknown device 7145
> 03:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5789 Gigabit Ethernet PCI Express (rev 11)
> 06:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG Network Connection (rev 05)
> 06:07.0 FireWire (IEEE 1394): O2 Micro, Inc. Unknown device 00f7 (rev 02)
> 06:07.2 Class 0805: O2 Micro, Inc. Unknown device 7120 (rev 01)
> 06:07.3 Mass storage controller: O2 Micro, Inc. Unknown device 7130 (rev 01)
> 
> plain text document attachment (lspci -nv.txt)
> 
> 00:00.0 0600: 8086:27a0 (rev 03)
> 	Subsystem: 1019:0f69
> 	Flags: bus master, fast devsel, latency 0
> 	Capabilities: [e0] Vendor Specific Information
> 
> 00:01.0 0604: 8086:27a1 (rev 03)
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 0000a000-0000cfff
> 	Memory behind bridge: ff300000-ff3fffff
> 	Prefetchable memory behind bridge: 00000000bdf00000-00000000dde00000
> 	Capabilities: [88] #0d [0000]
> 	Capabilities: [80] Power Management version 2
> 	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
> 	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
> 
> 00:1b.0 0403: 8086:27d8 (rev 02)
> 	Subsystem: 1019:0f69
> 	Flags: bus master, fast devsel, latency 0, IRQ 58
> 	Memory at ffefc000 (64-bit, non-prefetchable) [size=16K]
> 	Capabilities: [50] Power Management version 2
> 	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
> 	Capabilities: [70] Express Unknown type IRQ 0
> 
> 00:1c.0 0604: 8086:27d0 (rev 02)
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> 	Capabilities: [40] Express Root Port (Slot+) IRQ 0
> 	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
> 	Capabilities: [90] #0d [0000]
> 	Capabilities: [a0] Power Management version 2
> 
> 00:1c.1 0604: 8086:27d2 (rev 02)
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
> 	Memory behind bridge: ff400000-ff4fffff
> 	Capabilities: [40] Express Root Port (Slot+) IRQ 0
> 	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
> 	Capabilities: [90] #0d [0000]
> 	Capabilities: [a0] Power Management version 2
> 
> 00:1c.2 0604: 8086:27d4 (rev 02)
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
> 	I/O behind bridge: 0000d000-0000dfff
> 	Capabilities: [40] Express Root Port (Slot+) IRQ 0
> 	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
> 	Capabilities: [90] #0d [0000]
> 	Capabilities: [a0] Power Management version 2
> 
> 00:1d.0 0c03: 8086:27c8 (rev 02)
> 	Subsystem: 1019:0f69
> 	Flags: bus master, medium devsel, latency 0, IRQ 50
> 	I/O ports at ec00 [size=32]
> 
> 00:1d.1 0c03: 8086:27c9 (rev 02)
> 	Subsystem: 1019:0f69
> 	Flags: bus master, medium devsel, latency 0, IRQ 58
> 	I/O ports at e880 [size=32]
> 
> 00:1d.2 0c03: 8086:27ca (rev 02)
> 	Subsystem: 1019:0f69
> 	Flags: bus master, medium devsel, latency 0, IRQ 66
> 	I/O ports at e800 [size=32]
> 
> 00:1d.3 0c03: 8086:27cb (rev 02)
> 	Subsystem: 1019:0f69
> 	Flags: bus master, medium devsel, latency 0, IRQ 74
> 	I/O ports at e480 [size=32]
> 
> 00:1d.7 0c03: 8086:27cc (rev 02) (prog-if 20)
> 	Subsystem: 1019:0f69
> 	Flags: bus master, medium devsel, latency 0, IRQ 66
> 	Memory at ffefbc00 (32-bit, non-prefetchable) [size=1K]
> 	Capabilities: [50] Power Management version 2
> 	Capabilities: [58] Debug port
> 
> 00:1e.0 0604: 8086:2448 (rev e2) (prog-if 01)
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=06, subordinate=07, sec-latency=32
> 	Memory behind bridge: ff500000-ffdfffff
> 	Prefetchable memory behind bridge: 00000000ddf00000-00000000dfe00000
> 	Capabilities: [50] #0d [0000]
> 
> 00:1f.0 0601: 8086:27b9 (rev 02)
> 	Subsystem: 1019:0f69
> 	Flags: bus master, medium devsel, latency 0
> 	Capabilities: [e0] Vendor Specific Information
> 
> 00:1f.2 0101: 8086:27c4 (rev 02) (prog-if 80)
> 	Subsystem: 1019:0f69
> 	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 233
> 	I/O ports at <unassigned>
> 	I/O ports at <unassigned>
> 	I/O ports at <unassigned>
> 	I/O ports at <unassigned>
> 	I/O ports at ffa0 [size=16]
> 	Capabilities: [70] Power Management version 2
> 
> 00:1f.3 0c05: 8086:27da (rev 02)
> 	Subsystem: 1019:0f69
> 	Flags: medium devsel, IRQ 5
> 	I/O ports at 0400 [size=32]
> 
> 01:00.0 0300: 1002:7145
> 	Subsystem: 1019:0f69
> 	Flags: bus master, fast devsel, latency 0, IRQ 169
> 	Memory at c0000000 (32-bit, prefetchable) [size=256M]
> 	I/O ports at c000 [size=256]
> 	Memory at ff3f0000 (32-bit, non-prefetchable) [size=64K]
> 	Expansion ROM at ff3c0000 [disabled] [size=128K]
> 	Capabilities: [50] Power Management version 2
> 	Capabilities: [58] Express Legacy Endpoint IRQ 0
> 
> 03:00.0 0200: 14e4:169d (rev 11)
> 	Subsystem: 1019:0f58
> 	Flags: bus master, fast devsel, latency 0, IRQ 177
> 	Memory at ff4f0000 (64-bit, non-prefetchable) [size=64K]
> 	Capabilities: [48] Power Management version 2
> 	Capabilities: [50] Vital Product Data
> 	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
> 	Capabilities: [d0] Express Endpoint IRQ 0
> 
> 06:03.0 0280: 8086:4220 (rev 05)
> 	Subsystem: 8086:2702
> 	Flags: bus master, medium devsel, latency 64, IRQ 233
> 	Memory at ffdfe000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [dc] Power Management version 2
> 
> 06:07.0 0c00: 1217:00f7 (rev 02) (prog-if 10)
> 	Subsystem: 1217:00f7
> 	Flags: bus master, medium devsel, latency 64, IRQ 169
> 	Memory at ff500000 (32-bit, non-prefetchable) [size=4K]
> 	Memory at ffdfc800 (32-bit, non-prefetchable) [size=2K]
> 	Capabilities: [60] Power Management version 2
> 
> 06:07.2 0805: 1217:7120 (rev 01)
> 	Subsystem: 0001:0000
> 	Flags: slow devsel, IRQ 169
> 	Memory at ffdfc400 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [a0] Power Management version 2
> 
> 06:07.3 0180: 1217:7130 (rev 01)
> 	Subsystem: 0001:0000
> 	Flags: slow devsel, IRQ 10
> 	Memory at ffdff000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [a0] Power Management version 2
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________ Alsa-devel mailing list Alsa-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-7i9Zx+d2iqLKcZa0AePp
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
This patch adds the <FONT COLOR="#000000">Turbo-X Coeus G610P</FONT> to the alc880 config table, based on user provided information.<BR>
<BR>
Signed off by:<BR>
<BR>
Tobin Davis<BR>
<BR>
I had it open and was getting ready for other work.<BR>
<BR>
On Fri, 2006-12-15 at 08:55 +0100, Trifon Trifonov wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Jonathan Woithe:</FONT>
<FONT COLOR="#000000">&gt; Hi Trifon</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; [ Alsa-devel list added to CC ]</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;   </FONT>
<FONT COLOR="#000000">&gt;&gt; I have a Realtek IntelHDA audio card using the ALC880 codec. I am </FONT>
<FONT COLOR="#000000">&gt;&gt; runing Ubuntu Linux with kernel version 2.6.17-10.</FONT>
<FONT COLOR="#000000">&gt;&gt; When I first installed Ubuntu, it correctly recognised my card, but I </FONT>
<FONT COLOR="#000000">&gt;&gt; could hear audio only through the right speaker. I looked in my kern.log </FONT>
<FONT COLOR="#000000">&gt;&gt; and found a message that it is recognised as ALC880, but the vendor is </FONT>
<FONT COLOR="#000000">&gt;&gt; unknown. I inspected the file patch_realtek.c for possible board config </FONT>
<FONT COLOR="#000000">&gt;&gt; types and experimented with all of them. Some were not working at all, </FONT>
<FONT COLOR="#000000">&gt;&gt; some were working again with only right speaker, some were working with </FONT>
<FONT COLOR="#000000">&gt;&gt; both speakers, but microphone input is not working. Finally, I found </FONT>
<FONT COLOR="#000000">&gt;&gt; that the W810 config is right for me -- everything is working stereo and </FONT>
<FONT COLOR="#000000">&gt;&gt; also the input. I have no problems with the card, just wanted to share </FONT>
<FONT COLOR="#000000">&gt;&gt; the knowledge so maybe you can add automatic detection for my type of </FONT>
<FONT COLOR="#000000">&gt;&gt; card to work on the W810 config.</FONT>
<FONT COLOR="#000000">&gt;&gt; Please, write to me what kind of additional information do you need </FONT>
<FONT COLOR="#000000">&gt;&gt; for that.</FONT>
<FONT COLOR="#000000">&gt;&gt;     </FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt; Could you please provide the following information:</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;  1) The make and model of your laptop</FONT>
<FONT COLOR="#000000">&gt;   </FONT>
<FONT COLOR="#000000">I don't think this will help, because my laptop is not a very popular </FONT>
<FONT COLOR="#000000">brand, it was assembled in Greece. But anyway, the brand is Turbo-X </FONT>
<FONT COLOR="#000000">Coeus, model is G610P.</FONT>
<FONT COLOR="#000000">&gt;  2) The output of the following commands:</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;       lspci</FONT>
<FONT COLOR="#000000">&gt;       lspci -nv</FONT>
<FONT COLOR="#000000">&gt;</FONT>
<FONT COLOR="#000000">&gt;     Depending on your system's configuration you may have to include the</FONT>
<FONT COLOR="#000000">&gt;     full path when running lspci - for example, &quot;/sbin/lspci&quot;.</FONT>
<FONT COLOR="#000000">&gt;   </FONT>
<FONT COLOR="#000000">You forgot to mention that I have to sudo first to get all the info :) I </FONT>
<FONT COLOR="#000000">attach the required files, hope they help.</FONT>

<FONT COLOR="#000000">Best,</FONT>
<FONT COLOR="#000000">  Trifon</FONT>
</PRE>
    <TABLE CELLSPACING="0" CELLPADDING="0" BORDER="1">
<TR>
<TD>
<FONT SIZE="2">plain text document attachment (lspci.txt)</FONT>
</TD>
</TR>
</TABLE>
<PRE>
<FONT COLOR="#000000">00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express Memory Controller Hub (rev 03)</FONT>
<FONT COLOR="#000000">00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express PCI Express Root Port (rev 03)</FONT>
<FONT COLOR="#000000">00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)</FONT>
<FONT COLOR="#000000">00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 02)</FONT>
<FONT COLOR="#000000">00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 02)</FONT>
<FONT COLOR="#000000">00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 02)</FONT>
<FONT COLOR="#000000">00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02)</FONT>
<FONT COLOR="#000000">00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 02)</FONT>
<FONT COLOR="#000000">00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 02)</FONT>
<FONT COLOR="#000000">00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 02)</FONT>
<FONT COLOR="#000000">00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02)</FONT>
<FONT COLOR="#000000">00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)</FONT>
<FONT COLOR="#000000">00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 02)</FONT>
<FONT COLOR="#000000">00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controller IDE (rev 02)</FONT>
<FONT COLOR="#000000">00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)</FONT>
<FONT COLOR="#000000">01:00.0 VGA compatible controller: ATI Technologies Inc Unknown device 7145</FONT>
<FONT COLOR="#000000">03:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5789 Gigabit Ethernet PCI Express (rev 11)</FONT>
<FONT COLOR="#000000">06:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG Network Connection (rev 05)</FONT>
<FONT COLOR="#000000">06:07.0 FireWire (IEEE 1394): O2 Micro, Inc. Unknown device 00f7 (rev 02)</FONT>
<FONT COLOR="#000000">06:07.2 Class 0805: O2 Micro, Inc. Unknown device 7120 (rev 01)</FONT>
<FONT COLOR="#000000">06:07.3 Mass storage controller: O2 Micro, Inc. Unknown device 7130 (rev 01)</FONT>
</PRE>
    <TABLE CELLSPACING="0" CELLPADDING="0" BORDER="1">
<TR>
<TD>
<FONT SIZE="2">plain text document attachment (lspci -nv.txt)</FONT>
</TD>
</TR>
</TABLE>
<PRE>
<FONT COLOR="#000000">00:00.0 0600: 8086:27a0 (rev 03)</FONT>
<FONT COLOR="#000000">	Subsystem: 1019:0f69</FONT>
<FONT COLOR="#000000">	Flags: bus master, fast devsel, latency 0</FONT>
<FONT COLOR="#000000">	Capabilities: [e0] Vendor Specific Information</FONT>

<FONT COLOR="#000000">00:01.0 0604: 8086:27a1 (rev 03)</FONT>
<FONT COLOR="#000000">	Flags: bus master, fast devsel, latency 0</FONT>
<FONT COLOR="#000000">	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0</FONT>
<FONT COLOR="#000000">	I/O behind bridge: 0000a000-0000cfff</FONT>
<FONT COLOR="#000000">	Memory behind bridge: ff300000-ff3fffff</FONT>
<FONT COLOR="#000000">	Prefetchable memory behind bridge: 00000000bdf00000-00000000dde00000</FONT>
<FONT COLOR="#000000">	Capabilities: [88] #0d [0000]</FONT>
<FONT COLOR="#000000">	Capabilities: [80] Power Management version 2</FONT>
<FONT COLOR="#000000">	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+</FONT>
<FONT COLOR="#000000">	Capabilities: [a0] Express Root Port (Slot+) IRQ 0</FONT>

<FONT COLOR="#000000">00:1b.0 0403: 8086:27d8 (rev 02)</FONT>
<FONT COLOR="#000000">	Subsystem: 1019:0f69</FONT>
<FONT COLOR="#000000">	Flags: bus master, fast devsel, latency 0, IRQ 58</FONT>
<FONT COLOR="#000000">	Memory at ffefc000 (64-bit, non-prefetchable) [size=16K]</FONT>
<FONT COLOR="#000000">	Capabilities: [50] Power Management version 2</FONT>
<FONT COLOR="#000000">	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-</FONT>
<FONT COLOR="#000000">	Capabilities: [70] Express Unknown type IRQ 0</FONT>

<FONT COLOR="#000000">00:1c.0 0604: 8086:27d0 (rev 02)</FONT>
<FONT COLOR="#000000">	Flags: bus master, fast devsel, latency 0</FONT>
<FONT COLOR="#000000">	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0</FONT>
<FONT COLOR="#000000">	Capabilities: [40] Express Root Port (Slot+) IRQ 0</FONT>
<FONT COLOR="#000000">	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+</FONT>
<FONT COLOR="#000000">	Capabilities: [90] #0d [0000]</FONT>
<FONT COLOR="#000000">	Capabilities: [a0] Power Management version 2</FONT>

<FONT COLOR="#000000">00:1c.1 0604: 8086:27d2 (rev 02)</FONT>
<FONT COLOR="#000000">	Flags: bus master, fast devsel, latency 0</FONT>
<FONT COLOR="#000000">	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0</FONT>
<FONT COLOR="#000000">	Memory behind bridge: ff400000-ff4fffff</FONT>
<FONT COLOR="#000000">	Capabilities: [40] Express Root Port (Slot+) IRQ 0</FONT>
<FONT COLOR="#000000">	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+</FONT>
<FONT COLOR="#000000">	Capabilities: [90] #0d [0000]</FONT>
<FONT COLOR="#000000">	Capabilities: [a0] Power Management version 2</FONT>

<FONT COLOR="#000000">00:1c.2 0604: 8086:27d4 (rev 02)</FONT>
<FONT COLOR="#000000">	Flags: bus master, fast devsel, latency 0</FONT>
<FONT COLOR="#000000">	Bus: primary=00, secondary=04, subordinate=05, sec-latency=0</FONT>
<FONT COLOR="#000000">	I/O behind bridge: 0000d000-0000dfff</FONT>
<FONT COLOR="#000000">	Capabilities: [40] Express Root Port (Slot+) IRQ 0</FONT>
<FONT COLOR="#000000">	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+</FONT>
<FONT COLOR="#000000">	Capabilities: [90] #0d [0000]</FONT>
<FONT COLOR="#000000">	Capabilities: [a0] Power Management version 2</FONT>

<FONT COLOR="#000000">00:1d.0 0c03: 8086:27c8 (rev 02)</FONT>
<FONT COLOR="#000000">	Subsystem: 1019:0f69</FONT>
<FONT COLOR="#000000">	Flags: bus master, medium devsel, latency 0, IRQ 50</FONT>
<FONT COLOR="#000000">	I/O ports at ec00 [size=32]</FONT>

<FONT COLOR="#000000">00:1d.1 0c03: 8086:27c9 (rev 02)</FONT>
<FONT COLOR="#000000">	Subsystem: 1019:0f69</FONT>
<FONT COLOR="#000000">	Flags: bus master, medium devsel, latency 0, IRQ 58</FONT>
<FONT COLOR="#000000">	I/O ports at e880 [size=32]</FONT>

<FONT COLOR="#000000">00:1d.2 0c03: 8086:27ca (rev 02)</FONT>
<FONT COLOR="#000000">	Subsystem: 1019:0f69</FONT>
<FONT COLOR="#000000">	Flags: bus master, medium devsel, latency 0, IRQ 66</FONT>
<FONT COLOR="#000000">	I/O ports at e800 [size=32]</FONT>

<FONT COLOR="#000000">00:1d.3 0c03: 8086:27cb (rev 02)</FONT>
<FONT COLOR="#000000">	Subsystem: 1019:0f69</FONT>
<FONT COLOR="#000000">	Flags: bus master, medium devsel, latency 0, IRQ 74</FONT>
<FONT COLOR="#000000">	I/O ports at e480 [size=32]</FONT>

<FONT COLOR="#000000">00:1d.7 0c03: 8086:27cc (rev 02) (prog-if 20)</FONT>
<FONT COLOR="#000000">	Subsystem: 1019:0f69</FONT>
<FONT COLOR="#000000">	Flags: bus master, medium devsel, latency 0, IRQ 66</FONT>
<FONT COLOR="#000000">	Memory at ffefbc00 (32-bit, non-prefetchable) [size=1K]</FONT>
<FONT COLOR="#000000">	Capabilities: [50] Power Management version 2</FONT>
<FONT COLOR="#000000">	Capabilities: [58] Debug port</FONT>

<FONT COLOR="#000000">00:1e.0 0604: 8086:2448 (rev e2) (prog-if 01)</FONT>
<FONT COLOR="#000000">	Flags: bus master, fast devsel, latency 0</FONT>
<FONT COLOR="#000000">	Bus: primary=00, secondary=06, subordinate=07, sec-latency=32</FONT>
<FONT COLOR="#000000">	Memory behind bridge: ff500000-ffdfffff</FONT>
<FONT COLOR="#000000">	Prefetchable memory behind bridge: 00000000ddf00000-00000000dfe00000</FONT>
<FONT COLOR="#000000">	Capabilities: [50] #0d [0000]</FONT>

<FONT COLOR="#000000">00:1f.0 0601: 8086:27b9 (rev 02)</FONT>
<FONT COLOR="#000000">	Subsystem: 1019:0f69</FONT>
<FONT COLOR="#000000">	Flags: bus master, medium devsel, latency 0</FONT>
<FONT COLOR="#000000">	Capabilities: [e0] Vendor Specific Information</FONT>

<FONT COLOR="#000000">00:1f.2 0101: 8086:27c4 (rev 02) (prog-if 80)</FONT>
<FONT COLOR="#000000">	Subsystem: 1019:0f69</FONT>
<FONT COLOR="#000000">	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 233</FONT>
<FONT COLOR="#000000">	I/O ports at &lt;unassigned&gt;</FONT>
<FONT COLOR="#000000">	I/O ports at &lt;unassigned&gt;</FONT>
<FONT COLOR="#000000">	I/O ports at &lt;unassigned&gt;</FONT>
<FONT COLOR="#000000">	I/O ports at &lt;unassigned&gt;</FONT>
<FONT COLOR="#000000">	I/O ports at ffa0 [size=16]</FONT>
<FONT COLOR="#000000">	Capabilities: [70] Power Management version 2</FONT>

<FONT COLOR="#000000">00:1f.3 0c05: 8086:27da (rev 02)</FONT>
<FONT COLOR="#000000">	Subsystem: 1019:0f69</FONT>
<FONT COLOR="#000000">	Flags: medium devsel, IRQ 5</FONT>
<FONT COLOR="#000000">	I/O ports at 0400 [size=32]</FONT>

<FONT COLOR="#000000">01:00.0 0300: 1002:7145</FONT>
<FONT COLOR="#000000">	Subsystem: 1019:0f69</FONT>
<FONT COLOR="#000000">	Flags: bus master, fast devsel, latency 0, IRQ 169</FONT>
<FONT COLOR="#000000">	Memory at c0000000 (32-bit, prefetchable) [size=256M]</FONT>
<FONT COLOR="#000000">	I/O ports at c000 [size=256]</FONT>
<FONT COLOR="#000000">	Memory at ff3f0000 (32-bit, non-prefetchable) [size=64K]</FONT>
<FONT COLOR="#000000">	Expansion ROM at ff3c0000 [disabled] [size=128K]</FONT>
<FONT COLOR="#000000">	Capabilities: [50] Power Management version 2</FONT>
<FONT COLOR="#000000">	Capabilities: [58] Express Legacy Endpoint IRQ 0</FONT>

<FONT COLOR="#000000">03:00.0 0200: 14e4:169d (rev 11)</FONT>
<FONT COLOR="#000000">	Subsystem: 1019:0f58</FONT>
<FONT COLOR="#000000">	Flags: bus master, fast devsel, latency 0, IRQ 177</FONT>
<FONT COLOR="#000000">	Memory at ff4f0000 (64-bit, non-prefetchable) [size=64K]</FONT>
<FONT COLOR="#000000">	Capabilities: [48] Power Management version 2</FONT>
<FONT COLOR="#000000">	Capabilities: [50] Vital Product Data</FONT>
<FONT COLOR="#000000">	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-</FONT>
<FONT COLOR="#000000">	Capabilities: [d0] Express Endpoint IRQ 0</FONT>

<FONT COLOR="#000000">06:03.0 0280: 8086:4220 (rev 05)</FONT>
<FONT COLOR="#000000">	Subsystem: 8086:2702</FONT>
<FONT COLOR="#000000">	Flags: bus master, medium devsel, latency 64, IRQ 233</FONT>
<FONT COLOR="#000000">	Memory at ffdfe000 (32-bit, non-prefetchable) [size=4K]</FONT>
<FONT COLOR="#000000">	Capabilities: [dc] Power Management version 2</FONT>

<FONT COLOR="#000000">06:07.0 0c00: 1217:00f7 (rev 02) (prog-if 10)</FONT>
<FONT COLOR="#000000">	Subsystem: 1217:00f7</FONT>
<FONT COLOR="#000000">	Flags: bus master, medium devsel, latency 64, IRQ 169</FONT>
<FONT COLOR="#000000">	Memory at ff500000 (32-bit, non-prefetchable) [size=4K]</FONT>
<FONT COLOR="#000000">	Memory at ffdfc800 (32-bit, non-prefetchable) [size=2K]</FONT>
<FONT COLOR="#000000">	Capabilities: [60] Power Management version 2</FONT>

<FONT COLOR="#000000">06:07.2 0805: 1217:7120 (rev 01)</FONT>
<FONT COLOR="#000000">	Subsystem: 0001:0000</FONT>
<FONT COLOR="#000000">	Flags: slow devsel, IRQ 169</FONT>
<FONT COLOR="#000000">	Memory at ffdfc400 (32-bit, non-prefetchable) [size=256]</FONT>
<FONT COLOR="#000000">	Capabilities: [a0] Power Management version 2</FONT>

<FONT COLOR="#000000">06:07.3 0180: 1217:7130 (rev 01)</FONT>
<FONT COLOR="#000000">	Subsystem: 0001:0000</FONT>
<FONT COLOR="#000000">	Flags: slow devsel, IRQ 10</FONT>
<FONT COLOR="#000000">	Memory at ffdff000 (32-bit, non-prefetchable) [size=4K]</FONT>
<FONT COLOR="#000000">	Capabilities: [a0] Power Management version 2</FONT>

<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys - and earn cash</FONT>
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

--=-7i9Zx+d2iqLKcZa0AePp--

--=-zKpL46rF6CTdfREwGLRz
Content-Disposition: attachment; filename=Coeus-G610P.patch
Content-Type: text/x-patch; name=Coeus-G610P.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -r 1ede4dc9b6ea pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Sun Dec 10 00:00:38 2006 +0000
+++ b/pci/hda/patch_realtek.c	Fri Dec 15 07:01:12 2006 -0800
@@ -2360,6 +2361,7 @@ static struct snd_pci_quirk alc880_cfg_t
 
 	SND_PCI_QUIRK(0x1019, 0xa880, "ECS", ALC880_5ST_DIG),
 	SND_PCI_QUIRK(0x1019, 0xa884, "Acer APFV", ALC880_6ST),
+	SND_PCI_QUIRK(0x1019, 0x0f69, "Coeus G610P", ALC880_W810),
 	SND_PCI_QUIRK(0x1025, 0x0070, "ULI", ALC880_3ST_DIG),
 	SND_PCI_QUIRK(0x1025, 0x0077, "ULI", ALC880_6ST_DIG),
 	SND_PCI_QUIRK(0x1025, 0x0078, "ULI", ALC880_6ST_DIG),

--=-zKpL46rF6CTdfREwGLRz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-zKpL46rF6CTdfREwGLRz
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-zKpL46rF6CTdfREwGLRz--

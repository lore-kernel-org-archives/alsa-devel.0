From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Sigmatel STAC9250 (7634) test patch 6
Date: Tue, 19 Dec 2006 08:55:03 -0800
Message-ID: <1166547303.25873.88.camel@razman>
References: <1165941741.4142.10.camel@razman> <s5h1wmwfabe.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-E57frbDJHGOe8sJp1/oD"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h1wmwfabe.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-E57frbDJHGOe8sJp1/oD
Content-Type: multipart/alternative; boundary="=-XqczgJ+r61gEinJix95H"


--=-XqczgJ+r61gEinJix95H
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Unfortunately, it's not in good shape.  I have 4 testers that all report
kernel segfaults with this driver.  Also, it appears as though we're
getting the modem side of the codec instead of the audio side (this is a
single chip solution from Sigmatel/IDT).  I've done everything I can
think of based on the datasheet and using other similar Sigmatel codecs
as a guide (9200 is the closest match based on the data sheets).

Attached is a sample dmesg output from one of the users.  Here's a quote
from one of them:

        I tried this patch and got similar results--still get a segfault
        trying to play with mplayer.  Attached are dmesg.out and
        dmesg.out-ref which are the output of dmesg using no options as
        well as model=ref, respectively.  In alsamixer the five bars
        that show up are Master, Capture, Caller I, Input So, and
        Off-hook.  I don't have a microphone so I can't test recording.

This one has proven to be more difficult than the Conexant stuff.  From
what I can tell, this patch should just work, but it doesn't.  As you
can see by the dmesg outputs, the pciquirk isn't getting handled.
His particular subsystem id (from lspci -vn) is 107b:0461.

I'm at a loss as to why this doesn't work.


Tobin


On Tue, 2006-12-19 at 11:29 +0100, Takashi Iwai wrote:

> At Tue, 12 Dec 2006 08:42:21 -0800,
> Tobin Davis wrote:
> > 
> > Copied to alsa-devel for archival purposes, hints, suggestions, etc.
> 
> Looks pretty good to me.
> Pleas let me know if it's already in a shape to be merged.
> 
> 
> thanks,
> 
> Takashi

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-XqczgJ+r61gEinJix95H
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Unfortunately, it's not in good shape.&nbsp; I have 4 testers that all report kernel segfaults with this driver.&nbsp; Also, it appears as though we're getting the modem side of the codec instead of the audio side (this is a single chip solution from Sigmatel/IDT).&nbsp; I've done everything I can think of based on the datasheet and using other similar Sigmatel codecs as a guide (9200 is the closest match based on the data sheets).<BR>
<BR>
Attached is a sample dmesg output from one of the users.&nbsp; Here's a quote from one of them:<BR>
<BLOCKQUOTE>
    I tried this patch and got similar results--still get a segfault trying to play with mplayer.&nbsp; Attached are dmesg.out and dmesg.out-ref which are the output of dmesg using no options as well as model=ref, respectively.&nbsp; In alsamixer the five bars that show up are Master, Capture, Caller I, Input So, and Off-hook.&nbsp; I don't have a microphone so I can't test recording.<BR>
</BLOCKQUOTE>
This one has proven to be more difficult than the Conexant stuff.&nbsp; From what I can tell, this patch should just work, but it doesn't.&nbsp; As you can see by the dmesg outputs, the pciquirk isn't getting handled.<BR>
His particular subsystem id (from lspci -vn) is 107b:0461.<BR>
<BR>
I'm at a loss as to why this doesn't work.<BR>
<BR>
<BR>
Tobin<BR>
<BR>
<BR>
On Tue, 2006-12-19 at 11:29 +0100, Takashi Iwai wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">At Tue, 12 Dec 2006 08:42:21 -0800,</FONT>
<FONT COLOR="#000000">Tobin Davis wrote:</FONT>
<FONT COLOR="#000000">&gt; </FONT>
<FONT COLOR="#000000">&gt; Copied to alsa-devel for archival purposes, hints, suggestions, etc.</FONT>

<FONT COLOR="#000000">Looks pretty good to me.</FONT>
<FONT COLOR="#000000">Pleas let me know if it's already in a shape to be merged.</FONT>


<FONT COLOR="#000000">thanks,</FONT>

<FONT COLOR="#000000">Takashi</FONT>
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

--=-XqczgJ+r61gEinJix95H--

--=-E57frbDJHGOe8sJp1/oD
Content-Disposition: attachment; filename=dmesg.out
Content-Type: text/plain; name=dmesg.out; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1787: hda_codec: Unknown model for STAC925x, using BIOS defaults
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 07 bios pin config 40c003f0
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 08 bios pin config 424503f2
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 0a bios pin config 01813022
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 0b bios pin config 02a19021
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 0c bios pin config 90a70320
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 0d bios pin config 02214210
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 10 bios pin config 400003f1
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 11 bios pin config 9033032e
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2175: autoconfig: line_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2179:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2183:    hp_outs=1 (0xd/0x0/0x0/0x0/0x0)
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2191:    inputs: mic=0xc, fmic=0xb, line=0xa, fline=0x0, cd=0x11, aux=0x0
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
f88f9b1e
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: snd_hda_intel snd_hda_codec snd_pcm snd_timer snd snd_page_alloc
CPU:    0
EIP:    0060:[<f88f9b1e>]    Not tainted VLI
EFLAGS: 00210286   (2.6.16-gentoo-r3 #4) 
EIP is at azx_pcm_open+0x13/0x195 [snd_hda_intel]
eax: 00000000   ebx: 00000000   ecx: f6316274   edx: f74e3214
esi: f5c4fe24   edi: f5c4e000   ebp: 00000000   esp: f5c4fdc0
ds: 007b   es: 007b   ss: 0068
Process mplayer (pid: 5219, threadinfo=f5c4e000 task=f79d1070)
Stack: <0>00000010 f94b5a72 000f4240 00000011 0000000b ffffffff f68f5d80 f68f5c14 
       00000000 f5c4fe24 f5c4e000 f7635814 f94b6892 f74e3214 00000000 f7aada40 
       f5c4fe04 f74e3214 f5c4fe48 f7aada40 f94b6930 f7635814 00000000 f7aada40 
Call Trace:
 [<f94b5a72>] snd_pcm_hw_rule_mulkdiv+0x0/0x75 [snd_pcm]
 [<f94b6892>] snd_pcm_open_substream+0x62/0xc9 [snd_pcm]
 [<f94b6930>] snd_pcm_open_file+0x37/0xce [snd_pcm]
 [<f94b6b68>] snd_pcm_open+0x12b/0x1d8 [snd_pcm]
 [<c011c292>] default_wake_function+0x0/0x12
 [<c016d34a>] cdev_get+0x5d/0xc2
 [<f94b69c7>] snd_pcm_playback_open+0x0/0x3b [snd_pcm]
 [<f94b69fe>] snd_pcm_playback_open+0x37/0x3b [snd_pcm]
 [<f9488246>] snd_open+0x172/0x29e [snd]
 [<f94880d4>] snd_open+0x0/0x29e [snd]
 [<c016d516>] chrdev_open+0xf3/0x1c8
 [<c016d423>] chrdev_open+0x0/0x1c8
 [<c0162bc4>] __dentry_open+0x18d/0x26a
 [<c0162dd4>] nameidata_to_filp+0x37/0x4f
 [<c0162cf1>] do_filp_open+0x50/0x56
 [<c0162f14>] get_unused_fd+0xb4/0xdc
 [<c0163070>] do_sys_open+0x63/0xfe
 [<c0163132>] sys_open+0x27/0x2b
 [<c0102df3>] sysenter_past_esp+0x54/0x75
Code: 04 d2 03 00 00 c7 04 24 3c ae 8f f8 e8 be 42 b9 00 b8 fa ff ff ff eb b5 55 57 56 53 83 ec 20 8b 44 24 34 8b 68 08 89 c2 8b 40 30 <8b> 44 85 08 89 44 24 1c 8b 5d 00 8b 4a 5c 8d 43 34 89 4c 24 18 
 

--=-E57frbDJHGOe8sJp1/oD
Content-Disposition: attachment; filename=dmesg.out-ref
Content-Type: text/plain; name=dmesg.out-ref; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1787: hda_codec: Unknown model for STAC925x, using BIOS defaults
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 07 bios pin config 40c003f0
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 08 bios pin config 424503f2
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 0a bios pin config 01813022
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 0b bios pin config 02a19021
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 0c bios pin config 90a70320
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 0d bios pin config 02214210
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 10 bios pin config 400003f1
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:689: hda_codec: pin nid 11 bios pin config 9033032e
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2175: autoconfig: line_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2179:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2183:    hp_outs=1 (0xd/0x0/0x0/0x0/0x0)
ALSA /usr/src/alsa-driver-1.0.14rc1/pci/hda/hda_codec.c:2191:    inputs: mic=0xc, fmic=0xb, line=0xa, fline=0x0, cd=0x11, aux=0x0
Unable to handle kernel NULL pointer dereference at virtual address 00000008
 printing eip:
f88f9b1e
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: snd_hda_intel snd_hda_codec snd_pcm snd_timer snd snd_page_alloc
CPU:    0
EIP:    0060:[<f88f9b1e>]    Not tainted VLI
EFLAGS: 00210286   (2.6.16-gentoo-r3 #4) 
EIP is at azx_pcm_open+0x13/0x195 [snd_hda_intel]
eax: 00000000   ebx: 00000000   ecx: f61b0274   edx: f7a42214
esi: f6ccde24   edi: f6ccc000   ebp: 00000000   esp: f6ccddc0
ds: 007b   es: 007b   ss: 0068
Process mplayer (pid: 5218, threadinfo=f6ccc000 task=f6c76580)
Stack: <0>00000010 f94b5a72 000f4240 00000011 0000000b ffffffff f646bd80 f646bc14 
       00000000 f6ccde24 f6ccc000 f7a42e14 f94b6892 f7a42214 00000000 f69cfb40 
       f6ccde04 f7a42214 f6ccde48 f69cfb40 f94b6930 f7a42e14 00000000 f69cfb40 
Call Trace:
 [<f94b5a72>] snd_pcm_hw_rule_mulkdiv+0x0/0x75 [snd_pcm]
 [<f94b6892>] snd_pcm_open_substream+0x62/0xc9 [snd_pcm]
 [<f94b6930>] snd_pcm_open_file+0x37/0xce [snd_pcm]
 [<f94b6b68>] snd_pcm_open+0x12b/0x1d8 [snd_pcm]
 [<c011c292>] default_wake_function+0x0/0x12
 [<c016d34a>] cdev_get+0x5d/0xc2
 [<f94b69c7>] snd_pcm_playback_open+0x0/0x3b [snd_pcm]
 [<f94b69fe>] snd_pcm_playback_open+0x37/0x3b [snd_pcm]
 [<f9488246>] snd_open+0x172/0x29e [snd]
 [<f94880d4>] snd_open+0x0/0x29e [snd]
 [<c016d516>] chrdev_open+0xf3/0x1c8
 [<c016d423>] chrdev_open+0x0/0x1c8
 [<c0162bc4>] __dentry_open+0x18d/0x26a
 [<c0162dd4>] nameidata_to_filp+0x37/0x4f
 [<c0162cf1>] do_filp_open+0x50/0x56
 [<c0162f14>] get_unused_fd+0xb4/0xdc
 [<c0163070>] do_sys_open+0x63/0xfe
 [<c0163132>] sys_open+0x27/0x2b
 [<c0102df3>] sysenter_past_esp+0x54/0x75
Code: 04 d2 03 00 00 c7 04 24 3c ae 8f f8 e8 be 42 b9 00 b8 fa ff ff ff eb b5 55 57 56 53 83 ec 20 8b 44 24 34 8b 68 08 89 c2 8b 40 30 <8b> 44 85 08 89 44 24 1c 8b 5d 00 8b 4a 5c 8d 43 34 89 4c 24 18 
 

--=-E57frbDJHGOe8sJp1/oD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-E57frbDJHGOe8sJp1/oD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-E57frbDJHGOe8sJp1/oD--

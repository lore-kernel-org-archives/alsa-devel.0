From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Samsung Audio Problem (update)
Date: Thu, 07 Dec 2006 15:24:22 -0800
Message-ID: <1165533862.7530.53.camel@razman>
References: <5FD5754DDBA0B1499B5A0B4BB54194852FFD0A@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0841368967=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E38B42DA
	for <alsa-devel@alsa-project.org>; Fri,  8 Dec 2006 00:24:25 +0100 (MET)
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB54194852FFD0A@fmsmsx411.amr.corp.intel.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Allyn, Mark A" <mark.a.allyn@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0841368967==
Content-Type: multipart/alternative; boundary="=-gq9hpV6nf0DyhIkvRxdP"


--=-gq9hpV6nf0DyhIkvRxdP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Could you send the new dmesg output as well as the output from
cat /proc/asound/card0/codec#0?  I'm assuming you compiled the driver
with "--with-debug=detect"?  I need to see what the driver reports after
loading.

Thanks,

Tobin

On Thu, 2006-12-07 at 14:03 -0800, Allyn, Mark A wrote:

> Tobin:
>  
> I did apply the patch as you suggest. The dmesg from the modprobe of the
> snd-hda-intel does show 
> the ultra (Samsung) loading. However, there is still no recording. I set
> all of the sliders on 
> 100 percent and I made sure that the capture is on both mike and
> capture. Audio playback of 
> existing audio files is okay.
>  
> Mark
> 
> ________________________________
> 
> From: Tobin Davis [mailto:tdavis@dsl-only.net] 
> Sent: Wednesday, December 06, 2006 3:31 PM
> To: Allyn, Mark A
> Cc: alsa-devel@lists.sourceforge.net
> Subject: RE: [Alsa-devel] Samsung Audio Problem (update)
> 
> 
> Mark,
> After looking through the documentation and the Windows regestry
> settings for that system's driver, I found some interesting differences
> to the microphone selector.
> 
> Try this patch against the alsa-driver-hg20061130 snapshot
> (ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/alsa-driver-hg2006
> 1129.tar.bz2).
> 
> To apply:
> tar -jxvf alsa-driver-hg20061130.tar.bz2
> cd alsa-driver-hg20061130/alsa-kernel
> patch -p1 <SamsungQ1.patch
> cd ..
> ./configure --with-cards=hda-intel --with-debug=detect ; make ; make
> install
> 
> Let me know if this fixes your microphone.  I also added the subdevice
> id so you shouldn't need to add any model parameters.
> 
> Tobin
> 
> On Tue, 2006-12-05 at 10:46 -0800, Allyn, Mark A wrote: 
> 
> 	Tobin:
> 	
> 	Here is the result of the debug=detect & codec#0:
> 	
> 	=====================================================
> 	
> 	[17179640.512000] PCI: Setting latency timer of device
> 0000:00:1b.0 to
> 	64
> 	[17179640.544000] ALSA
> 	/mnt1/src/asianux/BUILD/alsa-driver-hg20061130/pci/hda/../..
> 	                       /alsa-kernel/pci/hda/hda_intel.c:696:
> codec_mask
> 	= 0x1
> 	[17179640.740000] ALSA
> 	
> /mnt1/src/asianux/BUILD/alsa-driver-hg20061130/pci/hda/hda_codec.c:1743:
> 	
> 	                       hda_codec: model 'laptop-eapd' is
> selected
> 	
> 	
> ========================================================================
> 	output of codec#0
> 	Codec: Analog Devices AD1986A
> 	Address: 0
> 	Vendor Id: 0x11d41986
> 	Subsystem Id: 0x144dc027
> 	Revision Id: 0x100500
> 	Default PCM:
> 	    rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000
> 	    bits [0xe]: 16 20 24
> 	    formats [0x1]: PCM
> 	Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00,
> mute=1
> 	Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05,
> mute=1
> 	Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
> 	  PCM:
> 	    rates [0x60]: 44100 48000
> 	    bits [0x2]: 16
> 	    formats [0x5]: PCM AC3
> 	  Connection: 2
> 	     0x01* 0x06
> 	Node 0x03 [Audio Output] wcaps 0x44d: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Power: 0x0
> 	Node 0x04 [Audio Output] wcaps 0x40d: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Power: 0x0
> 	Node 0x05 [Audio Output] wcaps 0x40d: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Power: 0x0
> 	Node 0x06 [Audio Input] wcaps 0x100511: Stereo
> 	  PCM:
> 	    rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000
> 	    bits [0x6]: 16 20
> 	    formats [0x1]: PCM
> 	  Power: 0x0
> 	  Connection: 1
> 	     0x12
> 	Node 0x07 [Audio Mixer] wcaps 0x200101: Stereo
> 	  Connection: 8
> 	     0x03 0x09 0x13 0x14 0x15 0x16 0x17 0x18
> 	Node 0x08 [Audio Mixer] wcaps 0x200100: Mono
> 	  Connection: 1
> 	     0x07
> 	Node 0x09 [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
> 	  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> 	  Amp-In vals:  [0x80] [0x80]
> 	  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> 	  Amp-Out vals:  [0x80]
> 	  Connection: 2
> 	     0x04 0x05
> 	Node 0x0a [Audio Selector] wcaps 0x300101: Stereo
> 	  Connection: 3
> 	     0x07* 0x04 0x05
> 	Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
> 	  Connection: 2
> 	     0x07* 0x04
> 	Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
> 	  Connection: 2
> 	     0x04* 0x07
> 	Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
> 	  Connection: 2
> 	     0x05* 0x08
> 	Node 0x0e [Audio Selector] wcaps 0x300100: Mono
> 	  Connection: 2
> 	     0x08* 0x11
> 	Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
> 	  Amp-Out vals:  [0x00 0x00]
> 	  Connection: 8
> 	     0x1f* 0x20 0x1d 0x1d 0x27 0x28 0x29 0x2a
> 	Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
> 	  Connection: 3
> 	     0x20* 0x1c 0x1f
> 	Node 0x11 [Audio Selector] wcaps 0x300941: Stereo
> 	  Connection: 2
> 	     0x0f* 0x2b
> 	Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Connection: 8
> 	     0x11* 0x22 0x00 0x21 0x10 0x07 0x08 0x23
> 	Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Connection: 1
> 	     0x11
> 	Node 0x14 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
> 	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80]
> 	  Connection: 1
> 	     0x23
> 	Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Connection: 1
> 	     0x22
> 	Node 0x16 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Connection: 1
> 	     0x21
> 	Node 0x17 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Connection: 1
> 	     0x10
> 	Node 0x18 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
> 	  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
> 	  Amp-Out vals:  [0x8f]
> 	  Connection: 2
> 	     0x19* 0x24
> 	Node 0x19 [Beep Generator Widget] wcaps 0x700000: Mono
> 	Node 0x1a [Pin Complex] wcaps 0x400185: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Pincap 0x081f: OUT HP Detect
> 	  Pin Default 0x02214021: [Jack] HP Out at Ext Front
> 	    Conn = 1/8, Color = Green
> 	  Pin-ctls: 0xc0: OUT HP
> 	  Connection: 1
> 	     0x0a
> 	Node 0x1b [Pin Complex] wcaps 0x400185: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Pincap 0x081001f: OUT HP EAPD Detect
> 	  Pin Default 0x01014011: [Jack] Line Out at Ext Rear
> 	    Conn = 1/8, Color = Green
> 	  Pin-ctls: 0x40: OUT
> 	  Connection: 1
> 	     0x0b
> 	Node 0x1c [Pin Complex] wcaps 0x400185: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Pincap 0x0837: IN OUT Detect
> 	  Pin Default 0x41013012: [N/A] Line Out at Ext Rear
> 	    Conn = 1/8, Color = Blue
> 	  Pin-ctls: 0x40: OUT
> 	  Connection: 1
> 	     0x0c
> 	Node 0x1d [Pin Complex] wcaps 0x400985: Stereo Amp-Out
> 	  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80 0x80]
> 	  Pincap 0x081737: IN OUT Detect
> 	  Pin Default 0x01019015: [Jack] Line Out at Ext Rear
> 	    Conn = 1/8, Color = Pink
> 	  Pin-ctls: 0x40: OUT
> 	  Connection: 1
> 	     0x0d
> 	Node 0x1e [Pin Complex] wcaps 0x400104: Mono Amp-Out
> 	  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
> 	  Amp-Out vals:  [0x80]
> 	  Pincap 0x0810: OUT
> 	  Pin Default 0x511710f0: [N/A] Speaker at Int Rear
> 	    Conn = Analog, Color = Black
> 	  Pin-ctls: 0x40: OUT
> 	  Connection: 1
> 	     0x0e
> 	Node 0x1f [Pin Complex] wcaps 0x400081: Stereo
> 	  Pincap 0x081727: IN Detect
> 	  Pin Default 0x02a190f0: [Jack] Mic at Ext Front
> 	    Conn = 1/8, Color = Pink
> 	  Pin-ctls: 0x24: IN
> 	Node 0x20 [Pin Complex] wcaps 0x400081: Stereo
> 	  Pincap 0x081727: IN Detect
> 	  Pin Default 0x418130f0: [N/A] Line In at Ext Rear
> 	    Conn = 1/8, Color = Blue
> 	  Pin-ctls: 0x20: IN
> 	Node 0x21 [Pin Complex] wcaps 0x400081: Stereo
> 	  Pincap 0x0827: IN Detect
> 	  Pin Default 0x5997e0f0: [N/A] Aux at Int ATAPI
> 	    Conn = Analog, Color = White
> 	  Pin-ctls: 0x20: IN
> 	Node 0x22 [Pin Complex] wcaps 0x400001: Stereo
> 	  Pincap 0x0820: IN
> 	  Pin Default 0x593310f0: [N/A] CD at Int ATAPI
> 	    Conn = ATAPI, Color = Black
> 	  Pin-ctls: 0x20: IN
> 	Node 0x23 [Pin Complex] wcaps 0x400000: Mono
> 	  Pincap 0x0820: IN
> 	  Pin Default 0x59b770f0: [N/A] Telephony at Int ATAPI
> 	    Conn = Analog, Color = Yellow
> 	  Pin-ctls: 0x20: IN
> 	Node 0x24 [Pin Complex] wcaps 0x400000: Mono
> 	  Pincap 0x0820: IN
> 	  Pin Default 0x51f710f0: [N/A] Other at Int Rear
> 	    Conn = Analog, Color = Black
> 	  Pin-ctls: 0x20: IN
> 	Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
> 	  Pincap 0x0810: OUT
> 	  Pin Default 0x4145f0f0: [N/A] SPDIF Out at Ext Rear
> 	    Conn = Optical, Color = Other
> 	  Pin-ctls: 0x40: OUT
> 	  Connection: 1
> 	     0x02
> 	Node 0x26 [Power Widget] wcaps 0x500500: Mono
> 	  Power: 0x0
> 	  Connection: 8
> 	     0x07* 0x08 0x13 0x14 0x15 0x16 0x17 0x18
> 	Node 0x27 [Audio Mixer] wcaps 0x200101: Stereo
> 	  Connection: 2
> 	     0x1f 0x1d
> 	Node 0x28 [Audio Mixer] wcaps 0x200101: Stereo
> 	  Connection: 2
> 	     0x1f 0x20
> 	Node 0x29 [Audio Mixer] wcaps 0x200101: Stereo
> 	  Connection: 2
> 	     0x1d 0x20
> 	Node 0x2a [Audio Mixer] wcaps 0x200101: Stereo
> 	  Connection: 3
> 	     0x1f 0x1d 0x20
> 	Node 0x2b [Audio Mixer] wcaps 0x200100: Mono
> 	  Connection: 1
> 	     0x0f
> 	
> 	====================================================== 
> 	
> 	________________________________
> 	
> 	From: Tobin Davis [mailto:tdavis@dsl-only.net] 
> 	Sent: Tuesday, December 05, 2006 7:26 AM
> 	To: Allyn, Mark A
> 	Cc: alsa-devel@lists.sourceforge.net
> 	Subject: Re: [Alsa-devel] Samsung Audio Problem (update)
> 	
> 	
> 	Could you send a couple of things to the mailing list?
> Specifically,
> 	recompile the driver with "--with-debug=detect", reinstall it,
> and send
> 	the output from dmesg after installing the driver.  Also, send
> the
> 	output from 'cat /proc/asound/card0/codec*'.
> 	
> 	I have a laptop (Asus Z62F) with the exact same codec,   and I
> had to do
> 	some fiddling with the alsamixer controls before I could use
> either the
> 	internal mic or the external mic.  You might also check that.
> The mic
> 	gain is listed as an output for some reason (it's been marked as
> "fixme"
> 	in the code for quite some time).
> 	
> 	Tobin
> 	
> 	On Mon, 2006-12-04 at 13:43 -0800, Allyn, Mark A wrote: 
> 	
> 		Hello:
> 		 
> 		With thanks to Tobin Davis, I was able to resolve part
> of my
> 	problem.
> 		
> 		With using the latest snapshot of the alsa driver as
> well as
> 	adding
> 		
> 		options snd-hda-intel model=laptop-eapd
> 		
> 		to the /etc/modprobe.conf file, I was able to get rid of
> the
> 	high
> 		pitched
> 		squeal and have proper audio playback on the internal
> speakers.
> 		
> 		I am still unable to record. For your benefit, I do have
> some
> 	more
> 		Information on the audio device. From the lspci -qn, I
> got:
> 		
> 		Class: 0403
> 		8086:2668	rev03
> 		Subsystem: 144D:C027
> 		
> 		Has anyone got audio recording working on this codec and
> 	subsystem?
> 		
> 		Thank you
> 		
> 		Mark Allyn
> 		
> 		
> 	
> ------------------------------------------------------------------------
> 	-
> 		Take Surveys. Earn Cash. Influence the Future of IT
> 		Join SourceForge.net's Techsay panel and you'll get the
> chance
> 	to share your
> 		opinions on IT & business topics through brief surveys -
> and
> 	earn cash
> 		
> 	
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE
> 	V
> 		_______________________________________________
> 		Alsa-devel mailing list
> 		Alsa-devel@lists.sourceforge.net
> 		https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 		
> 	
> 	
> 

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-gq9hpV6nf0DyhIkvRxdP
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Could you send the new dmesg output as well as the output from cat /proc/asound/card0/codec#0?&nbsp; I'm assuming you compiled the driver with &quot;--with-debug=detect&quot;?&nbsp; I need to see what the driver reports after loading.<BR>
<BR>
Thanks,<BR>
<BR>
Tobin<BR>
<BR>
On Thu, 2006-12-07 at 14:03 -0800, Allyn, Mark A wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">Tobin:</FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">I did apply the patch as you suggest. The dmesg from the modprobe of the</FONT>
<FONT COLOR="#000000">snd-hda-intel does show </FONT>
<FONT COLOR="#000000">the ultra (Samsung) loading. However, there is still no recording. I set</FONT>
<FONT COLOR="#000000">all of the sliders on </FONT>
<FONT COLOR="#000000">100 percent and I made sure that the capture is on both mike and</FONT>
<FONT COLOR="#000000">capture. Audio playback of </FONT>
<FONT COLOR="#000000">existing audio files is okay.</FONT>
<FONT COLOR="#000000"> </FONT>
<FONT COLOR="#000000">Mark</FONT>

<FONT COLOR="#000000">________________________________</FONT>

<FONT COLOR="#000000">From: Tobin Davis [mailto:<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>] </FONT>
<FONT COLOR="#000000">Sent: Wednesday, December 06, 2006 3:31 PM</FONT>
<FONT COLOR="#000000">To: Allyn, Mark A</FONT>
<FONT COLOR="#000000">Cc: <A HREF="mailto:alsa-devel@lists.sourceforge.net">alsa-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000">Subject: RE: [Alsa-devel] Samsung Audio Problem (update)</FONT>


<FONT COLOR="#000000">Mark,</FONT>
<FONT COLOR="#000000">After looking through the documentation and the Windows regestry</FONT>
<FONT COLOR="#000000">settings for that system's driver, I found some interesting differences</FONT>
<FONT COLOR="#000000">to the microphone selector.</FONT>

<FONT COLOR="#000000">Try this patch against the alsa-driver-hg20061130 snapshot</FONT>
<FONT COLOR="#000000">(<A HREF="ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/alsa-driver-hg2006">ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/alsa-driver-hg2006</A></FONT>
<FONT COLOR="#000000">1129.tar.bz2).</FONT>

<FONT COLOR="#000000">To apply:</FONT>
<FONT COLOR="#000000">tar -jxvf alsa-driver-hg20061130.tar.bz2</FONT>
<FONT COLOR="#000000">cd alsa-driver-hg20061130/alsa-kernel</FONT>
<FONT COLOR="#000000">patch -p1 &lt;SamsungQ1.patch</FONT>
<FONT COLOR="#000000">cd ..</FONT>
<FONT COLOR="#000000">./configure --with-cards=hda-intel --with-debug=detect ; make ; make</FONT>
<FONT COLOR="#000000">install</FONT>

<FONT COLOR="#000000">Let me know if this fixes your microphone.  I also added the subdevice</FONT>
<FONT COLOR="#000000">id so you shouldn't need to add any model parameters.</FONT>

<FONT COLOR="#000000">Tobin</FONT>

<FONT COLOR="#000000">On Tue, 2006-12-05 at 10:46 -0800, Allyn, Mark A wrote: </FONT>

<FONT COLOR="#000000">	Tobin:</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	Here is the result of the debug=detect &amp; codec#0:</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	=====================================================</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	[17179640.512000] PCI: Setting latency timer of device</FONT>
<FONT COLOR="#000000">0000:00:1b.0 to</FONT>
<FONT COLOR="#000000">	64</FONT>
<FONT COLOR="#000000">	[17179640.544000] ALSA</FONT>
<FONT COLOR="#000000">	/mnt1/src/asianux/BUILD/alsa-driver-hg20061130/pci/hda/../..</FONT>
<FONT COLOR="#000000">	                       /alsa-kernel/pci/hda/hda_intel.c:696:</FONT>
<FONT COLOR="#000000">codec_mask</FONT>
<FONT COLOR="#000000">	= 0x1</FONT>
<FONT COLOR="#000000">	[17179640.740000] ALSA</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">/mnt1/src/asianux/BUILD/alsa-driver-hg20061130/pci/hda/hda_codec.c:1743:</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	                       hda_codec: model 'laptop-eapd' is</FONT>
<FONT COLOR="#000000">selected</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">========================================================================</FONT>
<FONT COLOR="#000000">	output of codec#0</FONT>
<FONT COLOR="#000000">	Codec: Analog Devices AD1986A</FONT>
<FONT COLOR="#000000">	Address: 0</FONT>
<FONT COLOR="#000000">	Vendor Id: 0x11d41986</FONT>
<FONT COLOR="#000000">	Subsystem Id: 0x144dc027</FONT>
<FONT COLOR="#000000">	Revision Id: 0x100500</FONT>
<FONT COLOR="#000000">	Default PCM:</FONT>
<FONT COLOR="#000000">	    rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000</FONT>
<FONT COLOR="#000000">	    bits [0xe]: 16 20 24</FONT>
<FONT COLOR="#000000">	    formats [0x1]: PCM</FONT>
<FONT COLOR="#000000">	Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00,</FONT>
<FONT COLOR="#000000">mute=1</FONT>
<FONT COLOR="#000000">	Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05,</FONT>
<FONT COLOR="#000000">mute=1</FONT>
<FONT COLOR="#000000">	Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital</FONT>
<FONT COLOR="#000000">	  PCM:</FONT>
<FONT COLOR="#000000">	    rates [0x60]: 44100 48000</FONT>
<FONT COLOR="#000000">	    bits [0x2]: 16</FONT>
<FONT COLOR="#000000">	    formats [0x5]: PCM AC3</FONT>
<FONT COLOR="#000000">	  Connection: 2</FONT>
<FONT COLOR="#000000">	     0x01* 0x06</FONT>
<FONT COLOR="#000000">	Node 0x03 [Audio Output] wcaps 0x44d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">	  Power: 0x0</FONT>
<FONT COLOR="#000000">	Node 0x04 [Audio Output] wcaps 0x40d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">	  Power: 0x0</FONT>
<FONT COLOR="#000000">	Node 0x05 [Audio Output] wcaps 0x40d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">	  Power: 0x0</FONT>
<FONT COLOR="#000000">	Node 0x06 [Audio Input] wcaps 0x100511: Stereo</FONT>
<FONT COLOR="#000000">	  PCM:</FONT>
<FONT COLOR="#000000">	    rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000</FONT>
<FONT COLOR="#000000">	    bits [0x6]: 16 20</FONT>
<FONT COLOR="#000000">	    formats [0x1]: PCM</FONT>
<FONT COLOR="#000000">	  Power: 0x0</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x12</FONT>
<FONT COLOR="#000000">	Node 0x07 [Audio Mixer] wcaps 0x200101: Stereo</FONT>
<FONT COLOR="#000000">	  Connection: 8</FONT>
<FONT COLOR="#000000">	     0x03 0x09 0x13 0x14 0x15 0x16 0x17 0x18</FONT>
<FONT COLOR="#000000">	Node 0x08 [Audio Mixer] wcaps 0x200100: Mono</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x07</FONT>
<FONT COLOR="#000000">	Node 0x09 [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-In vals:  [0x80] [0x80]</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80]</FONT>
<FONT COLOR="#000000">	  Connection: 2</FONT>
<FONT COLOR="#000000">	     0x04 0x05</FONT>
<FONT COLOR="#000000">	Node 0x0a [Audio Selector] wcaps 0x300101: Stereo</FONT>
<FONT COLOR="#000000">	  Connection: 3</FONT>
<FONT COLOR="#000000">	     0x07* 0x04 0x05</FONT>
<FONT COLOR="#000000">	Node 0x0b [Audio Selector] wcaps 0x300101: Stereo</FONT>
<FONT COLOR="#000000">	  Connection: 2</FONT>
<FONT COLOR="#000000">	     0x07* 0x04</FONT>
<FONT COLOR="#000000">	Node 0x0c [Audio Selector] wcaps 0x300101: Stereo</FONT>
<FONT COLOR="#000000">	  Connection: 2</FONT>
<FONT COLOR="#000000">	     0x04* 0x07</FONT>
<FONT COLOR="#000000">	Node 0x0d [Audio Selector] wcaps 0x300101: Stereo</FONT>
<FONT COLOR="#000000">	  Connection: 2</FONT>
<FONT COLOR="#000000">	     0x05* 0x08</FONT>
<FONT COLOR="#000000">	Node 0x0e [Audio Selector] wcaps 0x300100: Mono</FONT>
<FONT COLOR="#000000">	  Connection: 2</FONT>
<FONT COLOR="#000000">	     0x08* 0x11</FONT>
<FONT COLOR="#000000">	Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x00 0x00]</FONT>
<FONT COLOR="#000000">	  Connection: 8</FONT>
<FONT COLOR="#000000">	     0x1f* 0x20 0x1d 0x1d 0x27 0x28 0x29 0x2a</FONT>
<FONT COLOR="#000000">	Node 0x10 [Audio Selector] wcaps 0x300101: Stereo</FONT>
<FONT COLOR="#000000">	  Connection: 3</FONT>
<FONT COLOR="#000000">	     0x20* 0x1c 0x1f</FONT>
<FONT COLOR="#000000">	Node 0x11 [Audio Selector] wcaps 0x300941: Stereo</FONT>
<FONT COLOR="#000000">	  Connection: 2</FONT>
<FONT COLOR="#000000">	     0x0f* 0x2b</FONT>
<FONT COLOR="#000000">	Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">	  Connection: 8</FONT>
<FONT COLOR="#000000">	     0x11* 0x22 0x00 0x21 0x10 0x07 0x08 0x23</FONT>
<FONT COLOR="#000000">	Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x11</FONT>
<FONT COLOR="#000000">	Node 0x14 [Audio Selector] wcaps 0x30010c: Mono Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80]</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x23</FONT>
<FONT COLOR="#000000">	Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x22</FONT>
<FONT COLOR="#000000">	Node 0x16 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x21</FONT>
<FONT COLOR="#000000">	Node 0x17 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x10</FONT>
<FONT COLOR="#000000">	Node 0x18 [Audio Selector] wcaps 0x30010c: Mono Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x8f]</FONT>
<FONT COLOR="#000000">	  Connection: 2</FONT>
<FONT COLOR="#000000">	     0x19* 0x24</FONT>
<FONT COLOR="#000000">	Node 0x19 [Beep Generator Widget] wcaps 0x700000: Mono</FONT>
<FONT COLOR="#000000">	Node 0x1a [Pin Complex] wcaps 0x400185: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">	  Pincap 0x081f: OUT HP Detect</FONT>
<FONT COLOR="#000000">	  Pin Default 0x02214021: [Jack] HP Out at Ext Front</FONT>
<FONT COLOR="#000000">	    Conn = 1/8, Color = Green</FONT>
<FONT COLOR="#000000">	  Pin-ctls: 0xc0: OUT HP</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x0a</FONT>
<FONT COLOR="#000000">	Node 0x1b [Pin Complex] wcaps 0x400185: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">	  Pincap 0x081001f: OUT HP EAPD Detect</FONT>
<FONT COLOR="#000000">	  Pin Default 0x01014011: [Jack] Line Out at Ext Rear</FONT>
<FONT COLOR="#000000">	    Conn = 1/8, Color = Green</FONT>
<FONT COLOR="#000000">	  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x0b</FONT>
<FONT COLOR="#000000">	Node 0x1c [Pin Complex] wcaps 0x400185: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">	  Pincap 0x0837: IN OUT Detect</FONT>
<FONT COLOR="#000000">	  Pin Default 0x41013012: [N/A] Line Out at Ext Rear</FONT>
<FONT COLOR="#000000">	    Conn = 1/8, Color = Blue</FONT>
<FONT COLOR="#000000">	  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x0c</FONT>
<FONT COLOR="#000000">	Node 0x1d [Pin Complex] wcaps 0x400985: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">	  Pincap 0x081737: IN OUT Detect</FONT>
<FONT COLOR="#000000">	  Pin Default 0x01019015: [Jack] Line Out at Ext Rear</FONT>
<FONT COLOR="#000000">	    Conn = 1/8, Color = Pink</FONT>
<FONT COLOR="#000000">	  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x0d</FONT>
<FONT COLOR="#000000">	Node 0x1e [Pin Complex] wcaps 0x400104: Mono Amp-Out</FONT>
<FONT COLOR="#000000">	  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">	  Amp-Out vals:  [0x80]</FONT>
<FONT COLOR="#000000">	  Pincap 0x0810: OUT</FONT>
<FONT COLOR="#000000">	  Pin Default 0x511710f0: [N/A] Speaker at Int Rear</FONT>
<FONT COLOR="#000000">	    Conn = Analog, Color = Black</FONT>
<FONT COLOR="#000000">	  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x0e</FONT>
<FONT COLOR="#000000">	Node 0x1f [Pin Complex] wcaps 0x400081: Stereo</FONT>
<FONT COLOR="#000000">	  Pincap 0x081727: IN Detect</FONT>
<FONT COLOR="#000000">	  Pin Default 0x02a190f0: [Jack] Mic at Ext Front</FONT>
<FONT COLOR="#000000">	    Conn = 1/8, Color = Pink</FONT>
<FONT COLOR="#000000">	  Pin-ctls: 0x24: IN</FONT>
<FONT COLOR="#000000">	Node 0x20 [Pin Complex] wcaps 0x400081: Stereo</FONT>
<FONT COLOR="#000000">	  Pincap 0x081727: IN Detect</FONT>
<FONT COLOR="#000000">	  Pin Default 0x418130f0: [N/A] Line In at Ext Rear</FONT>
<FONT COLOR="#000000">	    Conn = 1/8, Color = Blue</FONT>
<FONT COLOR="#000000">	  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">	Node 0x21 [Pin Complex] wcaps 0x400081: Stereo</FONT>
<FONT COLOR="#000000">	  Pincap 0x0827: IN Detect</FONT>
<FONT COLOR="#000000">	  Pin Default 0x5997e0f0: [N/A] Aux at Int ATAPI</FONT>
<FONT COLOR="#000000">	    Conn = Analog, Color = White</FONT>
<FONT COLOR="#000000">	  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">	Node 0x22 [Pin Complex] wcaps 0x400001: Stereo</FONT>
<FONT COLOR="#000000">	  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">	  Pin Default 0x593310f0: [N/A] CD at Int ATAPI</FONT>
<FONT COLOR="#000000">	    Conn = ATAPI, Color = Black</FONT>
<FONT COLOR="#000000">	  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">	Node 0x23 [Pin Complex] wcaps 0x400000: Mono</FONT>
<FONT COLOR="#000000">	  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">	  Pin Default 0x59b770f0: [N/A] Telephony at Int ATAPI</FONT>
<FONT COLOR="#000000">	    Conn = Analog, Color = Yellow</FONT>
<FONT COLOR="#000000">	  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">	Node 0x24 [Pin Complex] wcaps 0x400000: Mono</FONT>
<FONT COLOR="#000000">	  Pincap 0x0820: IN</FONT>
<FONT COLOR="#000000">	  Pin Default 0x51f710f0: [N/A] Other at Int Rear</FONT>
<FONT COLOR="#000000">	    Conn = Analog, Color = Black</FONT>
<FONT COLOR="#000000">	  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">	Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital</FONT>
<FONT COLOR="#000000">	  Pincap 0x0810: OUT</FONT>
<FONT COLOR="#000000">	  Pin Default 0x4145f0f0: [N/A] SPDIF Out at Ext Rear</FONT>
<FONT COLOR="#000000">	    Conn = Optical, Color = Other</FONT>
<FONT COLOR="#000000">	  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x02</FONT>
<FONT COLOR="#000000">	Node 0x26 [Power Widget] wcaps 0x500500: Mono</FONT>
<FONT COLOR="#000000">	  Power: 0x0</FONT>
<FONT COLOR="#000000">	  Connection: 8</FONT>
<FONT COLOR="#000000">	     0x07* 0x08 0x13 0x14 0x15 0x16 0x17 0x18</FONT>
<FONT COLOR="#000000">	Node 0x27 [Audio Mixer] wcaps 0x200101: Stereo</FONT>
<FONT COLOR="#000000">	  Connection: 2</FONT>
<FONT COLOR="#000000">	     0x1f 0x1d</FONT>
<FONT COLOR="#000000">	Node 0x28 [Audio Mixer] wcaps 0x200101: Stereo</FONT>
<FONT COLOR="#000000">	  Connection: 2</FONT>
<FONT COLOR="#000000">	     0x1f 0x20</FONT>
<FONT COLOR="#000000">	Node 0x29 [Audio Mixer] wcaps 0x200101: Stereo</FONT>
<FONT COLOR="#000000">	  Connection: 2</FONT>
<FONT COLOR="#000000">	     0x1d 0x20</FONT>
<FONT COLOR="#000000">	Node 0x2a [Audio Mixer] wcaps 0x200101: Stereo</FONT>
<FONT COLOR="#000000">	  Connection: 3</FONT>
<FONT COLOR="#000000">	     0x1f 0x1d 0x20</FONT>
<FONT COLOR="#000000">	Node 0x2b [Audio Mixer] wcaps 0x200100: Mono</FONT>
<FONT COLOR="#000000">	  Connection: 1</FONT>
<FONT COLOR="#000000">	     0x0f</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	====================================================== </FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	________________________________</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	From: Tobin Davis [mailto:<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>] </FONT>
<FONT COLOR="#000000">	Sent: Tuesday, December 05, 2006 7:26 AM</FONT>
<FONT COLOR="#000000">	To: Allyn, Mark A</FONT>
<FONT COLOR="#000000">	Cc: <A HREF="mailto:alsa-devel@lists.sourceforge.net">alsa-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000">	Subject: Re: [Alsa-devel] Samsung Audio Problem (update)</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	Could you send a couple of things to the mailing list?</FONT>
<FONT COLOR="#000000">Specifically,</FONT>
<FONT COLOR="#000000">	recompile the driver with &quot;--with-debug=detect&quot;, reinstall it,</FONT>
<FONT COLOR="#000000">and send</FONT>
<FONT COLOR="#000000">	the output from dmesg after installing the driver.  Also, send</FONT>
<FONT COLOR="#000000">the</FONT>
<FONT COLOR="#000000">	output from 'cat /proc/asound/card0/codec*'.</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	I have a laptop (Asus Z62F) with the exact same codec,   and I</FONT>
<FONT COLOR="#000000">had to do</FONT>
<FONT COLOR="#000000">	some fiddling with the alsamixer controls before I could use</FONT>
<FONT COLOR="#000000">either the</FONT>
<FONT COLOR="#000000">	internal mic or the external mic.  You might also check that.</FONT>
<FONT COLOR="#000000">The mic</FONT>
<FONT COLOR="#000000">	gain is listed as an output for some reason (it's been marked as</FONT>
<FONT COLOR="#000000">&quot;fixme&quot;</FONT>
<FONT COLOR="#000000">	in the code for quite some time).</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	Tobin</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	On Mon, 2006-12-04 at 13:43 -0800, Allyn, Mark A wrote: </FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">		Hello:</FONT>
<FONT COLOR="#000000">		 </FONT>
<FONT COLOR="#000000">		With thanks to Tobin Davis, I was able to resolve part</FONT>
<FONT COLOR="#000000">of my</FONT>
<FONT COLOR="#000000">	problem.</FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">		With using the latest snapshot of the alsa driver as</FONT>
<FONT COLOR="#000000">well as</FONT>
<FONT COLOR="#000000">	adding</FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">		options snd-hda-intel model=laptop-eapd</FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">		to the /etc/modprobe.conf file, I was able to get rid of</FONT>
<FONT COLOR="#000000">the</FONT>
<FONT COLOR="#000000">	high</FONT>
<FONT COLOR="#000000">		pitched</FONT>
<FONT COLOR="#000000">		squeal and have proper audio playback on the internal</FONT>
<FONT COLOR="#000000">speakers.</FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">		I am still unable to record. For your benefit, I do have</FONT>
<FONT COLOR="#000000">some</FONT>
<FONT COLOR="#000000">	more</FONT>
<FONT COLOR="#000000">		Information on the audio device. From the lspci -qn, I</FONT>
<FONT COLOR="#000000">got:</FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">		Class: 0403</FONT>
<FONT COLOR="#000000">		8086:2668	rev03</FONT>
<FONT COLOR="#000000">		Subsystem: 144D:C027</FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">		Has anyone got audio recording working on this codec and</FONT>
<FONT COLOR="#000000">	subsystem?</FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">		Thank you</FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">		Mark Allyn</FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">	-</FONT>
<FONT COLOR="#000000">		Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">		Join SourceForge.net's Techsay panel and you'll get the</FONT>
<FONT COLOR="#000000">chance</FONT>
<FONT COLOR="#000000">	to share your</FONT>
<FONT COLOR="#000000">		opinions on IT &amp; business topics through brief surveys -</FONT>
<FONT COLOR="#000000">and</FONT>
<FONT COLOR="#000000">	earn cash</FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000"><A HREF="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDE">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDE</A></FONT>
<FONT COLOR="#000000">	V</FONT>
<FONT COLOR="#000000">		_______________________________________________</FONT>
<FONT COLOR="#000000">		Alsa-devel mailing list</FONT>
<FONT COLOR="#000000">		<A HREF="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</A></FONT>
<FONT COLOR="#000000">		<A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</A></FONT>
<FONT COLOR="#000000">		</FONT>
<FONT COLOR="#000000">	</FONT>
<FONT COLOR="#000000">	</FONT>

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

--=-gq9hpV6nf0DyhIkvRxdP--



--===============0841368967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0841368967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0841368967==--

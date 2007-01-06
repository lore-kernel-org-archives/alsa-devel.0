From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: hda-intel on HP dv2000 (dv2130ea) (CXT5047)
Date: Fri, 05 Jan 2007 18:26:12 -0800
Message-ID: <1168050372.5835.3.camel@localhost>
References: <20070105235244.08aceb43.list@rebi.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0812670370=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20070105235244.08aceb43.list@rebi.no>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Robert Emil Berge <list@rebi.no>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0812670370==
Content-Type: multipart/alternative; boundary="=-bxu19aih9M+7xQZdv+iX"


--=-bxu19aih9M+7xQZdv+iX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Message came through both times (you won't get it unless you get the
digest version of alsa-dev email).

I'll be working on this codec some more next week.  As to the recording,
only 48khz is supported by the codec (note the PCM rates in the codec
output).

Tobin

On Fri, 2007-01-05 at 23:52 +0100, Robert Emil Berge wrote:

> (I'm sorry if this comes twice, I sent it earlier today, but it hasn't appeard for me yet.)
> 
> I've tested the latest version of the hda-intel driver for this laptop. Sound works well through the speakers. The headphone plug still doesn't mute the external speakers. The Master control can only change the volume in the headphones, while the PCM changes both external and headphone volume.
> I've noticed that in some programs the sound is much loader than in others with the same mixer settings. I think the ones using oss are less loud than the ones using alsa.
> I tried to load the module with model=test, but I didn't notice any change.
> I haven't tried recording a lot yet, and only on an older version of the driver, I think. At least then I couldn't record with 44100Hz, but 48000Hz worked.
> 
> Here's the info on my laptop:
> 
> HP Pavilion dv2000 (dv2130ea)
> 
> Subsystem: 103c:30b2
> 
> Codec: Conexant CXT5047
> Address: 0
> Vendor Id: 0x14f15047
> Subsystem Id: 0x103c30b2
> Revision Id: 0x100000
> Default PCM:
>     rates [0x40]: 48000
>     bits [0x2]: 16
>     formats [0x1]: PCM
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> Node 0x10 [Audio Output] wcaps 0x41d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   PCM:
>     rates [0x40]: 48000
>     bits [0x2]: 16
>     formats [0x1]: PCM
>   Power: 0x0
> Node 0x11 [Audio Output] wcaps 0x611: Stereo Digital
>   PCM:
>     rates [0x40]: 48000
>     bits [0x2]: 16
>     formats [0x1]: PCM
>   Power: 0x0
> Node 0x12 [Audio Input] wcaps 0x100d1b: Stereo Amp-In
>   Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1
>   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
>   PCM:
>     rates [0x40]: 48000
>     bits [0x2]: 16
>     formats [0x1]: PCM
>   Power: 0x0
>   Connection: 6
>      0x19 0x14 0x15 0x1a* 0x16 0x10
> Node 0x13 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x1f 0x1f]
>   Pincap 0x081001c: OUT HP EAPD Detect
>   Pin Default 0x0221101f: [Jack] HP Out at Ext Front
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x40: OUT
>   Power: 0x0
>   Connection: 3
>      0x19* 0x10 0x16
> Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x1f 0x1f]
>   Pincap 0x0833c: IN OUT HP Detect
>   Pin Default 0x02a1102e: [Jack] Mic at Ext Front
>     Conn = 1/8, Color = Black
>   Pin-ctls: 0x20: IN
>   Power: 0x0
>   Connection: 2
>      0x19* 0x16
> Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x1f 0x1f]
>   Pincap 0x0833c: IN OUT HP Detect
>   Pin Default 0x40000180: [N/A] Line Out at Ext N/A
>     Conn = Unknown, Color = Unknown
>   Pin-ctls: 0x21: IN
>   Power: 0x0
>   Connection: 3
>      0x1c 0x19* 0x16
> Node 0x16 [Pin Complex] wcaps 0x400401: Stereo
>   Pincap 0x0860: IN
>   Pin Default 0x94330121: [Fixed] CD at Int Right
>     Conn = ATAPI, Color = Unknown
>   Pin-ctls: 0x20: IN
>   Power: 0x0
> Node 0x17 [Pin Complex] wcaps 0x400481: Stereo
>   Pincap 0x08324: IN Detect
>   Pin Default 0x95a70122: [Fixed] Mic at Int Top
>     Conn = Analog, Color = Unknown
>   Pin-ctls: 0x21: IN
>   Power: 0x0
> Node 0x18 [Pin Complex] wcaps 0x400701: Stereo Digital
>   Pincap 0x0810: OUT
>   Pin Default 0x04440131: [Jack] SPDIF Out at Ext Right
>     Conn = RCA, Color = Unknown
>   Pin-ctls: 0x00:
>   Power: 0x0
>   Connection: 1
>      0x11
> Node 0x19 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
>   Amp-In caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-In vals:  [0x17 0x17] [0x80 0x80] [0x80 0x80] [0x17 0x17]
>   Power: 0x0
>   Connection: 4
>      0x10 0x1b 0x1a 0x16
> Node 0x1a [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x1f, mute=0
>   Amp-Out vals:  [0x03 0x03]
>   Power: 0x0
>   Connection: 3
>      0x15 0x14 0x17
> Node 0x1b [Audio Selector] wcaps 0x300501: Stereo
>   Power: 0x0
>   Connection: 2
>      0x14* 0x15
> Node 0x1c [Audio Output] wcaps 0x41d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x80 0x80]
>   PCM:
>     rates [0x40]: 48000
>     bits [0x2]: 16
>     formats [0x1]: PCM
>   Power: 0x0
> Node 0x1d [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
>   Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1
>   Amp-Out vals:  [0x1f 0x1f]
>   Pincap 0x08314: OUT Detect
>   Pin Default 0x92170110: [Fixed] Speaker at Int Front
>     Conn = Analog, Color = Unknown
>   Pin-ctls: 0x40: OUT
>   Power: 0x0
>   Connection: 3
>      0x1c 0x19* 0x16
> Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-bxu19aih9M+7xQZdv+iX
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
Message came through both times (you won't get it unless you get the digest version of alsa-dev email).<BR>
<BR>
I'll be working on this codec some more next week.&nbsp; As to the recording, only 48khz is supported by the codec (note the PCM rates in the codec output).<BR>
<BR>
Tobin<BR>
<BR>
On Fri, 2007-01-05 at 23:52 +0100, Robert Emil Berge wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">(I'm sorry if this comes twice, I sent it earlier today, but it hasn't appeard for me yet.)</FONT>

<FONT COLOR="#000000">I've tested the latest version of the hda-intel driver for this laptop. Sound works well through the speakers. The headphone plug still doesn't mute the external speakers. The Master control can only change the volume in the headphones, while the PCM changes both external and headphone volume.</FONT>
<FONT COLOR="#000000">I've noticed that in some programs the sound is much loader than in others with the same mixer settings. I think the ones using oss are less loud than the ones using alsa.</FONT>
<FONT COLOR="#000000">I tried to load the module with model=test, but I didn't notice any change.</FONT>
<FONT COLOR="#000000">I haven't tried recording a lot yet, and only on an older version of the driver, I think. At least then I couldn't record with 44100Hz, but 48000Hz worked.</FONT>

<FONT COLOR="#000000">Here's the info on my laptop:</FONT>

<FONT COLOR="#000000">HP Pavilion dv2000 (dv2130ea)</FONT>

<FONT COLOR="#000000">Subsystem: 103c:30b2</FONT>

<FONT COLOR="#000000">Codec: Conexant CXT5047</FONT>
<FONT COLOR="#000000">Address: 0</FONT>
<FONT COLOR="#000000">Vendor Id: 0x14f15047</FONT>
<FONT COLOR="#000000">Subsystem Id: 0x103c30b2</FONT>
<FONT COLOR="#000000">Revision Id: 0x100000</FONT>
<FONT COLOR="#000000">Default PCM:</FONT>
<FONT COLOR="#000000">    rates [0x40]: 48000</FONT>
<FONT COLOR="#000000">    bits [0x2]: 16</FONT>
<FONT COLOR="#000000">    formats [0x1]: PCM</FONT>
<FONT COLOR="#000000">Default Amp-In caps: N/A</FONT>
<FONT COLOR="#000000">Default Amp-Out caps: N/A</FONT>
<FONT COLOR="#000000">Node 0x10 [Audio Output] wcaps 0x41d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  PCM:</FONT>
<FONT COLOR="#000000">    rates [0x40]: 48000</FONT>
<FONT COLOR="#000000">    bits [0x2]: 16</FONT>
<FONT COLOR="#000000">    formats [0x1]: PCM</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">Node 0x11 [Audio Output] wcaps 0x611: Stereo Digital</FONT>
<FONT COLOR="#000000">  PCM:</FONT>
<FONT COLOR="#000000">    rates [0x40]: 48000</FONT>
<FONT COLOR="#000000">    bits [0x2]: 16</FONT>
<FONT COLOR="#000000">    formats [0x1]: PCM</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">Node 0x12 [Audio Input] wcaps 0x100d1b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]</FONT>
<FONT COLOR="#000000">  PCM:</FONT>
<FONT COLOR="#000000">    rates [0x40]: 48000</FONT>
<FONT COLOR="#000000">    bits [0x2]: 16</FONT>
<FONT COLOR="#000000">    formats [0x1]: PCM</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">  Connection: 6</FONT>
<FONT COLOR="#000000">     0x19 0x14 0x15 0x1a* 0x16 0x10</FONT>
<FONT COLOR="#000000">Node 0x13 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x1f 0x1f]</FONT>
<FONT COLOR="#000000">  Pincap 0x081001c: OUT HP EAPD Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x0221101f: [Jack] HP Out at Ext Front</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">  Connection: 3</FONT>
<FONT COLOR="#000000">     0x19* 0x10 0x16</FONT>
<FONT COLOR="#000000">Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x1f 0x1f]</FONT>
<FONT COLOR="#000000">  Pincap 0x0833c: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x02a1102e: [Jack] Mic at Ext Front</FONT>
<FONT COLOR="#000000">    Conn = 1/8, Color = Black</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x19* 0x16</FONT>
<FONT COLOR="#000000">Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x1f 0x1f]</FONT>
<FONT COLOR="#000000">  Pincap 0x0833c: IN OUT HP Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x40000180: [N/A] Line Out at Ext N/A</FONT>
<FONT COLOR="#000000">    Conn = Unknown, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x21: IN</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">  Connection: 3</FONT>
<FONT COLOR="#000000">     0x1c 0x19* 0x16</FONT>
<FONT COLOR="#000000">Node 0x16 [Pin Complex] wcaps 0x400401: Stereo</FONT>
<FONT COLOR="#000000">  Pincap 0x0860: IN</FONT>
<FONT COLOR="#000000">  Pin Default 0x94330121: [Fixed] CD at Int Right</FONT>
<FONT COLOR="#000000">    Conn = ATAPI, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x20: IN</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">Node 0x17 [Pin Complex] wcaps 0x400481: Stereo</FONT>
<FONT COLOR="#000000">  Pincap 0x08324: IN Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x95a70122: [Fixed] Mic at Int Top</FONT>
<FONT COLOR="#000000">    Conn = Analog, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x21: IN</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">Node 0x18 [Pin Complex] wcaps 0x400701: Stereo Digital</FONT>
<FONT COLOR="#000000">  Pincap 0x0810: OUT</FONT>
<FONT COLOR="#000000">  Pin Default 0x04440131: [Jack] SPDIF Out at Ext Right</FONT>
<FONT COLOR="#000000">    Conn = RCA, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x00:</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">  Connection: 1</FONT>
<FONT COLOR="#000000">     0x11</FONT>
<FONT COLOR="#000000">Node 0x19 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In</FONT>
<FONT COLOR="#000000">  Amp-In caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-In vals:  [0x17 0x17] [0x80 0x80] [0x80 0x80] [0x17 0x17]</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">  Connection: 4</FONT>
<FONT COLOR="#000000">     0x10 0x1b 0x1a 0x16</FONT>
<FONT COLOR="#000000">Node 0x1a [Audio Selector] wcaps 0x30050d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x1f, mute=0</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x03 0x03]</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">  Connection: 3</FONT>
<FONT COLOR="#000000">     0x15 0x14 0x17</FONT>
<FONT COLOR="#000000">Node 0x1b [Audio Selector] wcaps 0x300501: Stereo</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">  Connection: 2</FONT>
<FONT COLOR="#000000">     0x14* 0x15</FONT>
<FONT COLOR="#000000">Node 0x1c [Audio Output] wcaps 0x41d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x17, nsteps=0x1e, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x80 0x80]</FONT>
<FONT COLOR="#000000">  PCM:</FONT>
<FONT COLOR="#000000">    rates [0x40]: 48000</FONT>
<FONT COLOR="#000000">    bits [0x2]: 16</FONT>
<FONT COLOR="#000000">    formats [0x1]: PCM</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">Node 0x1d [Pin Complex] wcaps 0x40058d: Stereo Amp-Out</FONT>
<FONT COLOR="#000000">  Amp-Out caps: ofs=0x1f, nsteps=0x1e, stepsize=0x05, mute=1</FONT>
<FONT COLOR="#000000">  Amp-Out vals:  [0x1f 0x1f]</FONT>
<FONT COLOR="#000000">  Pincap 0x08314: OUT Detect</FONT>
<FONT COLOR="#000000">  Pin Default 0x92170110: [Fixed] Speaker at Int Front</FONT>
<FONT COLOR="#000000">    Conn = Analog, Color = Unknown</FONT>
<FONT COLOR="#000000">  Pin-ctls: 0x40: OUT</FONT>
<FONT COLOR="#000000">  Power: 0x0</FONT>
<FONT COLOR="#000000">  Connection: 3</FONT>
<FONT COLOR="#000000">     0x1c 0x19* 0x16</FONT>
<FONT COLOR="#000000">Node 0x1e [Vendor Defined Widget] wcaps 0xf00000: Mono</FONT>


<FONT COLOR="#000000">-------------------------------------------------------------------------</FONT>
<FONT COLOR="#000000">Take Surveys. Earn Cash. Influence the Future of IT</FONT>
<FONT COLOR="#000000">Join SourceForge.net's Techsay panel and you'll get the chance to share your</FONT>
<FONT COLOR="#000000">opinions on IT &amp; business topics through brief surveys - and earn cash</FONT>
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

--=-bxu19aih9M+7xQZdv+iX--



--===============0812670370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0812670370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0812670370==--

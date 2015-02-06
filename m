From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [Intel HDA][ALC3226] Too much white noise from
	microphone
Date: Fri, 06 Feb 2015 10:22:44 -0500
Message-ID: <3516931.ENm5BxjSkv@segfault>
References: <8841801.KiuVFG1hDJ@segfault> <54D4A9F9.6090709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm13-vm5.access.bullet.mail.bf1.yahoo.com
 (nm13-vm5.access.bullet.mail.bf1.yahoo.com [216.109.115.5])
 by alsa0.perex.cz (Postfix) with ESMTP id A94FE2605E8
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 16:22:52 +0100 (CET)
In-Reply-To: <54D4A9F9.6090709@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Friday, February 06, 2015 04:48:09 PM Alexander E. Patrakov wrote:
> 05.02.2015 02:13, Shawn Starr wrote:
> > Hello ALSA devs,
> > 
> > I spoke to patrakov on Freenode from the #Alsa IRC channel and they
> > mentioned that the noise background I am experiencing is not normal. I
> > tried two different headsets, both headsets have two separate jacks, the
> > same result.
> > 
> > I will test any patches/quirks for kernel as needed.
> > 
> > Here is the alsa-info:
> > 
> > http://www.alsa-project.org/db/?f=29d3c45e2d66c58be03a10bd0186067a9d735a11
> 
> I am not an expert on Intel HDA cards, but... some microphones are picky
> about the reference voltage supplied by the soundcard. You can change
> this temporarily, for debugging purposes, with hda-analyzer. See general
> instructions at
> 
> http://www.alsa-project.org/main/index.php/HDA_Analyzer
> 
> Note: it needs the "snd-hwdep" module loaded, and needs to be run as root.
> 
> In your case, you need to select Node[0x18] PIN in the left pane, and,
> at the bottom of the right pane, select 50 or 100 instead of 80 in the
> VREF box. See https://imgur.com/F84raSN for a screenshot based on your
> alsa-info.
> 
> If this doesn't help, just click around randomly. Maybe you'll find the
> magic checkbox that makes the noise go away and the voice stay :) - if
> that happens, please email the resulting diff file that hda-analyzer
> creates.

Hello Alexander,

Indeed, adjusting VREF to 50 cuts the background noise noticeably, it's still 
there but it is lesser.

Resulting 10 second audio with difference: http://turl.ca/accwc 
Old audio: http://turl.ca/zrhbcs

Both using same Logitech headset for test.

Thanks,
Shawn


-- CUT --

Diff for codec 1/0 (0x10ec0292):
--- 
+++ 
@@ -189,27 +189,27 @@
   Unsolicited: tag=0x02, enabled=1
   Power: setting=D0, actual=D0
   Connection: 2
      0x0c* 0x0d
 Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
 Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
   Control: name="Front Mic Boost Volume", index=0, device=0
     ControlAmp: chs=3, dir=1, idx=0, ofs=0
-  Control: name="Front Mic Jack", index=0, device=0
+  Control: iface="card", name="Front Mic Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals: [0x01 0x01]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals: [0x80 0x80]
   Pincap 0x00003734: IN OUT Detect
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x02a19031: [Jack] Mic at Ext Front
     Conn = 1/8, Color = Pink
     DefAssociation = 0x3, Sequence = 0x1
-  Pin-ctls: 0x24: IN VREF_80
+  Pin-ctls: 0x21: IN VREF_50
   Unsolicited: tag=0x03, enabled=1
   Power: setting=D0, actual=D0
   Connection: 2
      0x0c* 0x0d
 Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
   Control: name="Dock Mic Boost Volume", index=0, device=0
     ControlAmp: chs=3, dir=1, idx=0, ofs=0
   Control: name="Dock Mic Jack", index=0, device=

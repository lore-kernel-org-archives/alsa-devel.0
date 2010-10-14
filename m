From: Tom Burger <tvburger@gmail.com>
Subject: HDA Analyzer - Dell M4500 Internal Mic
Date: Fri, 15 Oct 2010 01:31:04 +0200
Message-ID: <AANLkTi=s3+gk_PKBYdad8YZv065fJukUGDZ1c2RmL8ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id BD0761037F5
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 02:01:57 +0200 (CEST)
Received: by qyk8 with SMTP id 8so648754qyk.17
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2010 17:01:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all!

My mic didn't work (Dell M4500) . Using HDA Analyzer I create a
configuration that does work. I read that I could send my working
codec to here. So here it is.

Maybe you can also tell me how te make this change permanent?

Good luck,

Tom



Diff for codec 0/0 (0x111d76d5):
---
+++
@@ -100,16 +100,17 @@
 Node 0x11 [Pin Complex] wcaps 0x400483: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals: [0x00 0x00]
   Pincap 0x00000024: IN Detect
   Pin Default 0x90a60130: [Fixed] Mic at Int N/A
     Conn = Digital, Color = Unknown
     DefAssociation = 0x3, Sequence = 0x0
     Misc = NO_PRESENCE
+  Pin-ctls: 0x20: IN
   Unsolicited: tag=0x00, enabled=0
   Power: setting=D0, actual=D0
 Node 0x12 [Vendor Defined Widget] wcaps 0xf00503: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals: [0x00 0x00]
   Power: setting=D0, actual=D0
   Connection: 1
      0x20
@@ -121,37 +122,37 @@
   Delay: 13 samples
 Node 0x14 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
   Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
   Amp-Out vals: [0x79 0x79]
   Converter: stream=0, channel=0
   Power: setting=D0, actual=D0
   Delay: 13 samples
 Node 0x15 [Audio Input] wcaps 0x1d0541: Stereo
-  Converter: stream=0, channel=0
+  Converter: stream=1, channel=0
   SDI-Select: 0
   Power: setting=D0, actual=D0
   Delay: 13 samples
   Connection: 1
      0x17
   Processing caps: benign=0, ncoeff=0
 Node 0x16 [Audio Input] wcaps 0x1d0541: Stereo
   Converter: stream=0, channel=0
   SDI-Select: 0
   Power: setting=D0, actual=D0
   Delay: 13 samples
   Connection: 1
      0x18
   Processing caps: benign=0, ncoeff=0
 Node 0x17 [Audio Selector] wcaps 0x300d0d: Stereo Amp-Out R/L
   Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
-  Amp-Out vals: [0x0f 0x0f]
+  Amp-Out vals: [0x00 0x00]
   Power: setting=D0, actual=D0
   Connection: 7
-     0x0c 0x0e 0x0f 0x1b 0x11 0x12 0x0a*
+     0x0c 0x0e 0x0f 0x1b 0x11* 0x12 0x0a
 Node 0x18 [Audio Selector] wcaps 0x300d0d: Stereo Amp-Out R/L
   Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
   Amp-Out vals: [0x80 0x80]
   Power: setting=D0, actual=D0
   Connection: 7
      0x0c 0x0e 0x0f 0x1b 0x11 0x12 0x0a*
 Node 0x19 [Audio Selector] wcaps 0x300501: Stereo
   Power: setting=D0, actual=D

-- 
Tom Burger | tvburger@gmail.com | +31 (0)62 412 20 27
http://www.linkedin.com/in/tvburger

From: David Favor <david@davidfavor.com>
Subject: Re: No Sound - X-Fi CA0110 IBG - Ubuntu 910 with
 Kernel 2.6.31-6
Date: Sun, 23 Aug 2009 22:42:21 -0500
Message-ID: <4A920C1D.7070403@davidfavor.com>
References: <4A9168F8.4070102@davidfavor.com>
	<604760770908231609j6c7245d5vc56e1ba259b9e7d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp105.sbc.mail.mud.yahoo.com (smtp105.sbc.mail.mud.yahoo.com
	[68.142.198.204]) by alsa0.perex.cz (Postfix) with SMTP id E3FD2244A0
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 05:42:24 +0200 (CEST)
In-Reply-To: <604760770908231609j6c7245d5vc56e1ba259b9e7d3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Daniel Chen wrote:
> On Sun, Aug 23, 2009 at 12:06 PM, David Favor<david@davidfavor.com> wrote:
>> 2.6.31-6-generic
> ...
>> Codec: Creative CA0110-IBG
>> Address: 1
>> Function Id: 0x1
>> Vendor Id: 0x1102000a
>> Subsystem Id: 0x11021007
>> Revision Id: 0x100000
> 
> Please try the latest alsa-driver stable snapshot.

Looks like something is flaky in how status bits are cleared/read
from the hardware by the driver code.

Definitely time to move on to a card with a working driver.

If I continually reboot my system, say 30-50 times or unplug power
from the wall I get the following, which I'm guessing is suppose to
show up always...

david@home1:~/shell$ ls -ld /proc/asound/card*/codec*
-r--r--r-- 1 root root 0 2009-08-23 22:34 /proc/asound/card0/codec#1

david@home1:~/shell$ cat /proc/asound/card0/codec#1
Codec: Creative CA0110-IBG
Address: 1
Function Id: 0x1
Vendor Id: 0x1102000a
Subsystem Id: 0x11021007
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xa]: 16 24
     formats [0x1]: PCM
Default Amp-In caps: ofs=0x67, nsteps=0x73, stepsize=0x01, mute=0
Default Amp-Out caps: ofs=0x67, nsteps=0x67, stepsize=0x01, mute=0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x5: Stereo Amp-Out
   Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
   Amp-Out vals:  [0x00 0x00]
   Converter: stream=4, channel=0
Node 0x03 [Audio Output] wcaps 0x5: Stereo Amp-Out
   Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
   Amp-Out vals:  [0x00 0x00]
   Converter: stream=4, channel=0
Node 0x04 [Audio Output] wcaps 0x5: Stereo Amp-Out
   Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
   Amp-Out vals:  [0x00 0x00]
   Converter: stream=4, channel=0
Node 0x05 [Audio Output] wcaps 0x5: Stereo Amp-Out
   Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
   Amp-Out vals:  [0x00 0x00]
   Converter: stream=4, channel=0
Node 0x06 [Audio Output] wcaps 0x5: Stereo Amp-Out
   Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
   Amp-Out vals:  [0x67 0x67]
   Converter: stream=4, channel=0
Node 0x07 [Audio Output] wcaps 0x205: Stereo Digital Amp-Out
   Amp-Out caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
   Amp-Out vals:  [0x00 0x00]
   Converter: stream=0, channel=0
   Digital: Enabled Non-Audio Pro
   Digital category: 0x0
Node 0x08 [Audio Input] wcaps 0x100103: Stereo Amp-In
   Amp-In caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
   Amp-In vals:  [0x00 0x00]
   Converter: stream=0, channel=0
   SDI-Select: 1
   Connection: 1
      0x10
Node 0x09 [Audio Input] wcaps 0x10010b: Stereo Amp-In
   Amp-In caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
   Amp-In vals:  [0x01 0x01]
   Converter: stream=0, channel=0
   SDI-Select: 1
   Connection: 1
      0x11
Node 0x0a [Audio Input] wcaps 0x100303: Stereo Digital Amp-In
   Amp-In caps: ofs=0x67, nsteps=0x7f, stepsize=0x01, mute=0
   Amp-In vals:  [0x00 0x00]
   Converter: stream=0, channel=0
   SDI-Select: 1
   Digital: Enabled Non-Audio Pro GenLevel
   Digital category: 0x7f
   Connection: 1
      0x13
Node 0x0b [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x00000014: OUT Detect
   Pin Default 0x01014010: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Green
     DefAssociation = 0x1, Sequence = 0x0
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x02
Node 0x0c [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x00]
   Pincap 0x00000014: OUT Detect
   Pin Default 0x01016011: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Orange
     DefAssociation = 0x1, Sequence = 0x1
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x03
Node 0x0d [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x00000014: OUT Detect
   Pin Default 0x01011012: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0x1, Sequence = 0x2
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x04
Node 0x0e [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x00000014: OUT Detect
   Pin Default 0x01012014: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Grey
     DefAssociation = 0x1, Sequence = 0x4
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x05
Node 0x0f [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000001c: OUT HP Detect
   Pin Default 0x02214020: [Jack] HP Out at Ext Front
     Conn = 1/8, Color = Green
     DefAssociation = 0x2, Sequence = 0x0
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x06
Node 0x10 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x80 0x80]
   Pincap 0x00000024: IN Detect
   Pin Default 0x01813030: [Jack] Line In at Ext Rear
     Conn = 1/8, Color = Blue
     DefAssociation = 0x3, Sequence = 0x0
   Pin-ctls: 0x24: IN
   Unsolicited: tag=00, enabled=0
Node 0x11 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x80 0x80]
   Pincap 0x00000024: IN Detect
   Pin Default 0x02a19040: [Jack] Mic at Ext Front
     Conn = 1/8, Color = Pink
     DefAssociation = 0x4, Sequence = 0x0
   Pin-ctls: 0x24: IN
   Unsolicited: tag=00, enabled=0
Node 0x12 [Pin Complex] wcaps 0x40038d: Stereo Digital Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x00000010: OUT
   Pin Default 0x01452150: [Jack] SPDIF Out at Ext Rear
     Conn = Optical, Color = Grey
     DefAssociation = 0x5, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x07
Node 0x13 [Pin Complex] wcaps 0x40028b: Stereo Digital Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00]
   Pincap 0x00000020: IN
   Pin Default 0x01c51160: [Jack] SPDIF In at Ext Rear
     Conn = Optical, Color = Black
     DefAssociation = 0x6, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x24: IN
   Unsolicited: tag=00, enabled=0
Node 0x14 [Vendor Defined Widget] wcaps 0xf00080: Mono
   Unsolicited: tag=00, enabled=0




-- 
Love feeling your best ever, all day, every day?
Click http://RadicalHealth.com for the easy way.

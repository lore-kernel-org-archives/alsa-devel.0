From: "Daniel J Blueman" <daniel.blueman@gmail.com>
Subject: Re: [HDA Intel/STAC92xx] mic not working
	(retasking?)...
Date: Wed, 4 Jul 2007 00:12:46 +0100
Message-ID: <6278d2220707031612i1c129969ga9c0d5d77b7c73db@mail.gmail.com>
References: <6278d2220706271328u79afd988r44cc1fbfc41c6014@mail.gmail.com>
	<s5hved6z75l.wl%tiwai@suse.de>
	<6278d2220706301407p739ebfb5i52d4a2af3a17ecd8@mail.gmail.com>
	<s5habuec264.wl%tiwai@suse.de>
	<6278d2220707021539g1485af71v3cbb639f0844b271@mail.gmail.com>
	<s5h3b057u8d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id BEB6F103879
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 01:12:47 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so189793ugf
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2007 16:12:47 -0700 (PDT)
In-Reply-To: <s5h3b057u8d.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/07/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 2 Jul 2007 23:39:14 +0100,
> Daniel J Blueman wrote:
> > > > > > With both 2.6.20 and 2.6.22 kernels on Ubuntu 7.04 on my Sony Vaio
> > > > > > SZ240, I'm unable to get my mic connector working at any cost.
> > > > >
> > > > > First, show the contents of /proc/asound/card0/codec#* files...
[snip]
> > I have discovered the bug preventing me using the external mic socket
> > before: in the mixer, the user has to select the [internal] mic input,
> > then re-select the line-in (actually external mic) input; reading from
> > (eg) /dev/dsp while changing this, the output suddenly is as expected
> > when the line-in is re-selected.
>
> Could you elaborate?  What do yo mean "output" here, and what did you
> expect?

Looking at what is printed from the command 'cat /dev/dsp', what is
shown changes when I de-select 'line-in' and then reselect it. Let me
know if you're still unclear.

> > Since we've got started, where should I look for the 'before' and
> > 'after' state to compare to see into this?
>
> Yes, comparing the codec dump file would be helpful.

Changing from the initial mixer state of 'Line-in' being selected to
'Microphone' does not change anything in the
/proc/asound/card0/codec#{0,1} files. After, changing the input back
to 'Line-in' does show a change [1] (which we'd expect).

My interpretation of this is that (in the initial state) the STAC
registers are set to record from the internal mic (which doesn't
actually exist; there is a tiny amount of crosstalk) and the mixer
settings ALSA reports show the line-in/external mic selected [2].

I've been looking at patch_stac9872() and it does seem the
CXD9872RD_VAIO path is being taken [3]. I'll enable the debug
messages; perhaps the BIOS is storing some bad defaults?

Where can you suggest to look, or what to check?

Thanks again,
  Daniel

--- [1]

--- codec0-before        2007-07-03 19:10:13.000000000 +0100
+++ codec0-after 2007-07-03 19:10:32.000000000 +0100
@@ -118,7 +118,7 @@
Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=1
   Amp-Out vals:  [0x00 0x00]
   Connection: 4
-     0x0a 0x0d 0x14* 0x02
+     0x0a 0x0d* 0x14 0x02
 Node 0x16 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
   Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
   Amp-Out vals:  [0x00]

--- [2]

$ amixer scontents
[snip]
Simple mixer control 'Line',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [on]
Simple mixer control 'Mic',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
[snip]

--- [3]

$ lspci -vvns 00:1b.0
00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 104d:81e6
...
-- 
Daniel J Blueman

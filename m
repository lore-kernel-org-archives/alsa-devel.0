From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: HDA NIDs 0x25 & 0x26 on ALC883
Date: Tue, 15 Jan 2008 18:14:52 -0500
Message-ID: <76366b180801151514n60248020tdac0e37bef67494@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D9D124467
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 00:14:56 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so21942rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 15:14:52 -0800 (PST)
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
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi,

Do you know anything about NIDs 0x25 and 0x26 on the ALC883 chip? 0x25
is an Audio Output and 0x26 is an Audio Mixer. They appear completely
separate from the 0x0c-0x0f mixers, but when I map one of my pins to
use the 0x26 mixer, I hear audio over the jack whenever I play to the
standard 'Green' 0x0c mixer. The 0x26 mixer seems unused in the
current driver, so I'm not sure if there is something special about
it. I'm basically trying to use it as a 5th output.

Also, when I play audio, the 0x0c mixer has a nice full sound (the
"expected" sound). The 0x0d & 0x0e mixers have much less bass and
sound like someone turned up the treble. The 0x0f and 0x26 mixers have
an even more "tinny" sound. I've verified that all the mixers/pins are
configured the same exact way and all have full volume (0x1f). Do you
know of any reason why the audio output over the pins would differ?
I'm not sure what I could be missing here to get them to all sound the
same.

I appreciate any info you could provide.
Thanks,
-Andrew

This is my 0x26 / 0x25 config, mapped to pin 0x1a which I've
reconfigured as an output jack:

Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08173e: IN OUT HP Detect
  Pin Default 0x0181344f: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  EAPD: 0x0
  Pin-ctls: 0x40: OUT
  Connection: 5
     0x0c 0x0d 0x0e 0x0f 0x26*
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 2
     0x25 0x0b
Node 0x25 [Audio Output] wcaps 0x11: Stereo
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM

From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Headphone output problems with HP ProDesk 600 G1
	(Realtek ALC221)
Date: Tue, 18 Feb 2014 10:13:02 +0800
Message-ID: <CAN8cciabECOHSBC0N0WP1nb17+HsLRDD9xEUn8LcmuuBsVH+3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f180.google.com (mail-qc0-f180.google.com
 [209.85.216.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B81C2650BD
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 03:13:03 +0100 (CET)
Received: by mail-qc0-f180.google.com with SMTP id i17so24557530qcy.25
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 18:13:02 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: hancockrwd@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

>> I have a HP ProDesk 600 G1 machine which seems to have some strange
behavior with the front headphone jack(s) running under Fedora 20
(running 3.13.2 kernel):

>> This machine has two front jacks: a headphone jack and a
microphone/headphone jack. When the headphones are plugged into the
headphone jack, there's usually no change in the sound outputs list in
the Sound control panel. The audio (mostly) works if the audio output
device is set to Analog Output, but sometimes spuriously changes back
to Speakers and the headphone output stops working (I suspect maybe
from a spurious jack-sensing event, though I'm not certain). More
confusingly, a couple of times I have gotten it into the state
(through various fiddling with jacks and playing in the Sound control
panel) where plugging into this jack is detected and causes the
Headphone output to be selected in the control panel. I haven't been
able to figure out consistently what causes this to happen.

>> If the headphone is plugged into the microphone/headphone jack, then
the control panel consistently switches to the Headphone output and
consistently switches back the way it was when it's unplugged.
However, there's no actual audio output coming out of that jack. (From
some of the HP manuals, it sounds like with the Windows driver, when
you plug into this jack, it's supposed to pop up a prompt asking you
whether you want to use it as a microphone or headphones.)

>> The other strange thing is that intermittently, on the headphone jack
you'll start getting a bunch of loud static (clicking noises) and any
actual audio playback becomes very faint and distorted.

>> I'm guessing perhaps something isn't being initialized/setup properly
in the codec, causing this kind of erratic behavior. The alsa-info
output is uploaded at:
http://www.alsa-project.org/db/?f=594e837b7af07ffbe3473cf807465bc81a587880

>> I tried using hda-analyzer but it fails on this machine with:

>> ValueError: wrong proc file format (unknown dig1 bit 'KAE')

>> Any suggestions for things to try to debug this?


Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="PCM Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00010014: OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x01014020: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x2, Sequence = 0x0

it is a driver bug which assign PCM playback Switch to Line Out Jack

try the patch  https://bugzilla.kernel.org/attachment.cgi?id=124971


HP ProDesk 600 G1 SFF is an All-In-One pc , should headphone and line
out share the volume control if headphone can mute the line out or
speaker


Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Speaker Only' 'Line Out Speaker'
  Item0: 'Line Out Speaker'


Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Control: name="PCM Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC221 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x57 0x57]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM

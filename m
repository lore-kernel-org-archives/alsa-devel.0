From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v3 0/4] usb-audio: Add UAC3 Power Domains
Date: Tue, 31 Jul 2018 13:28:41 +0100
Message-ID: <20180731122845.4859-1-jorge.sanjuan@codethink.co.uk>
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is what's new in this v3:
 - Add proper SPDX identifier for new source file.
 - Add delay unit in comment for BADD inferred recovery
   times and specify the actual delay time for them.
 - Suspend the usb stream *after* alsa has supended its stuff.
 - Make sure Power State changes to D0 happen *before* stream
   format is set.
 - Try to set the Power State to D0 on .prepare callback too as
   recovery from suspend state doesn't need .hw_params call.

This patchset adds support for UAC3 Power Domains. This feature
of the USB audio class 3 allows the host to notify the device 
what it is making use of so power comsumption can be optimized.

This proposal implements this feature for Power Domains
that include an Input/Output Terminal associated to an
audio Streaming interface. This is the main usage of this
feature according to the spec. For that reason, the logic
for the Power Domain state change has been implemented
within the ALSA PCMs logic and the suspend/resume callbacks
of the usb_driver. The behaviour would be as follows:

* Power Domain State D0: A Power Domain will reach this state
  only when the audio substream associated to that domain is
  being used (i,e. Audio playback/capture is happening).
* Power Domain State D1: This is the Idle state where the driver
  is going to always want to be in order to reduce power
  consumption.
* Power Domain State D2: This state is only set when the usb driver
  asumes the device is not going to be used anymore and hence, it
  wont care about getting any interrupts from the device. This
  will only happen when power level is set to "auto" in sysfs
  so the usb driver gets suspended when the interfaces are not in use.
 
NOTE: The way this has been implemented will always try to put the 
Power Domain in state D1 if the Power Domain exists. The patch
"ALSA: usb-audio: Operate UAC3 Power Domains in PCM callbacks"
puts the logic for doing so inside the PCM's logic. Something to
improve on that is to also tie up those D1<->D0 state changes
to runtime PM maybe.


Jorge Sanjuan (4):
  ALSA: usb-audio: Initial Power Domain support
  ALSA: usb-audio: AudioStreaming Power Domain parsing
  ALSA: usb-audio: Add UAC3 Power Domains to suspend/resume
  ALSA: usb-audio: Operate UAC3 Power Domains in PCM callbacks

 include/linux/usb/audio-v3.h |   4 ++
 sound/usb/Makefile           |   1 +
 sound/usb/card.c             |   9 ++++
 sound/usb/card.h             |   2 +
 sound/usb/pcm.c              |  68 ++++++++++++++++++++++++++--
 sound/usb/pcm.h              |   2 +
 sound/usb/power.c            | 104 +++++++++++++++++++++++++++++++++++++++++++
 sound/usb/power.h            |  19 ++++++++
 sound/usb/stream.c           |  70 +++++++++++++++++++++++++----
 9 files changed, 268 insertions(+), 11 deletions(-)
 create mode 100644 sound/usb/power.c

-- 
2.11.0

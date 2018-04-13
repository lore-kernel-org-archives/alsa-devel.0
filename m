From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH 0/4] USB Audio Device Class 3.0 BADD profiles support
Date: Sat, 14 Apr 2018 01:24:22 +0300
Message-ID: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patchset adds BADD profiles support from the USB Audio
Device Class 3.0 spec [1].

BADD profile support is defined as mandatory feature of
UAC3-compliant device, it should be implemented as a separate
USB configuration.

Notable issue with BADD configuration is that it misses
class-specific descriptors (and it's mandatory as per spec),
so host should guess them from BADD profile number and
parameters of endpoints (type, number of endpoints and
max packet size)

This patchset adds support of all known/existing BADD profiles
from the UAC3 specification.

It's an alternative implementation comparing to [2],
and doesn't build usb descriptors on the host but instead
initializes alsa-usb structures with known parameters,
so we don't need to keep whole class-specific descriptors
in the driver since we anyway need to have BADD-specific
logic.

I've picked one Jorge's UAC1 patch-improvement and
updated it to v4.17 wich contais recently introduced
header's sanity checks.

Remaining part is to add interrupt endpoint support
so we will be able to detect jack insertion in
the Headset Adapter profile.

This has been tested on ARM and x86-64 machines with
custom UAC3 gadget which I'll post later to linux-usb

Comments and testing are welcome.

[1] http://www.usb.org/developers/docs/devclass_docs/USB_Audio_v3.0.zip
[2] https://www.spinics.net/lists/alsa-devel/msg71614.html

Jorge Sanjuan (1):
  ALSA: usb: Only get AudioControl header for UAC1 class.

Ruslan Bilovol (3):
  ALSA: usb: stream: refactor audio interface parsing
  include: usb: audio-v3: add BADD-specific values
  ALSA: usb: add UAC3 BADD profiles support

 include/linux/usb/audio-v3.h |  26 ++
 sound/usb/card.c             |  53 ++--
 sound/usb/clock.c            |   9 +-
 sound/usb/mixer.c            | 313 +++++++++++++++++++-
 sound/usb/mixer_maps.c       |  65 +++++
 sound/usb/stream.c           | 678 +++++++++++++++++++++++++------------------
 sound/usb/usbaudio.h         |   2 +
 7 files changed, 836 insertions(+), 310 deletions(-)

-- 
1.9.1

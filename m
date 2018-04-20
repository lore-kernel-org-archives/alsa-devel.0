From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH 0/4] ALSA: usb: UAC3 new features.
Date: Fri, 20 Apr 2018 18:03:23 +0100
Message-ID: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

Now that the UAC3 patch [1] has made it to linux-next I have some extra
features to make a UAC3 device fully work in Linux. Including Jack 
insertion control that I have put on top of this other patch [2] for 
UAC2. Also adding support for the UAC3 Mixer Unit which is most likely
to appear in most headset type devices.

UAC3 devices also require to have a Basic Audio Device (BADD) in a separate 
config for which both Ruslan Bilovol and myself have submited different 
approaches[3][4] but I don't know what the final merge will be. Once there 
is official support for BADD, we'll need to test it with an actual UAC3 
device to confirm it all wokrs.

All this features are tested with an actual UAC3 device that is still in
development. For this patch series, only the legacy config (#1. UAC1/UAC2)
and the UAC3 config have been tested. The BADD config is only tested using
and updated verison of [4].

[1]: https://patchwork.kernel.org/patch/10298179/
[2]: https://patchwork.kernel.org/patch/10305847/
[3]: https://patchwork.kernel.org/patch/10340851/
[4]: https://www.spinics.net/lists/alsa-devel/msg71617.html

Based on linux-next tag: next-20180420

Jorge Sanjuan (3):
  ALSA: usb-audio: UAC3. Add support for mixer unit.
  ALSA: usb-audio: Use Class Specific EP for UAC3 devices.
  ALSA: usb-audio: UAC3 Add support for connector insertion.

Michael Drake (1):
  ALSA: usb-audio: ADC3: Fix channel mapping conversion for ADC3.

 include/linux/usb/audio-v2.h   |   7 ++
 include/linux/usb/audio-v3.h   |  14 ++++
 include/uapi/linux/usb/audio.h |  13 ++-
 sound/usb/mixer.c              | 175 ++++++++++++++++++++++++++++++++++++-----
 sound/usb/stream.c             |  19 ++++-
 5 files changed, 204 insertions(+), 24 deletions(-)

-- 
2.11.0

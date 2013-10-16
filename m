From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH 0/2] Enable mute LEDs and mic mute LEDs on Thinkpad
Date: Wed, 16 Oct 2013 14:15:34 +0200
Message-ID: <1381925736-11399-1-git-send-email-david.henningsson@canonical.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, platform-driver-x86@vger.kernel.org, ibm-acpi@hmh.eng.br, alex.hung@canonical.com, hui.wang@canonical.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi!

These two patches bind the thinkpad-acpi and the snd-hda-intel drivers together
so that the mute and mic-mute LEDs correspond to the current mute/micmute status
of the internal sound card.

The patches are against Takashi's sound tree and are working on a
Thinkpad X220-tablet, but the patches are otherwise in draft quality. Which means
that there are several outstanding issues that would need feedback from upstream.

First, I'd like feedback on the connection between the drivers - Takashi suggested
that we could bind the drivers together like we've recently done when connecting
the snd-hda-intel and the i915 driver, so this follows a similar scheme, with
exported symbols from the thinkpad-acpi driver and a symbol_request on the
snd-hda-intel side.
This also opens up for future improvements so that the hardware mute/volume does
not need to be its own card, but instead properly integrate with the output it
actually controls on the kernel side.

Second, about the LEDs as a security feature. As implemented in these patches
there is no userspace interface at all, which would meet Matthew's concern about
that. A future improvement could be that an alsamixer control was added, that
allows the LED to be turned off, but not on. Which means, if PulseAudio or other
daemon knows that recording goes on from another source (e g bluetooth or network
connected mic) it could turn the mic mute LED off to indicate that to the user,
but the only way to turn the LED on is to actually mute the internal card's
hardware.

Finally, it is my hope that I will get some quick and constructive feedback so
we can have it all in order to be merged in time for the 3.13 kernel merge window.
I'll be at Linuxcon Europe next week to answer questions if you have any, and
we might also spend some time talking about it on the audio meeting on Monday.

Thanks in advance!

David Henningsson (2):
  thinkpad-acpi: Add mute and mic-mute LED functionality
  ALSA: hda - add connection to thinkpad_acpi to control mute/micmute
    LEDs

 drivers/platform/x86/thinkpad_acpi.c |   94 +++++++++++++++++++++++++++++++++-
 include/linux/thinkpad_acpi.h        |   10 ++++
 sound/pci/hda/patch_conexant.c       |   78 ++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/thinkpad_acpi.h

-- 
1.7.9.5

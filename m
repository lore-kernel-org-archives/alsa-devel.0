From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2 0/3] Enable mute LEDs and mic mute LEDs on Thinkpad
Date: Wed, 16 Oct 2013 23:10:30 +0200
Message-ID: <1381957833-13788-1-git-send-email-david.henningsson@canonical.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, platform-driver-x86@vger.kernel.org, ibm-acpi@hmh.eng.br, alex.hung@canonical.com, hui.wang@canonical.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Encouraged by the quick and helpful feedback from both Takashi and Henrique (thanks!),
I went to work with v2 of the patch.

Changes since v1:

 - thinkpad-acpi patch: rewritten to follow Takashi's ideas
 - thinkpad-acpi patch: added documentation update
 - alsa side: added a separate patch for the new fixup action
 - alsa side: rewrote patch a little, mostly based on comments from Takashi

David Henningsson (3):
  thinkpad-acpi: Add mute and mic-mute LED functionality
  ALSA: hda - add HDA_FIXUP_ACT_FREE action
  ALSA: hda - add connection to thinkpad_acpi to control mute/micmute
    LEDs

 Documentation/laptops/thinkpad-acpi.txt |    7 ++-
 drivers/platform/x86/thinkpad_acpi.c    |   92 ++++++++++++++++++++++++++++++-
 include/linux/thinkpad_acpi.h           |   15 +++++
 sound/pci/hda/hda_local.h               |    1 +
 sound/pci/hda/patch_conexant.c          |   92 ++++++++++++++++++++++++++++++-
 5 files changed, 202 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/thinkpad_acpi.h

-- 
1.7.9.5

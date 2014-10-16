From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 0/2] Disable the ThinkPad HW mute/level control when possible
Date: Thu, 16 Oct 2014 11:33:03 -0700
Message-ID: <cover.1413484274.git.luto@amacapital.net>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net
Cc: Len Brown <len.brown@intel.com>, Jerone Young <jerone.young@canonical.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, platform-driver-x86@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>
List-Id: alsa-devel@alsa-project.org

This series is being resurrected after several years, and it's quite
different from before, so I'm restarting the version number at 1 :)

ThinkPad volume and mute controls are a mess.  For whatever reason,
ThinkPads have mute buttons that send KEY_MUTE *and* control an
invisible-to-ALSA mute switch.  Some of them have volume controls that
interact with this switch as well.

This is a perennial source of problems.  On most ThinkPads, if you press
mute and then unmute using GUI controls, you have no sound, because
userspace and ALSA state gets out of sync with the hardware switch.
There's a separate "sound card" that exposes the hardware switch, but
userspace code generally doesn't understand that.

There are already a few _OSI(Linux) overrides to turn all the hardware
buttons into regular buttons.  Rather than quirking ACPI everywhere,
just teach thinkpad-acpi to program the buttons for full software
control and to disable hardware controls.  That allows us to remove the
ACPI quirks and have normal mute controls.  This approach should be
much simpler than adding even more kludgey ALSA integration for
questionable gain.

I haven't tested on my X220 (which has a mute light in addition to a
mute button), since that laptop's SATA controller died last week.  It
should work, though, and if someone else could test this on a ThinkPad
with a mute light, that would be great.

The only issue I know of with this version is that unloading and
reloading the module to change the software_mute setting doesn't
work quite right.  I can fix that if it matters.

Changes from v1:
 - Simplified the code a bit.
 - Improved suspend/hibernate behavior.

Andy Lutomirski (2):
  thinkpad-acpi: Try to use full software mute control
  acpi: Remove _OSI(Linux) for ThinkPads

 drivers/acpi/blacklist.c             | 54 --------------------
 drivers/platform/x86/thinkpad_acpi.c | 98 ++++++++++++++++++++++++++++++++----
 2 files changed, 88 insertions(+), 64 deletions(-)

-- 
1.9.3

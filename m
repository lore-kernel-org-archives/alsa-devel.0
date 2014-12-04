From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v3 0/2] Disable the ThinkPad HW mute/level control when
 possible
Date: Thu, 4 Dec 2014 03:55:15 -0800
Message-ID: <20141204115515.GD100190@vmdeb7>
References: <cover.1413590510.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1413590510.git.luto@amacapital.net>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Matthew Garrett <mjg59@srcf.ucam.org>, ibm-acpi-devel@lists.sourceforge.net, Len Brown <len.brown@intel.com>, David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, platform-driver-x86@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 17, 2014 at 05:04:28PM -0700, Andy Lutomirski wrote:
> This series is being resurrected after several years, and it's quite
> different from before, so I'm restarting the version numbers :)
> 
> ThinkPad volume and mute controls are a mess.  For whatever reason,
> ThinkPads have mute buttons that send KEY_MUTE *and* control an
> invisible-to-ALSA mute switch.  Some of them have volume controls that
> interact with this switch as well.
> 
> This is a perennial source of problems.  On most ThinkPads, if you press
> mute and then unmute using GUI controls, you have no sound, because
> userspace and ALSA state gets out of sync with the hardware switch.
> There's a separate "sound card" that exposes the hardware switch, but
> userspace code generally doesn't understand that.
> 
> There are already a few _OSI(Linux) overrides to turn all the hardware
> buttons into regular buttons.  Rather than quirking ACPI everywhere,
> just teach thinkpad-acpi to program the buttons for full software
> control and to disable hardware controls.  That allows us to remove the
> ACPI quirks and have normal mute controls.  This approach should be
> much simpler than adding even more kludgey ALSA integration for
> questionable gain.
> 
> Tested on an X200s (with latching mute by default) and an X220 (with
> a mute light and toggle mute by default).  Everything works as expected.
> 
> Changes from v2:
>  - Don't try to change the mute mode on IBM ThinkPads.
>  - Further minor cleanups.
>  - Try to restore the mode on module unload.
> 
> Changes from v1:
>  - Simplified the code a bit.
>  - Improved suspend/hibernate behavior.
> 
> Andy Lutomirski (2):
>   thinkpad-acpi: Try to use full software mute control
>   acpi: Remove _OSI(Linux) for ThinkPads
> 
>  drivers/acpi/blacklist.c             |  54 ----------------
>  drivers/platform/x86/thinkpad_acpi.c | 116 ++++++++++++++++++++++++++++++++---
>  2 files changed, 106 insertions(+), 64 deletions(-)

Andy, is this the latest version?

-- 
Darren Hart
Intel Open Source Technology Center

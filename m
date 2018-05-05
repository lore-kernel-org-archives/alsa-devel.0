From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH v3 0/9] ALSA: hda/ca0132: Patch Series for
	Recon3Di and Sound Blaster Z Support
Date: Sat,  5 May 2018 15:03:11 -0400
Message-ID: <1525547001-17588-1-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B47A32675D3
 for <alsa-devel@alsa-project.org>; Sat,  5 May 2018 21:04:06 +0200 (CEST)
Received: by mail-it0-f66.google.com with SMTP id 186-v6so7212444itu.0
 for <alsa-devel@alsa-project.org>; Sat, 05 May 2018 12:04:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= <jeremy.lefaure@lse.epita.fr>, Connor McAdams <conmanx360@gmail.com>, o-takashi@sakamocchi.jp
List-Id: alsa-devel@alsa-project.org

This patchset adds support for the Sound Blaster Z and the Recon3Di.

In order to figure out how to get these cards to work, I made a program called
QemuHDADump[1], which uses the trace function of qemu to see interactions with
the memory mapped pci BAR space of the card being used in the virtual machine.
With this, I obtain the CORB buffer location to get the command verbs, and then
dump them each time the buffer rolls over. This program may be useful for fixing
other HDA related driver issues where there is no documentation for the device.

So far, I have been able to get all features supported on the Sound Blaster Z
and the Recon3Di. All output and input effects work, all inputs and outputs
work, and just about anything else I can think of. I have also added new 
controls in order to select the new inputs and outputs, as well as controls to
change the effect levels and presets. 

I have also added the ability to use firmware taken from the Windows drivers of
both the Sound Blaster Z and Recon3Di. I am trying to get into contact with 
Creative to get permission to redistribute these along with the current 
file included with the Chromebook, but they have not been very responsive. 
Luckily, the cards work with the Chromebook firmware just fine, although I 
believe there has to be a reason they have different firmware in Windows. I 
will not link to the firmwares here, but if you look up my thread on Creative
Labs forums, you will find the link to download the firmwares there.

I am willing to help get the other non-working cards such as the ZxR and the
newer AE-5 working too, but I will need someone willing to run QemuHDADump in a
virtual machine in order to get the commands.

So, in summary:
-This patchset makes the cards work better than they did before (they really 
 didn't work before)

-This patchset leaves the original chromebook related stuff alone.

Thanks.

[1] https://github.com/Conmanx360/QemuHDADump

Bugs:
-------------------------------------------------------------------------------
Recon3Di: (Reported by Mariusz Ceier)
*******************
-Occasionally switching between rear and front mic breaks the input until 
 computer is shutdown or put to sleep.

-Surround Sound works, but is inconsistent. Sometimes, just updating the volume
 fixes it, and sometimes, it requires a restart. 

Sound Blaster Z:
*******************
-none that I'm aware of.


Version changes:
-------------------------------------------------------------------------------
v1:
*******************
-Massive patch formatting failure, please ignore v1.

v2:
*******************
-Fixed patch formatting failure.

v3:
*******************
-Fixed mem_base unmap, instead of checking for QUIRK_SBZ on exit, have it check
 if the area is mapped, and if it is, unmap it. Also make it unmap after all 
 other commands are finished.

-Change notification of failure to map mem_base from codec_dbg to codec_warn, 
 and use codec_info to tell the user that their card might have been incorrectly
 identified as a Sound Blaster Z.

-Remove commented out commands in sbz_exit_chip function, only reintroduce them
 when their functions are defined.


Connor McAdams (9):
  ALSA: hda/ca0132: R3Di and SBZ quirk entires + alt firmware loading
  ALSA: hda/ca0132: Add pincfg for SBZ + R3Di, add fp hp auto-detect
  ALSA: hda/ca0132: Add PCI region2 iomap for SBZ
  ALSA: hda/ca0132: Add extra exit functions for R3Di and SBZ
  ALSA: hda/ca0132: add/change helper functions for R3Di and SBZ
  ALSA: hda/ca0132: add alt_select_in/out for R3Di + SBZ
  ALSA: hda/ca0132: Add DSP Volume set and New mixers for SBZ + R3Di
  ALSA: hda/ca0132: add ca0132_alt_set_vipsource
  ALSA: hda/ca0132: Add new control changes for SBZ + R3Di

 sound/pci/hda/patch_ca0132.c | 3055 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 2941 insertions(+), 114 deletions(-)

-- 
2.7.4

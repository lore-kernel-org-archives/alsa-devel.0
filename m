From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 00/19] Enable platform HDA drivers
Date: Thu, 27 Feb 2014 22:35:43 -0800
Message-ID: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f74.google.com (mail-qg0-f74.google.com
 [209.85.192.74])
 by alsa0.perex.cz (Postfix) with ESMTP id E68CB264F0A
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:03 +0100 (CET)
Received: by mail-qg0-f74.google.com with SMTP id z60so34138qgd.1
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:02 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

This series rearranges some code in the HDA driver to break
dependencies on PCI and allow for most of the HDA code to be reused
for non-PCI based HDA controllers.

I tried to break it up to make it less scary and to keep changes away
from copies of code.  It is mostly copies with a few modifications to
make more of the code usable by both HDA drivers.  The main changes
were to avoid using pci to get a device pointer, and to make the bus
reads/writes into callbacks so that the Tegra driver could ensure
32-bit access to the HDA registers.

The final patch is a work in progress included here to provide context
for the preceding patches.  The Tegra HDA driver still needs some
cleaning up, but nothing that will affect the other changes.  The last
infrastructure issue is that the Tegra driver uses DT, causing it to be
probed before the codec patches.  I haven't determined how to fix that
yet.

I didn't include the patch to move the hda directory from under pci
because of its size and how easy it will be to regenerate later.

Thanks for looking.  Let me know if you think any of these should be
squashed or re-ordered and if the changes and breakup of code makes
sense.


Dylan

--
Dylan Reid (19):
  ALSA: hda - Move some definitions to new hda_priv.h
  ALSA: hda - Allow different ops to read/write registers
  ALSA: hda - Keep pointer to bdl_pos_fix in chip struct
  ALSA: hda - Store device pointer in chip structure
  ALSA: hda - Move pcm ops and support funcs to shared file
  ALSA: hda - Pull pages allocation to shared file
  ALSA: hda - Move the dsp loader to hda_shared
  ALSA: hda - Add function pointer for disabling MSI
  ALSA: hda - Relocate RIRB/CORB interface to hda_shared
  ALSA: hda - move alloc_cmd_io to hda_shared.
  ALSA: hda - Move low level functions to hda_shared
  ALSA: hda - remove unused clear of STATESTS
  ALSA: hda - Move azx_interrupt to hda_shared
  ALSA: hda - Add jackpoll_ms to struct azx
  ALSA: hda - Pass max_slots and power_save to codec_create
  ALSA: hda - Move codec create to hda_shared
  ALSA: core - Define snd_pci_quirk without CONFIG_PCI
  ALSA: hda - remove PCI dependency in Kconfig
  WIP: ALSA: hda - Add driver for Tegra SoC HDA

 include/sound/core.h       |   15 +-
 sound/pci/Kconfig          |    4 +-
 sound/pci/hda/Kconfig      |   55 +-
 sound/pci/hda/Makefile     |    8 +-
 sound/pci/hda/hda_intel.c  | 2832 +++-----------------------------------------
 sound/pci/hda/hda_priv.h   |  446 +++++++
 sound/pci/hda/hda_shared.c | 2175 ++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_shared.h |   52 +
 sound/pci/hda/hda_tegra.c  |  858 ++++++++++++++
 9 files changed, 3778 insertions(+), 2667 deletions(-)
 create mode 100644 sound/pci/hda/hda_priv.h
 create mode 100644 sound/pci/hda/hda_shared.c
 create mode 100644 sound/pci/hda/hda_shared.h
 create mode 100644 sound/pci/hda/hda_tegra.c

-- 
1.8.1.3.605.g02339dd

From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v10 0/7] ALSA: jack: Refactoring for jack kctls
Date: Mon, 27 Apr 2015 21:20:55 +0800
Message-ID: <1430140862-17207-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A0757260670
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 15:17:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tanu.kaskinen@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

This patch series aligns jack handling between the HDA and ASoC
subsystems.

The HDA subsystem currently creates a kcontrol for each HDA jack
registered. ASoC subsystem creates input device jacks for each
jack registered. This series aligns both jack APIs to create
kcontrol jacks.

This implementation keeps compatibility with existing HDA jacks
so no userspace changes are required.

Changes in v10:
1. rebase it on top of tiwai/sound.git for-linus branch;
2. Liam helps fix some typos and syntax errors in comments and
descriptions.

Changes in v9:
1. move struct snd_jack_kctl definition to jack.c, to hides the
internal implementation details;
2. some small code fixing;
3. update documentation file.

Changes in v8:
1. remove snd_jack_kctl from HDA part, change snd_jack_new param
to use bool for creating kcontrol at jack creating stage;
2. create jack for phantom jack, with no input device;
3. remove HDA jack get_unique_index() and index related code.

Changes in v7:
1. move name generating and index getting part into ctljack.c;
2. remove exposing private_data and destructor to HDA, then jack
core can handle kctls by itself totally.
3. some small code fixing.

Changes in v6:
1. refine kctl name generating function;
2. integrate HDA jack kctl more deeply, support phantom jack in
snd_jack_new();
3. add documentation for Jack kcontrols to explain how to use it.

Changes in v5:
1. remove SND_KCTL_JACK config item, we need jack kctl once
CONFIG_SND_JACK is selected.

Changes in v4:
1. use snd_ctl_find_id() to get avaliable index;
2. add initial kctl for snd_jack_new(compatible for HDA);
3. add struct snd_jack_kctl * field to struct hda_jack_tbl;
4. new kctls for soc jack during jack pins creating.
5. add a patch to remove exporting snd_kctl_jack_new().

Changes in v3:
1. replace bit index with bit mask in jack_kctl;
2. add exception for SND_JACK_HEADSET and SND_JACK_AVOUT, only create
one jack kctl for these two combo jacks, respectively.
3. add NULL check, mem kfree, and fix some potential risk.

Change in v2:
1. define jack_kctl struct, and put jack kctl related stuff there;
2. add a patch to remove the existing controls for HDA jack.

Jie Yang (7):
  ALSA: jack: implement kctl creating for jack devices
  ALSA: Jack: handle jack embedded kcontrol creating within ctljack
  ALSA: jack: extend snd_jack_new to support phantom jack
  ALSA: hda - Update to use the new jack kctls method
  ASoC: jack: create kctls according to jack pins info
  ALSA: jack: remove exporting ctljack functions
  ALSA: Docs: Add documentation for Jack kcontrols

 Documentation/sound/alsa/Jack-Controls.txt |  43 ++++++++++
 include/sound/control.h                    |   2 +-
 include/sound/jack.h                       |  13 ++-
 sound/core/Kconfig                         |   3 -
 sound/core/Makefile                        |   3 +-
 sound/core/ctljack.c                       |  41 +++++++--
 sound/core/jack.c                          | 133 ++++++++++++++++++++++++++---
 sound/pci/hda/Kconfig                      |   2 +-
 sound/pci/hda/hda_jack.c                   |  90 ++++++-------------
 sound/pci/hda/hda_jack.h                   |   5 +-
 sound/pci/hda/patch_hdmi.c                 |   2 +-
 sound/pci/oxygen/xonar_wm87x6.c            |   2 +-
 sound/soc/soc-jack.c                       |   3 +-
 13 files changed, 242 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/sound/alsa/Jack-Controls.txt

-- 
1.9.1

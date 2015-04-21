From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v7 0/7] ALSA: jack: Refactoring for jack kctls
Date: Tue, 21 Apr 2015 16:05:38 +0800
Message-ID: <1429603545-21063-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 569B8260467
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2015 10:02:31 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Currently only hda will create kctls for hda jacks, for asoc, people
may need create jack kctls in specific driver.

Here we are introducing kctls for each jack, by creating kctls and add
them to jack controls list (considering exist of combo jack). At the
same time, we will report events for each control in the list.

With this new implementation, both HDA and soc jack kctls works fine,
they are compatible for old HDA jack kctls, too.

For soc,
a. snd_jack_new() with NULL jack_kctl;
b. for each pin, call snd_jack_add_kctls() to add one kctl(it will
call snd_ctl_add() to add kctl to card);

For HDA,
With snd_jack_new(), we can use phantom_jack = true for phantom jack
creating, and the jack kctl pointer will be filled with the new
created kcontrol.

Changes in v7:
1. move name generating and index getting part into ctljack.c;
2. remove exposing private_data and destructor to hda, then jack
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
  ALSA: jack: implement kctl creating for jack device
  ALSA: Jack: refactoring snd_kctl_jack_new to support embedded kctl
  ALSA: jack: extend snd_jack_new to support phantom jack
  ALSA: hda - Update to use the new jack kctls method
  ASoC: jack: create kctls according to jack pins info
  ALSA: jack: remove exporting ctljack functions
  ALSA: Docs: Add documentation for Jack kcontrols

 Documentation/sound/alsa/Jack-Controls.txt |  48 +++++++++
 include/sound/control.h                    |   2 +-
 include/sound/jack.h                       |  19 +++-
 sound/core/Kconfig                         |   3 -
 sound/core/Makefile                        |   3 +-
 sound/core/ctljack.c                       |  41 ++++++--
 sound/core/jack.c                          | 156 +++++++++++++++++++++++++----
 sound/pci/hda/Kconfig                      |   1 -
 sound/pci/hda/hda_jack.c                   |  53 ++++------
 sound/pci/hda/hda_jack.h                   |   4 +-
 sound/pci/oxygen/xonar_wm87x6.c            |   2 +-
 sound/soc/soc-jack.c                       |   3 +-
 12 files changed, 259 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/sound/alsa/Jack-Controls.txt

-- 
1.9.1

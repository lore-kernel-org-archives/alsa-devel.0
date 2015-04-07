From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v5 0/5] ALSA: jack: Refactoring for jack kctls
Date: Tue,  7 Apr 2015 12:44:46 +0800
Message-ID: <1428381891-30517-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 456AD260550
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 06:41:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
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

For hda,
a. call snd_jack_kctl_new()(in __snd_hda_jack_add_kctl()) to new a
jack_kctl(also new kctl); and use snd_hda_ctl_add to add kctl to card;
b. new a hda_jack_tbl, appoint jack_tbl->jack_kctl = jack_kctl;
c. for non-phantom jack, call snd_jack_new() with this jack_kctl,
then the jack_kctl will be added to the new created jack;

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

Jie Yang (5):
  ALSA: jack: create jack kcontrols for every jack input
  ALSA: jack: add a parameter to pass kctl for snd_jack_new
  ALSA: hda - Update to use the new jack kctls method
  ASoC: jack: create kctls according to jack pins info
  ALSA: jack: remove export snd_kctl_jack_new()

 include/sound/jack.h            |  25 ++++++-
 sound/core/Kconfig              |   3 -
 sound/core/Makefile             |   3 +-
 sound/core/ctljack.c            |   1 -
 sound/core/jack.c               | 152 +++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/Kconfig           |   1 -
 sound/pci/hda/hda_jack.c        |  52 +++++++-------
 sound/pci/hda/hda_jack.h        |   4 +-
 sound/pci/oxygen/xonar_wm87x6.c |   2 +-
 sound/soc/soc-jack.c            |   3 +-
 10 files changed, 201 insertions(+), 45 deletions(-)

-- 
1.9.1

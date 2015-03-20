From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v3 0/2] ALSA: jack: Refactoring for jack kctls
Date: Fri, 20 Mar 2015 23:39:11 +0800
Message-ID: <1426865953-1606-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BEF7265707
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 16:36:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Currently only hda will create kctls for hda jacks, for asoc, people
may need create jack kctls in specific driver.

Here we are introducing kctls for each jack, by creating kctls and add
them to jack controls list (considering exist of combo jack). At the
same time, we will report events for each control in the list.

With this implement, we are no longer need hda jack specific kctls, so
here also remove jack kctls for hda.

Changes in v3:
1. replace bit index with bit mask in jack_kctl;
2. add exception for SND_JACK_HEADSET and SND_JACK_AVOUT, only create
one jack kctl for these two combo jacks, respectively.
3. add NULL check, mem kfree, and fix some potential risk.

Change in v2:
1. define jack_kctl struct, and put jack kctl related stuff there;
2. add a patch to remove the existing controls for HDA jack.

Jie Yang (2):
  ALSA: jack: create jack kcontrols for every jack input device
  ALSA: hda - Remove jack kctls

 include/sound/jack.h     |   8 ++++
 sound/core/Kconfig       |   3 --
 sound/core/Makefile      |   3 +-
 sound/core/jack.c        | 118 ++++++++++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/Kconfig    |  10 +---
 sound/pci/hda/hda_jack.c |  45 ++----------------
 sound/pci/hda/hda_jack.h |   3 --
 7 files changed, 129 insertions(+), 61 deletions(-)

-- 
1.9.1

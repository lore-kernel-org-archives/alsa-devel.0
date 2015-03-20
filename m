From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v2 0/2] ALSA: jack: Refactoring for jack kctls
Date: Fri, 20 Mar 2015 16:55:16 +0800
Message-ID: <1426841719-14576-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 12E2E2606E0
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 09:52:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Currently only hda will create kctls for hda jacks, for asoc, people
may need create jack kctls in specific driver.

Here we are introducing kctls for each jack, by creating kctls and add
them to jack controls list (considering exist of combo jack). At the
same time, we will report events for each control in the list.

With this implement, we are no longer need hda jack specific kctls, so
here also remove jack kctls for hda.

Any comments are welcome.

Jie Yang (2):
  ALSA: jack: create jack kcontrols for every jack input device
  ALSA: hda - Remove jack kctls

 include/sound/jack.h     |  8 ++++
 sound/core/Kconfig       |  3 --
 sound/core/Makefile      |  3 +-
 sound/core/jack.c        | 99 +++++++++++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/Kconfig    | 10 +----
 sound/pci/hda/hda_jack.c | 45 ++--------------------
 sound/pci/hda/hda_jack.h |  3 --
 7 files changed, 110 insertions(+), 61 deletions(-)

-- 
1.9.1

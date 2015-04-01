From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 0/5] ALSA: hda - add hda controller to hda
	core
Date: Wed,  1 Apr 2015 17:00:57 +0530
Message-ID: <1427887862-29054-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AA0826518B
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 13:35:27 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This incorporates the comments from Takashi on 1st patch and uses the change
from Takashi's unstable tree for controller and then adds the DSP loader
code on top.
This is based on sound/topic/hda-core

Comments welcome

Jeeja KP (1):
  ALSA: hda: move common hda controller register defines up

Vinod Koul (4):
  ALSA: hda: add HDA_MAX_CODECS
  ALSA: hda - Add the controller helper codes to hda-core module
  ALSA: hda - move dsp lock to hdac
  ALSA: hda - add the DSP loader code

 include/sound/hda_registers.h  |  177 +++++++++++++
 include/sound/hdaudio.h        |  185 ++++++++++++-
 sound/hda/Makefile             |    3 +-
 sound/hda/hdac_bus.c           |   13 +-
 sound/hda/hdac_controller.c    |  401 ++++++++++++++++++++++++++++
 sound/hda/hdac_stream.c        |  565 ++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_controller.c |   17 +-
 sound/pci/hda/hda_controller.h |  171 +-----------
 8 files changed, 1347 insertions(+), 185 deletions(-)
 create mode 100644 include/sound/hda_registers.h
 create mode 100644 sound/hda/hdac_controller.c
 create mode 100644 sound/hda/hdac_stream.c

-- 
1.7.9.5

From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC v2 0/3] ALSA: hda: add hda controller to hda core
Date: Wed, 25 Mar 2015 11:31:36 +0530
Message-ID: <1427263299-14707-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BCA726158C
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 07:05:45 +0100 (CET)
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
Cc: tiwai@suse.de, jeeja.kp@intel.com, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This series starts adding base hda controller code to hda core. There are
few more changes like dsp loader etc planned to be added as well.

This is based on Takashi's test/hda-core branch with patches posted last
week, we have modified naming convention loosely based on takashi's work,
Takshi feel free to recommend more changes if you think they are required


Jeeja KP (2):
  ALSA: hda: move common hda controller register defines up
  ALSA: hda: add hda controller to hda

Vinod Koul (1):
  ALSA: hda: add HDA_MAX_CODECS

 include/sound/hda_registers.h  |  200 +++++++
 include/sound/hda_verbs.h      |    1 +
 include/sound/hdaudio.h        |  215 +++++++
 sound/hda/Makefile             |    2 +-
 sound/hda/hdac_controller.c    | 1284 ++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/hda_controller.c |    4 +-
 sound/pci/hda/hda_controller.h |  203 +------
 7 files changed, 1707 insertions(+), 202 deletions(-)
 create mode 100644 include/sound/hda_registers.h
 create mode 100644 sound/hda/hdac_controller.c

-- 
1.7.9.5

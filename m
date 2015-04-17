From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 0/2] ALSA: HDA: add stream params to hda core
Date: Fri, 17 Apr 2015 17:58:56 +0530
Message-ID: <1429273738-24666-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 091DE260587
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 14:34:05 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

This two patches are splut form the series v2 as they are specfic to HDAC.
First adds ASoC device type later to be used by ASOC driver and second for
the stream params.

Jeeja KP (1):
  ALSA: hda - add generic functions to set hdac stream params

Ramesh Babu (1):
  ALSA: hda - add ASoC device type for hda core

 include/sound/hdaudio.h |    3 +++
 sound/hda/hdac_stream.c |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

-- 
1.7.9.5

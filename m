From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v5 0/2] Add HDA codec match and new registers
Date: Wed,  3 Jun 2015 12:24:30 +0530
Message-ID: <1433314472-24965-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D68A52604C2
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 08:53:18 +0200 (CEST)
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

This series is split from SKL driver series and adds default codec match
function and then the new HDA registers definitions added in SKL

Jeeja KP (1):
  ALSA: hda - add new HDA registers

Vinod Koul (1):
  ALSA: hda - add HDA default codec match function

 include/sound/hda_register.h | 88 ++++++++++++++++++++++++++++++++++++++++++++
 include/sound/hdaudio.h      | 14 +++++++
 sound/hda/hda_bus_type.c     | 41 +++++++++++++++++++++
 3 files changed, 143 insertions(+)

-- 
1.9.1

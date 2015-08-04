From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/3] ALSA: hdac: stream fixes
Date: Tue,  4 Aug 2015 09:28:37 +0530
Message-ID: <1438660720-30033-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B16B26537B
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 05:57:01 +0200 (CEST)
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

Hi Takashi,

I had few off fixes on hdac piled up so time to send them out.

First one is a fix for stream assignment for decoupled mode used in SKL
driver. Second one is static checker fix reported by Dan Carpenter
Last is a potential issue which our team reported so a WA for that. The
command DMAs do not finish instantaneously, so we should per spec wait till
DMA finishes

Jeeja KP (2):
  ALSA: HDA: Fix stream assignment for host in decoupled mode
  ALSA: HDA: Dont check return for snd_hdac_chip_readl

Vinod Koul (1):
  ALSA: HDA: wait for RIRB, CORB DMA to finish

 sound/hda/ext/hdac_ext_controller.c |  6 ------
 sound/hda/ext/hdac_ext_stream.c     |  2 +-
 sound/hda/hdac_controller.c         | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 7 deletions(-)

-- 
1.9.1

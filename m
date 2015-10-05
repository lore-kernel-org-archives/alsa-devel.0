From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 0/4] ALSA: hdac: fixes and support for hda
	codecs
Date: Mon,  5 Oct 2015 15:09:47 +0100
Message-ID: <1444054191-17030-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D772260632
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 16:10:34 +0200 (CEST)
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

We had two fixes found on testing. First one checks if stream is in use or
not before releasing and second fixs wrong stread id map

Then we add structure defination for hdac_ext_dma_params and lastly add
helpers for read/write for codecs

Jeeja KP (1):
  ALSA: hdac: Fix to check if stream not in use in release

Subhransu S. Prusty (3):
  ALSA: hdac: Fix incorrect update of stream id mapping
  ALSA: hdac: structure definition for ext_dma_params
  ALSA: hdac: Add codec read/write and check power state for widgets

 include/sound/hdaudio.h         |  6 ++++++
 include/sound/hdaudio_ext.h     |  6 ++++++
 sound/hda/ext/hdac_ext_stream.c |  9 ++++----
 sound/hda/hdac_device.c         | 47 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 5 deletions(-)

-- 
2.4.3

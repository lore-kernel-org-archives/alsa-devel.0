From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v8 0/6]  Add mrfld DSP topology and widgets
Date: Mon,  6 Oct 2014 19:29:08 +0530
Message-ID: <1412603954-9030-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B9B9A260480
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 16:31:50 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch series adds DPCM and DAPM widgets to handle DSP topology in the
SST platform driver for merrifield.

changes in v8:
 - fix the locking and comments blobs
 - fix the send_ssp_slot to send IPC on none
 - fix controls to have "Volume" and "Switch" wherever neccessary
 - add mute for CPU dai in asoc core patch

Ramesh Babu (1):
  ASoC: core: Call mute for cpu dais as well

Vinod Koul (5):
  ASoC: Intel: mrfld: add the gain controls
  ASoC: Intel: mrfld: add DSP core controls
  ASoC: Intel: mrfld: add the DSP DAPM widgets
  ASoC: Intel: mfld-pcm: add FE and BE ops
  ASoC: Intel: mrfld: add the DSP mixers

 sound/soc/intel/sst-atom-controls.c     | 1212 ++++++++++++++++++++++++++++++-
 sound/soc/intel/sst-atom-controls.h     |  428 +++++++++++
 sound/soc/intel/sst-mfld-platform-pcm.c |  153 ++++-
 sound/soc/intel/sst-mfld-platform.h     |    4 +
 sound/soc/soc-pcm.c                     |    3 +
 5 files changed, 1770 insertions(+), 30 deletions(-)

Thanks
-- 
~Vinod

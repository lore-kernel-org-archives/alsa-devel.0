From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v7 0/7] Add mrfld DSP topology and widgets
Date: Fri, 19 Sep 2014 16:46:01 +0530
Message-ID: <1411125368-5836-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9793F261A7C
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 13:39:03 +0200 (CEST)
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This patch series adds DPCM and DAPM widgets to handle DSP topology in the
SST platform driver for merrifield.

Changes in v7:
	Handle return values for some function calls.
	Added some comment for the vb_timer command operation.
	Addressed other review comments from Mark.

Subhransu S. Prusty (1):
  ASoC: Export dapm_kcontrol_get_value

Vinod Koul (6):
  ASoC: Intel: mrfld: add the gain controls
  ASoC: Intel: mfld-pcm: add control for powering up/down dsp
  ASoC: Intel: mrfld: add DSP core controls
  ASoC: Intel: mrfld: add the DSP DAPM widgets
  ASoC: Intel: mfld-pcm: add FE and BE ops
  ASoC: Intel: mrfld: add the DSP mixers

 include/sound/soc-dapm.h                |    1 +
 sound/soc/intel/sst-atom-controls.c     | 1140 ++++++++++++++++++++++++++++++-
 sound/soc/intel/sst-atom-controls.h     |  428 ++++++++++++
 sound/soc/intel/sst-mfld-platform-pcm.c |  169 ++++-
 sound/soc/intel/sst-mfld-platform.h     |   21 +-
 sound/soc/soc-dapm.c                    |    3 +-
 6 files changed, 1723 insertions(+), 39 deletions(-)

-- 
1.9.0

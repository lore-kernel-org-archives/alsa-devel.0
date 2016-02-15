From: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Subject: [RFC 0/4] Add support for DAI link addition dynamically
Date: Mon, 15 Feb 2016 17:49:28 +0530
Message-ID: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 by alsa0.perex.cz (Postfix) with ESMTP id A919B26063A
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 13:19:42 +0100 (CET)
Received: by mail-pa0-f42.google.com with SMTP id yy13so85273893pab.3
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 04:19:42 -0800 (PST)
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
Cc: liam.r.girdwood@linux.intel.com, mengdong.lin@linux.intel.com, vinod.koul@intel.com, Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, peter.ujfalusi@ti.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Following patches are based on for-next branch from broonie tree.
First 2 patches include changes in existing soc, core framework
to prepare for adding support for dynamic DAI link addition/
removal

Patch 3 & 4 contains actual changes to enable dynamic DAI link
support

NOTE:
Currently, the code is tested on Pandaboad ES revB3 for playback
usecase.

Vaibhav Agarwal (4):
  ASoc: Use ref_count for soc DAI & component
  alsa: add locked variant for snd_ctl_remove_id
  ASoC: Enable dynamic DAIlink insertion & removal
  ASoC: Change soc-card codec_conf array to a list

 include/sound/control.h  |   1 +
 include/sound/soc-dai.h  |   1 +
 include/sound/soc-dapm.h |   7 +-
 include/sound/soc-dpcm.h |   1 +
 include/sound/soc.h      |  18 ++-
 sound/core/control.c     |  23 +++
 sound/soc/Kconfig        |   4 +
 sound/soc/soc-core.c     | 359 ++++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/soc-dapm.c     | 105 +++++++++++---
 sound/soc/soc-pcm.c      |  25 ++++
 10 files changed, 501 insertions(+), 43 deletions(-)

-- 
2.1.4

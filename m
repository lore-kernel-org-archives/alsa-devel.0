From: vedang.patel@intel.com
Subject: [PATCH v3 0/3] ASoC: Reduce audio related kernel spew.
Date: Tue, 31 May 2016 18:14:58 -0700
Message-ID: <1464743701-14931-1-git-send-email-vedang.patel@intel.com>
References: <1461711790-7277-4-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 24D742650D4
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2016 03:15:05 +0200 (CEST)
In-Reply-To: <1461711790-7277-4-git-send-email-vedang.patel@intel.com>
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
Cc: vinod.koul@intel.com, marc.herbert@intel.com, liam.r.girdwood@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com, Vedang Patel <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

There have been complaints regarding audio related kernel messages flooding
dmesg. This series tries to address those complaints.

Also, I have created 3 different patches for this because they touch different
drivers. But, I can combine those to reduce the number of patches.

v2 Changes:
- Use print_hex_dump_debug instead of #ifdef DEBUG

v3 Changes:
- Remove Change-Id from all the patches.

Vedang Patel (3):
  ASoC: hdac_hdmi: Increase loglevel of hex dump printed
  ASoC: Intel: common: increase the loglevel of "FW Poll Status".
  ASoC: Intel: Skylake: Increase loglevel of debug messages.

 sound/soc/codecs/hdac_hdmi.c           |    6 ++++--
 sound/soc/intel/common/sst-dsp.c       |    2 +-
 sound/soc/intel/skylake/skl-messages.c |    2 +-
 sound/soc/intel/skylake/skl-sst-ipc.c  |    4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

-- 
1.7.9.5

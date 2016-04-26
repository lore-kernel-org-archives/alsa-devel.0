From: vedang.patel@intel.com
Subject: [PATCH v2 0/3] ASoC: Reduce audio related kernel spew.
Date: Tue, 26 Apr 2016 16:03:07 -0700
Message-ID: <1461711790-7277-1-git-send-email-vedang.patel@intel.com>
References: <1460498902-30454-4-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 74DF6261A0D
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 01:03:22 +0200 (CEST)
In-Reply-To: <1460498902-30454-4-git-send-email-vedang.patel@intel.com>
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
- use print_hex_dump_debug instead of #ifdef DEBUG

Vedang Patel (3):
  ASoC: hdac_hdmi: Increase loglevel of hex dump printed
  ASoC: Intel: common: increase the loglevel of "FW Poll Status".
  ASoC: Intel: Skylake: Increase loglevel of debug messages.

 sound/soc/codecs/hdac_hdmi.c           | 5 +++--
 sound/soc/intel/common/sst-dsp.c       | 2 +-
 sound/soc/intel/skylake/skl-messages.c | 2 +-
 sound/soc/intel/skylake/skl-sst-ipc.c  | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

-- 
2.1.2

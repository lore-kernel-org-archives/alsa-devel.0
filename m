From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 00/13] ADSP Firmware Controls Update
Date: Mon, 13 Apr 2015 13:27:52 +0100
Message-ID: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5DF0D26501D
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This series of patches starts with a few small clean ups for the
ADSP code, and then finally adds support for the rev 1 and 2
firmware file formats. The revision 1 format is in common usage
in the field so it is long overdue to get support for that merged
to mainline. The revision 2 format is fairly new but is starting
to see some deployment as well.

There is still more work todo here. The main next step is to add
support for arbitary length controls through the TLV binary
control feature that was recently added to the kernel. This patch
series will truncate any long controls to 512 bytes.

Thanks,
Charles

Charles Keepax (13):
  ASoC: wm_adsp: Split out adsp1 & 2 setup algorithms
  ASoC: wm_adsp: Improve variable naming
  ASoC: wm_adsp: Remove len field from wm_adsp_alg_region
  ASoC: wm_adsp: Limit firmware control name to ALSA control name size
  ASoC: wm_adsp: Move temporary control name to the stack
  ASoC: wm_adsp: Clean up low level control read/write functions
  ASoC: wm_adsp: Factor out creation of alg_regions
  ASoC: wm_adsp: Remove private field from wm_coeff_ctl
  ASoC: wm_adsp: Group all the ALSA control functions together
  ASoC: wm_adsp: Add basic support for rev 1 firmware file format
  ASoC: wm_adsp: Add support for DSP control flags
  ASoC: wm_adsp: Add support for rev 2 firmware file format
  ASoC: wm_adsp: Warn that firmware file format 0 is depreciated

 sound/soc/codecs/wm_adsp.c | 1129 +++++++++++++++++++++++++++-----------------
 sound/soc/codecs/wm_adsp.h |    6 +-
 sound/soc/codecs/wmfw.h    |   44 ++-
 3 files changed, 733 insertions(+), 446 deletions(-)

-- 
1.7.2.5

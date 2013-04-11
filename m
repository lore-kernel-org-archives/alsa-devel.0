From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 0/7] Add capture support to compress API
Date: Thu, 11 Apr 2013 19:00:38 +0100
Message-ID: <1365703245-20738-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C6DD266211
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 20:09:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This chain of patches does some clearing up and add capture
support to the compressed API.

Missing is support for capture streams that don't use the
copy callback. Also I have included two patches at the end
of the chain that remove the buffer pointers and just use
the cumulative values however as our setup uses the copy
callback these are untested past build so should be taken
with caution.

Thanks,
Charles

Charles Keepax (7):
  ALSA: compress_core: Update calc_avail to use cumulative values
  ALSA: compress_core: Calculate avail correctly for capture streams
  ALSA: compress_core: Deconstify copy callback buffer
  ALSA: compress_core: Add support for capture streams
  ASoC: soc-compress: Deduce stream direction
  ALSA: compress_core: Remove unused hw_pointer
  ALSA: compress_core: Rework writes to use cumulative values

 include/sound/compress_driver.h |    4 +-
 sound/core/compress_offload.c   |  117 +++++++++++++++++++++++++-------------
 sound/soc/soc-compress.c        |   11 +++-
 3 files changed, 87 insertions(+), 45 deletions(-)

-- 
1.7.2.5

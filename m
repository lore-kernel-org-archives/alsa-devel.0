From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 0/7] Add capture support to compress API
Date: Thu, 18 Apr 2013 10:58:41 +0100
Message-ID: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BEFE8262632
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 11:58:46 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, tiwai@suse.de, vinod.koul@intel.com
Cc: girdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com
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

Thess patches apply to:
  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
  branch "for-next"

based on top of commit
  126825e ALSA: snd-usb: add quirks handler for DSD streams

- RichF

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

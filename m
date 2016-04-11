From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v3 0/4] Propagate errors out from compressed
	streams
Date: Mon, 11 Apr 2016 15:27:31 +0100
Message-ID: <1460384855-10567-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 80F67260851
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 16:27:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, tiwai@suse.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

If the DSP suffers an unrecoverable error, the driver likely
knows about this, however the framework may not get informed
because errors returned from pointer requests are ignored within
the framework.

Things work out fine if user-space is doing a read as reads
return error status back to user-space so the user can find out
that things have gone bad. However, if user-space is doing an
avail request there is no path for the error to come back up to
user-space. The pointer request returns zero available data, so a
read never happens and we basically just end up sitting waiting
for data on a stream that we know full well has died.

This patch set attempts to address this and ensure that errors
are fully propagated to user-space and we don't ever end up wait
for data that will never come.

Changes since v2:
 - Make naming of stop function more generic and allow it to
   specify target state

Thanks,
Charles

Charles Keepax (4):
  ALSA: compress: Replace complex if statement with switch
  ALSA: compress: Add function to indicate the stream has gone bad
  ASoC: wm_adsp: Use new snd_compr_stop_error to signal stream failure
  ASoC: compress: Pass error out of soc_compr_pointer

 include/sound/compress_driver.h |  4 +++
 sound/core/compress_offload.c   | 69 ++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/wm_adsp.c      | 11 +++++--
 sound/soc/soc-compress.c        |  5 +--
 4 files changed, 81 insertions(+), 8 deletions(-)

-- 
2.1.4

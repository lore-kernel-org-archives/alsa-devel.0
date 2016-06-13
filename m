From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v7 0/3] Propagate errors out from compressed
	streams
Date: Mon, 13 Jun 2016 14:17:09 +0100
Message-ID: <1465823832-14718-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 73ABD265099
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 15:17:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, broonie@kernel.org
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
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

Changes since v6:
 - Series rebased on top of my other series fixing the return
   values from snd_compr_poll

These are based on Takashi's tree, as all the ADSP conflicts are
now straightened out, although there is a reasonable chance we
will do more ADSP during this cycle.

Thanks,
Charles

Charles Keepax (3):
  ALSA: compress: Add function to indicate the stream has gone bad
  ASoC: wm_adsp: Use new snd_compr_stop_error to signal stream failure
  ASoC: wm_adsp: Treat missing compressed buffer as a fatal error

 include/sound/compress_driver.h |  5 +++
 sound/core/compress_offload.c   | 67 +++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/wm_adsp.c      | 21 ++++++-------
 3 files changed, 80 insertions(+), 13 deletions(-)

-- 
2.1.4

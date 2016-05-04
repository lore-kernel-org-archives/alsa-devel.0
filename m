From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 0/5] Fix poll error returns
Date: Wed, 4 May 2016 14:59:06 +0100
Message-ID: <1462370351-15388-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id F0A5F2659AA
 for <alsa-devel@alsa-project.org>; Wed,  4 May 2016 16:12:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We return negative values from the file_operations poll callback
in a few places, this callback returns an unsigned int and is
expected to only return the poll specific flags. This series
fixes up these issues and makes a couple of small tidy ups to the
code around the edges of those functions.

I noticed this issue whilst doing some additional testing on my
propagation of compressed stream error series, but I decided to
push these up separately as it is worth getting the fixes in
now and not tying them up with that patch chain which is taking
longer to get merged.  Also I included the first patch of that
chain (Replace complex if statement with switch) because it is a
trivial tidy up and might as well get merged now as well.

Thanks,
Charles

Charles Keepax (5):
  ALSA: pcm: Fix poll error return codes
  ALSA: compress: Use snd_compr_get_poll on error path
  ALSA: compress: Remove pointless NULL check
  ALSA: compress: Fix poll error return codes
  ALSA: compress: Replace complex if statement with switch

 sound/core/compress_offload.c | 25 ++++++++++++-------------
 sound/core/pcm_native.c       |  4 ++--
 2 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.1.4

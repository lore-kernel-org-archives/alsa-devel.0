From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 0/3] ASoC: Intel: Baytrail: Fix stream restore
	after aborted suspend
Date: Mon, 11 Aug 2014 14:15:35 +0300
Message-ID: <1407755738-31693-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9731D261A80
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 13:15:44 +0200 (CEST)
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

It was found that resuming active stream fails on Baytrail ADSP in case
of aborted suspend or when testing only partial suspend. Reason for
this is that in those cases ADSP doesn't reach reset even though resume
path is expecting so and fails to restart stream.

This revealed that suspend and resume phases do not go together:
Operating state is not the same after returning certain resume phase
than it was prior entering into corresponding suspend phase. Also we
unload firmware in suspend_late before putting ADSP into reset in
suspend_noirq when ADSP is actually already powered down.

Fix these by first rearranging and simplifying suspend/resume: Put ADSP
into reset in suspend_late and bring it back in resume_late. Now only
these will take care of ADSP reset and reboot and
SNDRV_PCM_TRIGGER_SUSPEND/SNDRV_PCM_TRIGGER_RESUME callbacks will take
care of stream stop/restart during suspend and resume phases.

Then modify stream resume so that full stream reallocation and restart
is done only if suspend_late was reached. Otherwise resume it by using
the IPC that resumes paused stream.

Jarkko Nikula (3):
  ASoC: Intel: Merge Baytrail ADSP suspend_noirq into suspend_late
  ASoC: Intel: Wait Baytrail ADSP boot at resume_early stage
  ASoC: Intel: Restore Baytrail ADSP streams only when ADSP was in reset

 sound/soc/intel/sst-baytrail-ipc.c | 10 +--------
 sound/soc/intel/sst-baytrail-ipc.h |  1 -
 sound/soc/intel/sst-baytrail-pcm.c | 43 +++++++++++++-------------------------
 3 files changed, 16 insertions(+), 38 deletions(-)

-- 
2.0.1

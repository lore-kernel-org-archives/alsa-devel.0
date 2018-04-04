From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH v4 0/3] ASoC: topology: Improve hw_configs
Date: Wed,  4 Apr 2018 06:19:36 +0200
Message-ID: <20180404041939.23317-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BC0726760A
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 06:19:13 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id u189so2269104wmd.1
 for <alsa-devel@alsa-project.org>; Tue, 03 Apr 2018 21:19:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Pan Xiuli <xiuli.pan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Kirill Marinushkin <k.marinushkin@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

This patch series waits since 20th of February, because it modifies UAPI headers
and should be done in sync with ALSA. I see that previously there was no clear
understanding, how to do this in sync.

Two days ago I discussed with Takashi, and he suggested the following steps:

Step 1. A person from Intel, who knows the topic (Pierre), adds his
"Reviewed-by" or "Acked-by" tags
Step 2. I clarify with you to apply the Linux part (this patch series)
Step 3. After that, I clarify with Takashi to apply the ALSA part (it is ready,
but not sent untill we apply the Linux part)

The step 1 is done. Old patches are reviewed by Pierre, so they have his
"Reviewed-by" tag. New patches are suggested by him, and we agreed on the
implementation, so they have his "Acked-by" tag.

Now we are on the step 2. If you don't have anything against this patch series,
please apply it to Linux.

Best Regards,
Kirill

Kirill Marinushkin (3):
  ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
  ASoC: topology: Add missing clock gating parameter when parsing
    hw_configs
  ASoC: topology: Add definitions for mclk_direction values

 include/uapi/sound/asoc.h | 29 +++++++++++++++++++++++++----
 sound/soc/soc-topology.c  | 19 ++++++++++++++-----
 2 files changed, 39 insertions(+), 9 deletions(-)

-- 
2.13.6

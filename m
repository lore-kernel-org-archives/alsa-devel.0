From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH v2 0/6] ASoC: Samsung: Fix build errors and
	warnings
Date: Wed, 22 Jan 2014 17:30:37 +0530
Message-ID: <1390392043-24387-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 253DA26501B
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 13:05:11 +0100 (CET)
Received: by mail-pb0-f53.google.com with SMTP id md12so299726pbc.12
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 04:05:10 -0800 (PST)
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
Cc: patches@linaro.org, sbkim73@samsung.com, lgirdwood@gmail.com, tiwai@suse.de, broonie@kernel.org, sachin.kamat@linaro.org
List-Id: alsa-devel@alsa-project.org

This series attempts to fix several build errors and warnings that
came up while building for different Samsung defconfigs. Some of these
could possibly be applied to stable kernels as well (like patch 2 & 6).
This series is based on latest linux-next and is build tested on various
Samsung configs.

Only change in v2 is that CONFIG_OF has been dropped in patch 6 as suggested
by reviewers. This made earlier patch 7 redundant and has been dropped in this
version of the series.

Sachin Kamat (6):
  ASoC: Samsung: Fix build regressions due to gpio re-org
  ASoC: Samsung: s3c-i2s-v2: Fix build error
  ASoC: Samsung: h1940_uda1380: Remove unused variable
  ASoC: Samsung: h1940_uda1380: Fix build warning
  ASoC: Samsung: rx1950_uda1380: Remove unused variable
  ASoC: Samsung: smdk_wm8994: Fix build error

 sound/soc/samsung/h1940_uda1380.c  |    4 ++--
 sound/soc/samsung/neo1973_wm8753.c |    1 +
 sound/soc/samsung/rx1950_uda1380.c |    2 +-
 sound/soc/samsung/s3c-i2s-v2.c     |    6 +++---
 sound/soc/samsung/s3c2412-i2s.c    |    2 ++
 sound/soc/samsung/s3c24xx-i2s.c    |    2 ++
 sound/soc/samsung/smartq_wm8987.c  |    1 +
 sound/soc/samsung/smdk_wm8994.c    |    4 +---
 8 files changed, 13 insertions(+), 9 deletions(-)

-- 
1.7.9.5

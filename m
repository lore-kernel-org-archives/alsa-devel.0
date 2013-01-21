From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 0/5] ASoC: tegra: Some fixes in codec files
Date: Mon, 21 Jan 2013 14:59:21 +0530
Message-ID: <1358760566-3803-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EE9C261734
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 10:38:11 +0100 (CET)
Received: by mail-pa0-f52.google.com with SMTP id fb1so3284265pad.25
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 01:38:10 -0800 (PST)
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
Cc: sachin.kamat@linaro.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, swarren@nvidia.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Compile tested using tegra_defconfig on the for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

Sachin Kamat (5):
  ASoC: tegra_wm9712: Remove __devinitconst attribute
  ASoC: tegra20_ac97: Remove __devinitconst attribute
  ASoC: tegra: Make 'ahub_auxdata' static
  ASoC: tegra: Use NULL instead of 0 for pointers
  ASoC: tegra: Staticize some functions in tegra30_i2s.c

 sound/soc/tegra/tegra20_ac97.c |    2 +-
 sound/soc/tegra/tegra30_ahub.c |    6 +++---
 sound/soc/tegra/tegra30_i2s.c  |    4 ++--
 sound/soc/tegra/tegra_wm9712.c |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
1.7.4.1

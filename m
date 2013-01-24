From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 0/4] ASoC: tegra: Some fixes in codec
	files
Date: Thu, 24 Jan 2013 14:51:14 +0530
Message-ID: <1359019278-1199-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DD802615CD
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 10:30:13 +0100 (CET)
Received: by mail-pa0-f46.google.com with SMTP id kp14so3990695pab.19
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 01:30:12 -0800 (PST)
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
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, swarren@nvidia.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Resending this series with Stephen Warren's 'Reviewed-by' tag and dropping
a patch as suggested by him.

Compile tested using tegra_defconfig on the for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git


Sachin Kamat (4):
  ASoC: tegra_wm9712: Remove __devinitconst attribute
  ASoC: tegra20_ac97: Remove __devinitconst attribute
  ASoC: tegra: Use NULL instead of 0 for pointers
  ASoC: tegra: Staticize some functions in tegra30_i2s.c

 sound/soc/tegra/tegra20_ac97.c |    2 +-
 sound/soc/tegra/tegra30_ahub.c |    4 ++--
 sound/soc/tegra/tegra30_i2s.c  |    4 ++--
 sound/soc/tegra/tegra_wm9712.c |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.7.4.1

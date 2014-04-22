From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ASoC: davinci:
	devm_snd_soc_register_platform and mcasp cleanup
Date: Tue, 22 Apr 2014 14:03:11 +0300
Message-ID: <1398164594-29169-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A80F261A92
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 13:03:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, daniel@zonque.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Now that we have resource managed version of snd_soc_register_platform() convert
the davinci ASoC code to use it.

Clean the mcasp driver's init code while we are here so we can remove the
platform driver's remove function since we now have managed resources only.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: davinci-pcm: Convert to use devm_snd_soc_register_platform()
  ASoC: davinci-mcasp: Convert to use devm_snd_soc_register_component()
  ASoC: davinci-mcasp: Optimize pm_runtime usage and clean up the init
    code

 sound/soc/davinci/davinci-i2s.c   |  1 -
 sound/soc/davinci/davinci-mcasp.c | 69 ++++++++++-----------------------------
 sound/soc/davinci/davinci-pcm.c   |  8 +----
 sound/soc/davinci/davinci-pcm.h   |  4 ---
 sound/soc/davinci/davinci-vcif.c  |  1 -
 5 files changed, 19 insertions(+), 64 deletions(-)

-- 
1.9.2

From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 0/3] To simplify the code for ASoC probe.
Date: Thu, 27 Feb 2014 17:49:50 +0800
Message-ID: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org


Xiubo Li (3):
  ASoC: io: Clean up snd_soc_codec_set_cache_io()
  ASoC: core: Set the default I/O up try regmap.
  ASoC: SGTL5000: Simplify ASoC probe code.

 sound/soc/codecs/sgtl5000.c | 8 --------
 sound/soc/soc-core.c        | 8 ++++----
 sound/soc/soc-io.c          | 5 -----
 3 files changed, 4 insertions(+), 17 deletions(-)

-- 
1.8.4

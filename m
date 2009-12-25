From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/3] ad1938: fix typo,
	rename mask to rx_mask for ad1938_set_tdm_slot
Date: Fri, 25 Dec 2009 14:10:07 +0800
Message-ID: <1261721408-16248-3-git-send-email-21cnbao@gmail.com>
References: <1261721408-16248-1-git-send-email-21cnbao@gmail.com>
	<1261721408-16248-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id A3A6F1037F2
	for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2009 07:10:21 +0100 (CET)
In-Reply-To: <1261721408-16248-2-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 sound/soc/codecs/ad1938.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ad1938.c b/sound/soc/codecs/ad1938.c
index 5d48918..735c356 100644
--- a/sound/soc/codecs/ad1938.c
+++ b/sound/soc/codecs/ad1938.c
@@ -145,7 +145,7 @@ static inline int ad1938_pll_powerctrl(struct snd_soc_codec *codec, int cmd)
 }
 
 static int ad1938_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
-			       unsigned int mask, int slots, int width)
+			       unsigned int rx_mask, int slots, int width)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	int dac_reg = codec->read(codec, AD1938_DAC_CTRL1);
-- 
1.5.6.3

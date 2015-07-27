From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] ASoC: wm8804: Drop dublicate const
Date: Mon, 27 Jul 2015 10:56:23 +0200
Message-ID: <1437987388-9706-2-git-send-email-lars@metafoo.de>
References: <1437987388-9706-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-193.synserver.de (smtp-out-193.synserver.de
 [212.40.185.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A46252606C2
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 10:56:35 +0200 (CEST)
In-Reply-To: <1437987388-9706-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Patrick Lai <plai@codeaurora.org>, patches@opensource.wolfsonmicro.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Max Filippov <jcmvbkbc@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

SOC_ENUM_SINGLE_DECL() already includes a const, drop the extra const.
Fixes the following sparse warning:

	sound/soc/codecs/wm8804.c:101:14: warning: duplicate const

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm8804.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index c195c2e..8d91470 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -98,7 +98,7 @@ WM8804_REGULATOR_EVENT(0)
 WM8804_REGULATOR_EVENT(1)
 
 static const char *txsrc_text[] = { "S/PDIF RX", "AIF" };
-static const SOC_ENUM_SINGLE_DECL(txsrc, WM8804_SPDTX4, 6, txsrc_text);
+static SOC_ENUM_SINGLE_DECL(txsrc, WM8804_SPDTX4, 6, txsrc_text);
 
 static const struct snd_kcontrol_new wm8804_tx_source_mux[] = {
 	SOC_DAPM_ENUM_EXT("Input Source", txsrc,
-- 
2.1.4

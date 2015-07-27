From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/6] ASoC: uniperf: Staticise local symbols
Date: Mon, 27 Jul 2015 10:56:27 +0200
Message-ID: <1437987388-9706-6-git-send-email-lars@metafoo.de>
References: <1437987388-9706-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-193.synserver.de (smtp-out-193.synserver.de
 [212.40.185.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66F7C261555
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 10:56:39 +0200 (CEST)
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

uni_player_dai_ops is not used outside of this file so it should be static.
Fixes the following sparse warning:

	sound/soc/sti/uniperif_player.c:959:30: warning: symbol
		'uni_player_dai_ops' was not declared. Should it be static?

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/sti/uniperif_player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index f609089..d8df906 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -956,7 +956,7 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 	return 0;
 }
 
-const struct snd_soc_dai_ops uni_player_dai_ops = {
+static const struct snd_soc_dai_ops uni_player_dai_ops = {
 		.startup = uni_player_startup,
 		.shutdown = uni_player_shutdown,
 		.prepare = uni_player_prepare,
-- 
2.1.4

From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/2] ASoC: simple-card: Read pin switches conf from devicetree
Date: Fri, 26 Apr 2019 04:25:50 +0200
Message-ID: <20190426022550.31359-2-paul@crapouillou.net>
References: <20190426022550.31359-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426022550.31359-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, od@zcrc.me, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

When the routing path between a widget (e.g. "Speaker") and the codec
goes through an external amplifier, having a pin switch for this widget
allows the amplifier to be disabled when the widget is not to be used
(e.g. when using headphones).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: - Rebase on top of for-next
        - Rename to asoc_simple_parse_pin_switches()

 sound/soc/generic/simple-card.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 335ead0cbb8a..9b568f578bcd 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -464,6 +464,10 @@ static int simple_parse_of(struct asoc_simple_priv *priv)
 	if (ret < 0)
 		return ret;
 
+	ret = asoc_simple_parse_pin_switches(card, PREFIX);
+	if (ret < 0)
+		return ret;
+
 	/* Single/Muti DAI link(s) & New style of DT node */
 	memset(&li, 0, sizeof(li));
 	for (li.cpu = 1; li.cpu >= 0; li.cpu--) {
-- 
2.21.0.593.g511ec345e18

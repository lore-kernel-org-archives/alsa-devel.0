From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/3] ASoC: simple-card: Read pin switches conf from devicetree
Date: Sat, 20 Apr 2019 12:45:53 +0200
Message-ID: <20190420104553.5071-3-paul@crapouillou.net>
References: <20190420104553.5071-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190420104553.5071-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

When the routing path between a widget (e.g. "Speaker") and the codec
goes through an external amplifier, having a pin switch for this widget
allows the amplifier to be disabled when the widget is not to be used
(e.g. when using headphones).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/generic/simple-card.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 34de32efc4c4..d34adb1518e7 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -556,6 +556,10 @@ static int simple_parse_of(struct simple_priv *priv)
 	if (ret < 0)
 		return ret;
 
+	ret = asoc_simple_card_of_parse_pin_switches(card, PREFIX);
+	if (ret < 0)
+		return ret;
+
 	/* Single/Muti DAI link(s) & New style of DT node */
 	memset(&li, 0, sizeof(li));
 	for (li.cpu = 1; li.cpu >= 0; li.cpu--) {
-- 
2.21.0.593.g511ec345e18

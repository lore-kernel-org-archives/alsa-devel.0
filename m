From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] ASoC: doc: simple-card: Add pin-switches property
Date: Sat, 20 Apr 2019 12:45:51 +0200
Message-ID: <20190420104553.5071-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

The simple-audio-card,pin-switches property can contain the list of
widget names for which pin switches must be created.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 4629c8f8a6b6..79954cd6e37b 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -24,6 +24,8 @@ Optional properties:
 					  a microphone is attached.
 - simple-audio-card,aux-devs		: List of phandles pointing to auxiliary devices, such
 					  as amplifiers, to be added to the sound card.
+- simple-audio-card,pin-switches	: List of strings containing the widget names for
+					  which pin switches must be created.
 
 Optional subnodes:
 
-- 
2.21.0.593.g511ec345e18

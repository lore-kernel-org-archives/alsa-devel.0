From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH] ASoC: dmaengine_pcm: set MODULE_LICENSE
Date: Thu, 22 Nov 2012 13:31:10 +0100
Message-ID: <1353587470-11994-5-git-send-email-LW@KARO-electronics.de>
References: <1353587470-11994-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353587470-11994-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 sound/soc/soc-dmaengine-pcm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pc=
m.c
index bbc1257..111b7d92 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -317,3 +317,5 @@ int snd_dmaengine_pcm_close(struct snd_pcm_substrea=
m *substream)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close);
+
+MODULE_LICENSE("GPL");
--=20
1.7.2.5

From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH RESEND] ASoC: ak4641: Remove unused codec field from struct
 ak4641_priv
Date: Wed, 19 Oct 2011 23:08:13 +0800
Message-ID: <1319036893.7741.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Harald Welte <laforge@gnumonks.org>, Philipp Zabel <philipp.zabel@gmail.com>, Dmitry Artamonow <mad_soft@inbox.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
Sorry. a typo in subject line. here is a resend.

 sound/soc/codecs/ak4641.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ak4641.c b/sound/soc/codecs/ak4641.c
index 7a64e58..f5125ae 100644
--- a/sound/soc/codecs/ak4641.c
+++ b/sound/soc/codecs/ak4641.c
@@ -31,7 +31,6 @@
 
 /* codec private data */
 struct ak4641_priv {
-	struct snd_soc_codec *codec;
 	unsigned int sysclk;
 	int deemph;
 	int playback_fs;
-- 
1.7.5.4

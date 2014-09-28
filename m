From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ASoC:kirkwood: Don't raise an error when no
	DAI format
Date: Sun, 28 Sep 2014 16:19:27 +0200
Message-ID: <20140928150313.85015260582@alsa0.perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 57B6926057C
 for <alsa-devel@alsa-project.org>; Sun, 28 Sep 2014 17:03:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The two DAIs of the kirkwood controller have a unique PCM format.

The simple-card sets the audio hardware definitions of all CPU DAIs.
The PCM format is defined only when it is present in the DT.

This patch prevents the controller to raise an error when
the DT audio card definition by the simple card contains the PCM
format of one CPU DAI only.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 0704cd6..26d5f85 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -45,6 +45,8 @@ static int kirkwood_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 	unsigned long value;
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case 0:
+		return 0;		/* already done (simple-card) */
 	case SND_SOC_DAIFMT_RIGHT_J:
 		mask = KIRKWOOD_I2S_CTL_RJ;
 		break;
-- 
2.1.1

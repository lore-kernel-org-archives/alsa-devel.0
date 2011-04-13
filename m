From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/8] ASoC: Add stub baseband link on Speyside
Date: Tue, 12 Apr 2011 23:06:10 -0700
Message-ID: <1302674771-17169-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B8881038B3
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 08:07:42 +0200 (CEST)
In-Reply-To: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Demonstrate the connection of a baseband to the system. We add a DAI for
the link to the baseband. This will become visible to the application
layer - audio should be started from the application layer using an
application such as this:

   http://opensource.wolfsonmicro.com/~gg/bluetooth-pcm/bluetooth_pcm.c

which starts up audio as for CPU based playback and record up to the point
where data is streamed.

Due to non-availability of baseband simulation hardware we reuse the
configuration for the CPU link with the CODEC acting as clock master,
allowing signals to be observed with a scope. A more standard system
would have separate configuration for the baseband with its own ops
structure and operations. Normally the baseband would be clock master
as the baseband audio will be synchronised to the external telephony
network.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index e171a32..a0c14a8 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -164,6 +164,15 @@ static struct snd_soc_dai_link speyside_dai[] = {
 		.init = speyside_wm8915_init,
 		.ops = &speyside_ops,
 	},
+	{
+		.name = "Baseband",
+		.stream_name = "Baseband",
+		.cpu_dai_name = "wm8915-aif2",
+		.codec_dai_name = "wm1250-ev1",
+		.codec_name = "wm1250-ev1.1-0027",
+		.platform_name = "samsung-audio",
+		.ops = &speyside_ops,
+	},
 };
 
 static int speyside_wm9081_init(struct snd_soc_dapm_context *dapm)
@@ -194,6 +203,8 @@ static const struct snd_kcontrol_new controls[] = {
 	SOC_DAPM_PIN_SWITCH("Main Speaker"),
 	SOC_DAPM_PIN_SWITCH("Main DMIC"),
 	SOC_DAPM_PIN_SWITCH("Main AMIC"),
+	SOC_DAPM_PIN_SWITCH("WM1250 Input"),
+	SOC_DAPM_PIN_SWITCH("WM1250 Output"),
 };
 
 static struct snd_soc_dapm_widget widgets[] = {
-- 
1.7.4.1

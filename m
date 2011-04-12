From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: JZ4740: qi_lb60: Use the
	SND_SOC_DAPM_EVENT_OFF for the speakers status
Date: Tue, 12 Apr 2011 19:31:05 +0200
Message-ID: <1302629465-21315-5-git-send-email-lars@metafoo.de>
References: <1302629465-21315-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-049.synserver.de (smtp-out-051.synserver.de
	[212.40.185.51]) by alsa0.perex.cz (Postfix) with SMTP id 3C2FA103831
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 19:30:42 +0200 (CEST)
In-Reply-To: <1302629465-21315-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use SND_SOC_DAPM_EVENT_OFF for determining whether the speaker should be turned
on or off instead of open coding it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/qi_lb60.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index 8c4e84b..c5fc339 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -27,11 +27,7 @@
 static int qi_lb60_spk_event(struct snd_soc_dapm_widget *widget,
 			     struct snd_kcontrol *ctrl, int event)
 {
-	int on = 0;
-	if (event & SND_SOC_DAPM_POST_PMU)
-		on = 1;
-	else if (event & SND_SOC_DAPM_PRE_PMD)
-		on = 0;
+	int on = !SND_SOC_DAPM_EVENT_OFF(event);
 
 	gpio_set_value(QI_LB60_SND_GPIO, on);
 	gpio_set_value(QI_LB60_AMP_GPIO, on);
-- 
1.7.2.5

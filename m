From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 2.6.38] ASoC: Fix build error caused by merging a
	fix for 2.6.37 into 2.6.38
Date: Fri, 10 Dec 2010 20:54:49 +0200
Message-ID: <1292007289-22124-1-git-send-email-jhnikula@gmail.com>
References: <1292007235-22090-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E6DAC245D6
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 19:53:40 +0100 (CET)
Received: by eyg24 with SMTP id 24so2543433eyg.24
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 10:53:37 -0800 (PST)
In-Reply-To: <1292007235-22090-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Fix "ASoC: Fix bias power down of non-DAPM codec" for 3.6.37 will cause a
build error when merging into ASoC for-2.6.38. Fix the issue by doing a
change that commit ce6120c "ASoC: Decouple DAPM from CODECs" would do.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Ideally this would be squashed in ce6120c "ASoC: Decouple DAPM from CODECs".
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 45e6a11..b521a13 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -982,7 +982,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			sys_power = 1;
 			break;
 		case SND_SOC_DAPM_STREAM_STOP:
-			sys_power = !!codec->active;
+			sys_power = !!dapm->codec->active;
 			break;
 		case SND_SOC_DAPM_STREAM_SUSPEND:
 			sys_power = 0;
-- 
1.7.2.3

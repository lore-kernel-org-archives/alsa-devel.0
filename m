From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/12] ASoC: SSM2602: Fix 'Mic Boost2' control
Date: Thu,  5 May 2011 16:59:16 +0200
Message-ID: <1304607560-15083-8-git-send-email-lars@metafoo.de>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with SMTP id 017F81039F5
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 16:59:46 +0200 (CEST)
In-Reply-To: <1304607560-15083-1-git-send-email-lars@metafoo.de>
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
Cc: device-driver-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

The 'Mic Boost2' control's shift was off by one and thus was not working.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 9ce792b..c6dc0da 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -91,7 +91,7 @@ SOC_DOUBLE_R("Capture Volume", SSM2602_LINVOL, SSM2602_RINVOL, 0, 31, 0),
 SOC_DOUBLE_R("Capture Switch", SSM2602_LINVOL, SSM2602_RINVOL, 7, 1, 1),
 
 SOC_SINGLE("Mic Boost (+20dB)", SSM2602_APANA, 0, 1, 0),
-SOC_SINGLE("Mic Boost2 (+20dB)", SSM2602_APANA, 7, 1, 0),
+SOC_SINGLE("Mic Boost2 (+20dB)", SSM2602_APANA, 8, 1, 0),
 SOC_SINGLE("Mic Switch", SSM2602_APANA, 1, 1, 1),
 
 SOC_SINGLE("Sidetone Playback Volume", SSM2602_APANA, 6, 3, 1),
-- 
1.7.2.5

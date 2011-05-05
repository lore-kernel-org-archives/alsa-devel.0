From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/12] ASoC: SSM2602: Remove duplicate control
Date: Thu,  5 May 2011 16:59:11 +0200
Message-ID: <1304607560-15083-3-git-send-email-lars@metafoo.de>
References: <1304607560-15083-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with SMTP id 1EEAF103A0A
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 16:59:43 +0200 (CEST)
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

There are currently two controls which allow selecting the capture source, one
as a normal control, the other as part of a DAPM_MUX widget.
Remove the normal control.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index d536820..02390dd 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -99,8 +99,6 @@ SOC_SINGLE("Sidetone Playback Volume", SSM2602_APANA, 6, 3, 1),
 SOC_SINGLE("ADC High Pass Filter Switch", SSM2602_APDIGI, 0, 1, 1),
 SOC_SINGLE("Store DC Offset Switch", SSM2602_APDIGI, 4, 1, 0),
 
-SOC_ENUM("Capture Source", ssm2602_enum[0]),
-
 SOC_ENUM("Playback De-emphasis", ssm2602_enum[1]),
 };
 
-- 
1.7.2.5

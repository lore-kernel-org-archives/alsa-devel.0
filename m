From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: Swap bias level enumeration
Date: Tue, 31 Aug 2010 14:52:35 +0300
Message-ID: <1283255555-1547-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FAF31037F3
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 13:57:48 +0200 (CEST)
Received: by ewy21 with SMTP id 21so3521741ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2010 04:57:47 -0700 (PDT)
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

Swapping the bias level enumeration is only meant to help debugging. It is
easier if number 0 means bias off and bigger number means bigger bias level.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d31e8b7..493b3a4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -214,10 +214,10 @@
  * @OFF:     Power Off. No restrictions on transition times.
  */
 enum snd_soc_bias_level {
-	SND_SOC_BIAS_ON,
-	SND_SOC_BIAS_PREPARE,
-	SND_SOC_BIAS_STANDBY,
 	SND_SOC_BIAS_OFF,
+	SND_SOC_BIAS_STANDBY,
+	SND_SOC_BIAS_PREPARE,
+	SND_SOC_BIAS_ON,
 };
 
 struct snd_jack;
-- 
1.7.1

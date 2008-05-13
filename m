From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 2.6.26-rc2] ASoC: Fix wrong enum count for
	jack_function in N810 machine driver
Date: Tue, 13 May 2008 15:42:04 +0300
Message-ID: <1210682524-13966-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id AC8BA24AFE
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 14:41:54 +0200 (CEST)
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m4DCffK4031330
	for <alsa-devel@alsa-project.org>; Tue, 13 May 2008 15:41:53 +0300
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Fix this typo and avoid similar errors by using ARRAY_SIZE macro.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/n810.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 83b1eb4..6533563 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -188,8 +188,8 @@ static const char *audio_map[][3] = {
 static const char *spk_function[] = {"Off", "On"};
 static const char *jack_function[] = {"Off", "Headphone"};
 static const struct soc_enum n810_enum[] = {
-	SOC_ENUM_SINGLE_EXT(2, spk_function),
-	SOC_ENUM_SINGLE_EXT(3, jack_function),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(spk_function), spk_function),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(jack_function), jack_function),
 };
 
 static const struct snd_kcontrol_new aic33_n810_controls[] = {
-- 
1.5.5.1

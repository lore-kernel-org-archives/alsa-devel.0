From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH v2 01/12] ASoC: alc5632: Coding style. Remove
	two extra empty lines.
Date: Sat, 11 Feb 2012 23:26:27 +0200
Message-ID: <1328995598-8788-2-git-send-email-leon@leon.nu>
References: <1328995598-8788-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E0B371039EA
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:26:50 +0100 (CET)
Received: by eekd49 with SMTP id d49so1256798eek.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:26:50 -0800 (PST)
In-Reply-To: <1328995598-8788-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Andrey Danin <danindrey@mail.ru>, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

From: Andrey Danin <danindrey@mail.ru>

Signed-off-by: Andrey Danin <danindrey@mail.ru>
Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index f69fb42..0d574aa 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -437,8 +437,6 @@ static const struct snd_soc_dapm_route alc5632_dapm_routes[] = {
 	{"Speaker Mix", "MIC22SPK Playback Switch",	"MIC2 PGA"},
 	{"Speaker Mix", "DAC2SPK Playback Switch",	"DAC Left Channel"},
 
-
-
 	/* mono mixer */
 	{"Mono Mix", "ADC2MONO_L Playback Switch",	"Left Capture Mix"},
 	{"Mono Mix", "ADC2MONO_R Playback Switch",	"Right Capture Mix"},
-- 
1.7.3.4

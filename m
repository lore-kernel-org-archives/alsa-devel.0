From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH v2 05/12] ASoC: alc5632: Remove unexisting
	route from Phone Mix to Mono Mix
Date: Sat, 11 Feb 2012 23:26:31 +0200
Message-ID: <1328995598-8788-6-git-send-email-leon@leon.nu>
References: <1328995598-8788-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B062B103A6E
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:26:58 +0100 (CET)
Received: by mail-ey0-f179.google.com with SMTP id n11so1209112eaa.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:26:58 -0800 (PST)
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

There is no Phone Mix<->Mono Mix route in datasheet.

Signed-off-by: Andrey Danin <danindrey@mail.ru>
Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index d56218f..11da806 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -443,7 +443,6 @@ static const struct snd_soc_dapm_route alc5632_dapm_routes[] = {
 	{"Mono Mix", "ADC2MONO_L Playback Switch",	"Left Capture Mix"},
 	{"Mono Mix", "ADC2MONO_R Playback Switch",	"Right Capture Mix"},
 	{"Mono Mix", "LI2MONO Playback Switch",		"Line Mix"},
-	{"Mono Mix", "VOICE2MONO Playback Switch",	"Phone Mix"},
 	{"Mono Mix", "MIC12MONO Playback Switch",	"MIC1 PGA"},
 	{"Mono Mix", "MIC22MONO Playback Switch",	"MIC2 PGA"},
 	{"Mono Mix", "DAC2MONO Playback Switch",	"DAC Left Channel"},
-- 
1.7.3.4

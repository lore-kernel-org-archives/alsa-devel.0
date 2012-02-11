From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 09/12] ASoC: alc5632: Connect HP/HPL/HPR mix'es
	to HPOut Mix
Date: Sat, 11 Feb 2012 23:10:42 +0200
Message-ID: <1328994645-8237-10-git-send-email-leon@leon.nu>
References: <1328994645-8237-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CDAD11039F3
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:11:24 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d49so1252422eek.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:11:24 -0800 (PST)
In-Reply-To: <1328994645-8237-1-git-send-email-leon@leon.nu>
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
Cc: Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

From: Andrey Danin <danindrey@mail.ru>

This patch should fix output through speakers using HP mixer.

Signed-off-by: Andrey Danin <danindrey@mail.ru>
---
 sound/soc/codecs/alc5632.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 1fdec23..1002fb9 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -482,6 +482,9 @@ static const struct snd_soc_dapm_route alc5632_dapm_routes[] = {
 	{"HP Mix", "VOICE2HP Playback Switch",	"Voice Mix"},
 	{"HPR Mix", "DACR2HP Playback Switch",	"DAC Right Channel"},
 	{"HPL Mix", "DACL2HP Playback Switch",	"DAC Left Channel"},
+	{"HPOut Mix", NULL, "HP Mix"},
+	{"HPOut Mix", NULL, "HPR Mix"},
+	{"HPOut Mix", NULL, "HPL Mix"},
 
 	/* speaker mixer */
 	{"Speaker Mix", "LI2SPK Playback Switch",	"Line Mix"},
-- 
1.7.3.4

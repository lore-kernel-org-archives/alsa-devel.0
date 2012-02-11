From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH v2 12/12] ASoC: alc5632: Allow 8kHz stream
	support.
Date: Sat, 11 Feb 2012 23:26:38 +0200
Message-ID: <1328995598-8788-13-git-send-email-leon@leon.nu>
References: <1328995598-8788-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BB22103A79
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:27:13 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d49so1256798eek.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:27:13 -0800 (PST)
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
 sound/soc/codecs/alc5632.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index b347611..e2111e0 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -788,6 +788,7 @@ static int alc5632_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	struct alc5632_priv *alc5632 = snd_soc_codec_get_drvdata(codec);
 
 	switch (freq) {
+	case  4096000:
 	case  8192000:
 	case 11289600:
 	case 12288000:
-- 
1.7.3.4

From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 2/2] ASoC: Remove unnecessary backslash from
	alc5632 codec.
Date: Thu, 10 Nov 2011 21:22:16 +0200
Message-ID: <1320952936-14935-2-git-send-email-leon@leon.nu>
References: <1320952936-14935-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 4D3FA2447A
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 20:22:45 +0100 (CET)
Received: by mail-fx0-f51.google.com with SMTP id a20so3435967faa.38
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 11:22:45 -0800 (PST)
In-Reply-To: <1320952936-14935-1-git-send-email-leon@leon.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Leon Romanovsky <leon@leon.nu>
---
 sound/soc/codecs/alc5632.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
index 0fff98e..e6e63d24 100644
--- a/sound/soc/codecs/alc5632.c
+++ b/sound/soc/codecs/alc5632.c
@@ -811,7 +811,7 @@ static int alc5632_pcm_hw_params(struct snd_pcm_substream *substream,
 static int alc5632_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 hp_mute = ALC5632_MISC_HP_DEPOP_MUTE_L \
+	u16 hp_mute = ALC5632_MISC_HP_DEPOP_MUTE_L
 						|ALC5632_MISC_HP_DEPOP_MUTE_R;
 	u16 mute_reg = snd_soc_read(codec, ALC5632_MISC_CTRL) & ~hp_mute;
 
-- 
1.7.3.4

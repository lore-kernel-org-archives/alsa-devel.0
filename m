From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 012/102] ASoC: wm8804: Remove superfluous const
Date: Tue, 18 Feb 2014 12:32:24 +0100
Message-ID: <1392723148-12597-10-git-send-email-tiwai@suse.de>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 98402265494
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:32:33 +0100 (CET)
In-Reply-To: <1392723148-12597-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
reduce const from its users.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8804.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 9bc8206a6807..72d12bbe1a56 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -92,7 +92,7 @@ WM8804_REGULATOR_EVENT(0)
 WM8804_REGULATOR_EVENT(1)
 
 static const char *txsrc_text[] = { "S/PDIF RX", "AIF" };
-static const SOC_ENUM_SINGLE_EXT_DECL(txsrc, txsrc_text);
+static SOC_ENUM_SINGLE_EXT_DECL(txsrc, txsrc_text);
 
 static const struct snd_kcontrol_new wm8804_snd_controls[] = {
 	SOC_ENUM_EXT("Input Source", txsrc, txsrc_get, txsrc_put),
-- 
1.8.5.2

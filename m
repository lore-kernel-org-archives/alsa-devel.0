From: John Hsu <KCHSU0@nuvoton.com>
Subject: [PATCH] ASoC: nau8810: fix compile warning in loopback
	switch control
Date: Tue, 23 Aug 2016 16:02:49 +0800
Message-ID: <1471939369-4835-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AED2266ABA
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 10:03:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: sfr@canb.auug.org.au, alsa-devel@alsa-project.org, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Thank Stephen Rothwell for the message.
The patch is to fix the following compile error.
 
sound/soc/codecs/nau8810.c:441:3: error: initialization from incompatible
pointer type [-Werror=incompatible-pointer-types]
SND_SOC_DAPM_SWITCH("Digital Loopback", SND_SOC_NOPM, 0, 0,
&nau8810_loopback),
^
sound/soc/codecs/nau8810.c:441:3: note: (near initialization for 
'nau8810_dapm_widgets[11].kcontrol_news')

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
---
 sound/soc/codecs/nau8810.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index 7617dda..f9bcdc3 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -391,10 +391,9 @@ static const struct snd_kcontrol_new nau8810_mic_boost_controls =
 		NAU8810_PMICBSTGAIN_SFT, 0x7, 0);
 
 /* Loopback Switch */
-static const struct snd_kcontrol_new nau8810_loopback[] = {
+static const struct snd_kcontrol_new nau8810_loopback =
 	SOC_DAPM_SINGLE("Switch", NAU8810_REG_COMP,
-		NAU8810_ADDAP_SFT, 1, 0),
-};
+		NAU8810_ADDAP_SFT, 1, 0);
 
 static int check_mclk_select_pll(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
-- 
2.6.4

From: Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH 3/4] cs42l52: fix bogus shifts in "Speaker
	Volume" and "PCM Mixer Volume" controls.
Date: Wed, 22 May 2013 19:19:26 +0200
Message-ID: <1369243167-28700-4-git-send-email-nschichan@freebox.fr>
References: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BA8E2608B7
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 19:19:59 +0200 (CEST)
In-Reply-To: <1369243167-28700-1-git-send-email-nschichan@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Nicolas Schichan <nschichan@freebox.fr>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 sound/soc/codecs/cs42l52.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index d2ee37d..06c6025 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -413,7 +413,7 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
 	SOC_ENUM("Headphone Analog Gain", hp_gain_enum),
 
 	SOC_DOUBLE_R_SX_TLV("Speaker Volume", CS42L52_SPKA_VOL,
-			      CS42L52_SPKB_VOL, 7, 0x1, 0xff, hl_tlv),
+			      CS42L52_SPKB_VOL, 0, 0x1, 0xff, hl_tlv),
 
 	SOC_DOUBLE_R_SX_TLV("Bypass Volume", CS42L52_PASSTHRUA_VOL,
 			      CS42L52_PASSTHRUB_VOL, 6, 0x18, 0x90, pga_tlv),
@@ -441,7 +441,7 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
 
 	SOC_DOUBLE_R_SX_TLV("PCM Mixer Volume",
 			    CS42L52_PCMA_MIXER_VOL, CS42L52_PCMB_MIXER_VOL,
-				6, 0x7f, 0x19, hl_tlv),
+				0, 0x7f, 0x19, hl_tlv),
 	SOC_DOUBLE_R("PCM Mixer Switch",
 		     CS42L52_PCMA_MIXER_VOL, CS42L52_PCMB_MIXER_VOL, 7, 1, 1),
 
-- 
1.7.10.4

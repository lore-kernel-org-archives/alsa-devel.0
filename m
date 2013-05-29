From: Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH 1/2] ASoC: cs42l52: use correct PCM mixer TLV
	dB scale to match datasheet.
Date: Wed, 29 May 2013 20:01:19 +0200
Message-ID: <1369850480-1772-2-git-send-email-nschichan@freebox.fr>
References: <1369850480-1772-1-git-send-email-nschichan@freebox.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BB92264FE3
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 20:01:41 +0200 (CEST)
In-Reply-To: <1369850480-1772-1-git-send-email-nschichan@freebox.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolas Schichan <nschichan@freebox.fr>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
---
 sound/soc/codecs/cs42l52.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 030f53c..756c204 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -193,6 +193,8 @@ static DECLARE_TLV_DB_SCALE(mic_tlv, 1600, 100, 0);
 
 static DECLARE_TLV_DB_SCALE(pga_tlv, -600, 50, 0);
 
+static DECLARE_TLV_DB_SCALE(mix_tlv, -50, 50, 0);
+
 static const unsigned int limiter_tlv[] = {
 	TLV_DB_RANGE_HEAD(2),
 	0, 2, TLV_DB_SCALE_ITEM(-3000, 600, 0),
@@ -441,7 +443,7 @@ static const struct snd_kcontrol_new cs42l52_snd_controls[] = {
 
 	SOC_DOUBLE_R_SX_TLV("PCM Mixer Volume",
 			    CS42L52_PCMA_MIXER_VOL, CS42L52_PCMB_MIXER_VOL,
-				0, 0x7f, 0x19, hl_tlv),
+				0, 0x7f, 0x19, mix_tlv),
 	SOC_DOUBLE_R("PCM Mixer Switch",
 		     CS42L52_PCMA_MIXER_VOL, CS42L52_PCMB_MIXER_VOL, 7, 1, 1),
 
-- 
1.7.10.4

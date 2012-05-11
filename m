From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH] ASoC: cs42l73: Sync digital mixer kcontrols to
	allow for 0dB
Date: Fri, 11 May 2012 12:54:45 -0500
Message-ID: <1336758885-5830-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe005.messaging.microsoft.com [216.32.180.31])
	by alsa0.perex.cz (Postfix) with ESMTP id A4F90104789
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 19:57:48 +0200 (CEST)
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
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Some of the Digital mixer kcontrol max values were off by 1 not allowing a max of 0dB.

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l73.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 5a537b7..e0d45fd 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -565,22 +565,22 @@ static const struct snd_kcontrol_new cs42l73_snd_controls[] = {
 			attn_tlv),
 
 	SOC_SINGLE_TLV("SPK-IP Mono Volume",
-			CS42L73_SPKMIPMA, 0, 0x3E, 1, attn_tlv),
+			CS42L73_SPKMIPMA, 0, 0x3F, 1, attn_tlv),
 	SOC_SINGLE_TLV("SPK-XSP Mono Volume",
-			CS42L73_SPKMXSPA, 0, 0x3E, 1, attn_tlv),
+			CS42L73_SPKMXSPA, 0, 0x3F, 1, attn_tlv),
 	SOC_SINGLE_TLV("SPK-ASP Mono Volume",
-			CS42L73_SPKMASPA, 0, 0x3E, 1, attn_tlv),
+			CS42L73_SPKMASPA, 0, 0x3F, 1, attn_tlv),
 	SOC_SINGLE_TLV("SPK-VSP Mono Volume",
-			CS42L73_SPKMVSPMA, 0, 0x3E, 1, attn_tlv),
+			CS42L73_SPKMVSPMA, 0, 0x3F, 1, attn_tlv),
 
 	SOC_SINGLE_TLV("ESL-IP Mono Volume",
-			CS42L73_ESLMIPMA, 0, 0x3E, 1, attn_tlv),
+			CS42L73_ESLMIPMA, 0, 0x3F, 1, attn_tlv),
 	SOC_SINGLE_TLV("ESL-XSP Mono Volume",
-			CS42L73_ESLMXSPA, 0, 0x3E, 1, attn_tlv),
+			CS42L73_ESLMXSPA, 0, 0x3F, 1, attn_tlv),
 	SOC_SINGLE_TLV("ESL-ASP Mono Volume",
-			CS42L73_ESLMASPA, 0, 0x3E, 1, attn_tlv),
+			CS42L73_ESLMASPA, 0, 0x3F, 1, attn_tlv),
 	SOC_SINGLE_TLV("ESL-VSP Mono Volume",
-			CS42L73_ESLMVSPMA, 0, 0x3E, 1, attn_tlv),
+			CS42L73_ESLMVSPMA, 0, 0x3F, 1, attn_tlv),
 
 	SOC_ENUM("IP Digital Swap/Mono Select", ip_swap_enum),
 
-- 
1.7.10

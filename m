From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 021/102] ASoC: ssm2602: Omit superfluous
	elements in input select array
Date: Tue, 18 Feb 2014 12:36:56 +0100
Message-ID: <1392723422-12689-6-git-send-email-tiwai@suse.de>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3647B265588
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:37:06 +0100 (CET)
In-Reply-To: <1392723422-12689-1-git-send-email-tiwai@suse.de>
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

The array contains too many elements although it should have only
two.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/ssm2602.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index f444d585b916..e32b82ff6304 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -75,15 +75,16 @@ static const u16 ssm2602_reg[SSM2602_CACHEREGNUM] = {
 
 /*Appending several "None"s just for OSS mixer use*/
 static const char *ssm2602_input_select[] = {
-	"Line", "Mic", "None", "None", "None",
-	"None", "None", "None",
+	"Line", "Mic",
 };
 
 static const char *ssm2602_deemph[] = {"None", "32Khz", "44.1Khz", "48Khz"};
 
 static const struct soc_enum ssm2602_enum[] = {
-	SOC_ENUM_SINGLE(SSM2602_APANA, 2, 2, ssm2602_input_select),
-	SOC_ENUM_SINGLE(SSM2602_APDIGI, 1, 4, ssm2602_deemph),
+	SOC_ENUM_SINGLE(SSM2602_APANA, 2, ARRAY_SIZE(ssm2602_input_select),
+			ssm2602_input_select),
+	SOC_ENUM_SINGLE(SSM2602_APDIGI, 1, ARRAY_SIZE(ssm2602_deemph),
+			ssm2602_deemph),
 };
 
 static const unsigned int ssm260x_outmix_tlv[] = {
-- 
1.8.5.2

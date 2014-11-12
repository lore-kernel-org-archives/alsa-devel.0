From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Add support for 768kHz DMIC
	operation
Date: Wed, 12 Nov 2014 14:55:26 +0000
Message-ID: <1415804126-19168-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 698682657F3
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 16:03:04 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The new IPs supports a new lower frequency 768kHz DMIC operation
add support for this into the OSR control.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 730636c..1e352d8 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -648,7 +648,7 @@ SOC_ENUM_SINGLE_DECL(arizona_in_hpf_cut_enum,
 EXPORT_SYMBOL_GPL(arizona_in_hpf_cut_enum);
 
 static const char * const arizona_in_dmic_osr_text[] = {
-	"1.536MHz", "3.072MHz", "6.144MHz",
+	"1.536MHz", "3.072MHz", "6.144MHz", "768kHz",
 };
 
 const struct soc_enum arizona_in_dmic_osr[] = {
-- 
1.7.2.5

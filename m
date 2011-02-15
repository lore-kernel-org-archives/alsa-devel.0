From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 3/5] ASoC: sn95031: fix the amic tlv scale
Date: Tue, 15 Feb 2011 18:28:53 +0530
Message-ID: <1297774735-32184-4-git-send-email-vinod.koul@intel.com>
References: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 89D56103851
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 13:50:09 +0100 (CET)
In-Reply-To: <1297774735-32184-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@opensource.wolfsonmicro.com, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

The tlv scale is defined as (min, step, mute). The mute is not supported here so
put the value to 0

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/codecs/sn95031.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 5eb39c7..2a30eae 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -359,7 +359,7 @@ static const struct snd_kcontrol_new sn95031_input4_mux_control =
 static const char *sn95031_micmode_text[] = {"Single Ended", "Differential"};
 
 /* 0dB to 30dB in 10dB steps */
-static const DECLARE_TLV_DB_SCALE(mic_tlv, 0, 10, 30);
+static const DECLARE_TLV_DB_SCALE(mic_tlv, 0, 10, 0);
 
 static const struct soc_enum sn95031_micmode1_enum =
 	SOC_ENUM_SINGLE(SN95031_MICAMP1, 1, 2, sn95031_micmode_text);
-- 
1.7.2.3

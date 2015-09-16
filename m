From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: arizona: Add default cases for event
	switches
Date: Wed, 16 Sep 2015 13:59:40 +0100
Message-ID: <1442408383-31682-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 0576D261518
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 15:23:19 +0200 (CEST)
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

Since the addition of the WILL_PMU / WILL_PMD several of the switches in
arizona.c no longer cover all cases or have a default case. Whilst this
isn't causing any problems in the interests of robustness add default
cases.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 8a2221a..1bc19f1 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -147,6 +147,8 @@ static int arizona_spk_ev(struct snd_soc_dapm_widget *w,
 						   0x4f5, 0x0da);
 		}
 		break;
+	default:
+		break;
 	}
 
 	return 0;
@@ -725,6 +727,9 @@ int arizona_in_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
 		reg = snd_soc_read(codec, ARIZONA_INPUT_ENABLES);
 		if (reg == 0)
 			arizona_in_set_vu(codec, 0);
+		break;
+	default:
+		break;
 	}
 
 	return 0;
@@ -806,6 +811,8 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			break;
 		}
 		break;
+	default:
+		break;
 	}
 
 	return 0;
-- 
1.7.2.5

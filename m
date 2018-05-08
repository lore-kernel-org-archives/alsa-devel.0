From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 13/19] ASoC: Intel: bytcr_rt5640: Change BYTCR
	default input to IN3
Date: Tue,  8 May 2018 17:35:58 +0200
Message-ID: <20180508153604.23711-14-hdegoede@redhat.com>
References: <20180508153604.23711-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 73376267715
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 17:36:28 +0200 (CEST)
In-Reply-To: <20180508153604.23711-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Out of the 11 BYTCR devices which I have access to for testing,
7 use IN3 for the internal mic and only 1 uses IN1 for the internal mic,
the other 3 use DMIC1.

So IN3 clearly is a better default, using IN3 as default avoids the need
to add DMI quirks for some of these devices.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 6be4e8972010..bc0b85ec0b16 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -975,7 +975,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		}
 
 		/* change defaults for Baytrail-CR capture */
-		byt_rt5640_quirk |= BYT_RT5640_IN1_MAP;
+		byt_rt5640_quirk |= BYT_RT5640_IN3_MAP;
 		byt_rt5640_quirk |= BYT_RT5640_DIFF_MIC;
 	} else {
 		byt_rt5640_quirk |= BYT_RT5640_DMIC1_MAP;
-- 
2.17.0

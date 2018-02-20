From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 11/11] ASoC: Intel: bytcr_rt5651: Add quirk for
	the VIOS LTH17 laptop
Date: Tue, 20 Feb 2018 23:15:11 +0100
Message-ID: <20180220221511.22861-11-hdegoede@redhat.com>
References: <20180220221511.22861-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id D417C26752D
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 23:15:34 +0100 (CET)
In-Reply-To: <20180220221511.22861-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Add a quirk setting up jack-detect and input routing for the
VIOS LTH17 laptop.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index c14c5940ff87..c4260ca3cbed 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -398,6 +398,19 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 					BYT_RT5651_OVCD_SF_0P75 |
 					BYT_RT5651_IN2_HS_IN3_MAP),
 	},
+	{
+		/* VIOS LTH17 */
+		.callback = byt_rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "VIOS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LTH17"),
+		},
+		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
+					BYT_RT5651_JD1_1 |
+					BYT_RT5651_OVTH_2000UA |
+					BYT_RT5651_OVCD_SF_1P0 |
+					BYT_RT5651_IN1_IN2_MAP),
+	},
 	{}
 };
 
-- 
2.14.3

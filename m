From: Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/2] ASoC: Intel: bytcr_rt5640: Add quirks for
	ASUS MeMO Pad 7 (ME176C)
Date: Sat, 22 Dec 2018 15:47:12 +0100
Message-ID: <20181222144708.121732-2-stephan@gerhold.net>
References: <20181222144708.121732-1-stephan@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A3FE267AD1
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2018 15:52:22 +0100 (CET)
In-Reply-To: <20181222144708.121732-1-stephan@gerhold.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Stephan Gerhold <stephan@gerhold.net>
List-Id: alsa-devel@alsa-project.org

Add quirks to select the correct input map, jack-detect options
and channel map to make sound work on the ASUS MeMO Pad 7 (ME176C).

Note: Although sound works out of the box, jack detection currently
requires overriding the ACPI DSDT table. This is necessary because
the rt5640 ACPI device (10EC5640) has the wrong GPIO listed as
interrupt (one of the Bluetooth GPIOs).
The correct GPIO is GPO2 0x0004 (listed as the first GPIO in the
Intel(R) Audio Machine Driver - AMCR0F28 device).

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index a22366ce33c4..ca8b4d5ff70f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -428,6 +428,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ME176C"),
+		},
+		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-- 
2.20.1

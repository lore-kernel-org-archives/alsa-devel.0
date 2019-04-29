From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ASoC: rt5645: Headphone Jack sense inverts on
	the LattePanda board
Date: Mon, 29 Apr 2019 11:44:07 +0800
Message-ID: <20190429034407.8324-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A98FCF806E7
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2019 05:44:27 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The LattePanda board has a sound card chtrt5645, when there is nothing
plugged in the headphone jack, the system thinks the headphone is
plugged in, while we plug a headphone in the jack, the system thinks
the headphone is unplugged.

If adding quirk=0x21 in the module parameter, the headphone jack can
work well. So let us fix it via platform_data.

https://bugs.launchpad.net/bugs/182459
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/soc/codecs/rt5645.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9a0751978090..a6064606424a 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3631,6 +3631,11 @@ static const struct rt5645_platform_data jd_mode3_platform_data = {
 	.jd_mode = 3,
 };
 
+static const struct rt5645_platform_data lattepanda_board_platform_data = {
+	.jd_mode = 2,
+	.inv_jd1_1 = true
+};
+
 static const struct dmi_system_id dmi_platform_data[] = {
 	{
 		.ident = "Chrome Buddy",
@@ -3728,6 +3733,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&intel_braswell_platform_data,
 	},
+	{
+		.ident = "LattePanda board",
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+		  DMI_EXACT_MATCH(DMI_BOARD_VERSION, "Default string"),
+		},
+		.driver_data = (void *)&lattepanda_board_platform_data,
+	},
 	{ }
 };
 
-- 
2.17.1

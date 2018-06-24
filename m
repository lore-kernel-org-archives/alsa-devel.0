From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/9] ASoC: Intel: bytcr_rt5651: Change default
	input map from in2 to in1
Date: Sun, 24 Jun 2018 16:06:27 +0200
Message-ID: <20180624140634.16835-3-hdegoede@redhat.com>
References: <20180624140634.16835-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id E100D2676F7
 for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2018 16:06:42 +0200 (CEST)
In-Reply-To: <20180624140634.16835-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Further testing on all 6 model x86 tablets with a rt5651 which I have
access to for testing has shown that their single (mono) microphone is
connected to both IN1 *and* IN2.

The previous default mapping of IN2 was based on testing on the same 6
tablets, where the internal mic works fine with a mapping of IN2. But it
works fine too with a mapping of IN1.

This commit changes the default input mapping to to use IN1 instead of
IN2, to match the mapping used for the other mono devices in the DMI quirk
table. So that we need less different mappings.

The same change is made to the Chuwi Vi8 Plus quirks, which is one of the
6 models tested.

This is a preparation patch for simplifying the maps in a follow-up commit.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index c45ad99d7ac6..28f9304ea041 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -92,9 +92,9 @@ struct byt_rt5651_private {
 	struct snd_soc_jack jack;
 };
 
-/* Default: jack-detect on JD1_1, internal mic on in2, headsetmic on in3 */
+/* Default: jack-detect on JD1_1, internal mic on in1, headsetmic on in3 */
 static unsigned long byt_rt5651_quirk = BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN2_HS_IN3_MAP;
+					BYT_RT5651_IN1_HS_IN3_MAP;
 
 static void log_quirks(struct device *dev)
 {
@@ -394,7 +394,7 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "D2D3_Vi8A1"),
 		},
 		.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |
-					BYT_RT5651_IN2_HS_IN3_MAP),
+					BYT_RT5651_IN1_HS_IN3_MAP),
 	},
 	{
 		/* VIOS LTH17 */
-- 
2.17.1

From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/6] ASoC: rt5645: set in2_diff flag for GPD
	win and pocket devices
Date: Tue,  2 Jan 2018 19:53:11 +0100
Message-ID: <20180102185314.17189-4-hdegoede@redhat.com>
References: <20180102185314.17189-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 88B6D2674F8
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 19:53:23 +0100 (CET)
In-Reply-To: <20180102185314.17189-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The GPD pocket has a differential signal microphone and needs in2_diff
to be set to avoid getting a very noisy signal.

Since the GPD pocket and win use the same DMI strings, they share their
platform data-definition, so enabling in2_diff on the pocket also sets
it on the GPD win. The GPD win has a normal microphone, but setting
in2_diff there does not negatively impact the sound from the microphone.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5645.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 2e495d61b55e..6c134f4d881b 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3680,6 +3680,8 @@ static const struct rt5645_platform_data gpd_win_platform_data = {
 	.jd_mode = 3,
 	.inv_jd1_1 = true,
 	.long_name = "gpd-win-pocket-rt5645",
+	/* The GPD pocket has a diff. mic, for the win this does not matter. */
+	.in2_diff = true,
 };
 
 static const struct dmi_system_id dmi_platform_gpd_win[] = {
-- 
2.14.3

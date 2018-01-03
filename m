From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: set in2_diff flag for GPD win
	and pocket devices" to the asoc tree
Date: Wed, 03 Jan 2018 12:13:01 +0000
Message-ID: <E1eWhun-0001dX-HS@debutante>
References: <20180102185314.17189-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DAC89267610
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 13:13:05 +0100 (CET)
In-Reply-To: <20180102185314.17189-4-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: set in2_diff flag for GPD win and pocket devices

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2dc6e1a4883a3eba451c76b726c23a580ed05307 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 2 Jan 2018 19:53:11 +0100
Subject: [PATCH] ASoC: rt5645: set in2_diff flag for GPD win and pocket
 devices

The GPD pocket has a differential signal microphone and needs in2_diff
to be set to avoid getting a very noisy signal.

Since the GPD pocket and win use the same DMI strings, they share their
platform data-definition, so enabling in2_diff on the pocket also sets
it on the GPD win. The GPD win has a normal microphone, but setting
in2_diff there does not negatively impact the sound from the microphone.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a1a7bb770745..6dd894c9f355 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3628,6 +3628,8 @@ static const struct rt5645_platform_data gpd_win_platform_data = {
 	.jd_mode = 3,
 	.inv_jd1_1 = true,
 	.long_name = "gpd-win-pocket-rt5645",
+	/* The GPD pocket has a diff. mic, for the win this does not matter. */
+	.in2_diff = true,
 };
 
 static const struct dmi_system_id dmi_platform_gpd_win[] = {
-- 
2.15.1

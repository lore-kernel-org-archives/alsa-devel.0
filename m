From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Take prefix into account in
	control name length" to the asoc tree
Date: Thu, 19 Jul 2018 17:57:45 +0100
Message-ID: <E1fgCFN-0005WS-7s@debutante>
References: <20180719105039.28312-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D4FA267762
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 18:57:48 +0200 (CEST)
In-Reply-To: <20180719105039.28312-2-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, stuarth@opensource.cirrus.com, rf@opensource.cirrus.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Take prefix into account in control name length

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

>From b7ede5af62ab6bfad0980fad58e82d3fb56866df Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 19 Jul 2018 11:50:36 +0100
Subject: [PATCH] ASoC: wm_adsp: Take prefix into account in control name
 length

Currently when creating ALSA control names for the DSP the length of any
prefix applied to the CODEC is not taken into account. Whilst this is
mostly harmless it does result in ALSA doing the truncation of the
control names and printing a warning. It is better to have the driver do
the truncation so it can truncate from the start of parameter name
itself to give a greater chance of the result maintain a unique name.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 99108d18de8d..eec73c98a141 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1343,6 +1343,9 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 			int avail = SNDRV_CTL_ELEM_ID_NAME_MAXLEN - ret - 2;
 			int skip = 0;
 
+			if (dsp->component->name_prefix)
+				avail -= strlen(dsp->component->name_prefix) + 1;
+
 			if (subname_len > avail)
 				skip = subname_len - avail;
 
-- 
2.18.0

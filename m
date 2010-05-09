From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: Allow active paths from the GSM
	modem while the GTA02 is suspended
Date: Sun,  9 May 2010 13:08:38 +0100
Message-ID: <1273406918-17007-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100509120741.GA16918@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2195824591
	for <alsa-devel@alsa-project.org>;
	Sun,  9 May 2010 14:08:44 +0200 (CEST)
In-Reply-To: <20100509120741.GA16918@sirena.org.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_gta02_wm8753.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
index dea83d3..209c259 100644
--- a/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_gta02_wm8753.c
@@ -362,6 +362,14 @@ static int neo1973_gta02_wm8753_init(struct snd_soc_codec *codec)
 	snd_soc_dapm_disable_pin(codec, "Handset Mic");
 	snd_soc_dapm_disable_pin(codec, "Handset Spk");
 
+	/* allow audio paths from the GSM modem to run during suspend */
+	snd_soc_dapm_ignore_suspend(codec, "Stereo Out");
+	snd_soc_dapm_ignore_suspend(codec, "GSM Line Out");
+	snd_soc_dapm_ignore_suspend(codec, "GSM Line In");
+	snd_soc_dapm_ignore_suspend(codec, "Headset Mic");
+	snd_soc_dapm_ignore_suspend(codec, "Handset Mic");
+	snd_soc_dapm_ignore_suspend(codec, "Handset Spk");
+
 	snd_soc_dapm_sync(codec);
 
 	return 0;
-- 
1.7.0.5

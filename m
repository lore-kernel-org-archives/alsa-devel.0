From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Add warnings for widget overwrite
	when adding route" to the asoc tree
Date: Sat,  2 Feb 2019 16:17:58 +0000 (GMT)
Message-ID: <20190202161758.A10C5440082@finisterre.ee.mobilebroadband>
References: <20190131113005.13380-1-qq282012236@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 720252674A2
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2019 17:18:06 +0100 (CET)
In-Reply-To: <20190131113005.13380-1-qq282012236@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, qq282012236@gmail.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Add warnings for widget overwrite when adding route

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

>From 411db2ab7df35804422e4b26c5849b3868e6a038 Mon Sep 17 00:00:00 2001
From: Zhiwei Jiang <qq282012236@gmail.com>
Date: Thu, 31 Jan 2019 19:30:05 +0800
Subject: [PATCH] ASoC: dapm: Add warnings for widget overwrite when adding
 route

Currently, in some complex cases, more than one widgets have same
name and registed from differnt dapm context, and route add from
another context too. When snd_soc_dapm_add_route, the previous
registered widget will overwritten by the latest same name widget,
will cause unexpect error. For Asoc framework we cant avoid this
situation and we cant decide which widget that wanted with route.
At least we can give users a notice.

Signed-off-by: Zhiwei Jiang <qq282012236@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 36d964a52874..5b74dffc9c11 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2829,6 +2829,8 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	char prefixed_sink[80];
 	char prefixed_source[80];
 	const char *prefix;
+	unsigned int sink_ref = 0;
+	unsigned int source_ref = 0;
 	int ret;
 
 	prefix = soc_dapm_prefix(dapm);
@@ -2862,6 +2864,11 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 				if (wsource)
 					break;
 			}
+			sink_ref++;
+			if (sink_ref > 1)
+				dev_warn(dapm->dev,
+					"ASoC: sink widget %s overwritten\n",
+					w->name);
 			continue;
 		}
 		if (!wsource && !(strcmp(w->name, source))) {
@@ -2871,6 +2878,11 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 				if (wsink)
 					break;
 			}
+			source_ref++;
+			if (source_ref > 1)
+				dev_warn(dapm->dev,
+					"ASoC: source widget %s overwritten\n",
+					w->name);
 		}
 	}
 	/* use widget from another DAPM context if not found from this */
-- 
2.20.1

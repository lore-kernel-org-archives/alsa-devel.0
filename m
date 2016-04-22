From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add kerneldoc comments for
	snd_soc_find_dai" to the asoc tree
Date: Fri, 22 Apr 2016 11:49:20 +0100
Message-ID: <E1atYeG-0002a0-Th@debutante>
References: <1461299133-1535-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 797F0264F02
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 12:49:28 +0200 (CEST)
In-Reply-To: <1461299133-1535-1-git-send-email-mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: mengdong.lin@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add kerneldoc comments for snd_soc_find_dai

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From fbb88b5ca1dc84416fc1fec34773948b6780492c Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Fri, 22 Apr 2016 12:25:33 +0800
Subject: [PATCH] ASoC: Add kerneldoc comments for snd_soc_find_dai

snd_soc_find_dai() has been exported and so add the kerneldoc comments
for it.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 07663def2db6..16369cad4803 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -930,6 +930,17 @@ static struct snd_soc_component *soc_find_component(
 	return NULL;
 }
 
+/**
+ * snd_soc_find_dai - Find a registered DAI
+ *
+ * @dlc: name of the DAI and optional component info to match
+ *
+ * This function will search all regsitered components and their DAIs to
+ * find the DAI of the same name. The component's of_node and name
+ * should also match if being specified.
+ *
+ * Return: pointer of DAI, or NULL if not found.
+ */
 struct snd_soc_dai *snd_soc_find_dai(
 	const struct snd_soc_dai_link_component *dlc)
 {
-- 
2.8.0.rc3

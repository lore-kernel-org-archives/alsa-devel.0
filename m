From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Fix validation of firmware and coeff lengths" to the asoc tree
Date: Fri, 08 Dec 2017 17:18:11 +0000
Message-ID: <E1eNMHr-0001gv-D8@debutante>
References: <20171207211928.btwtwlfci6f4hku2@xylophone.i.decadent.org.uk>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171207211928.btwtwlfci6f4hku2@xylophone.i.decadent.org.uk>
Sender: stable-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>Charles Keepax <ckeepax@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, patches@opensource.cirrus.com, alsa-devel@alsa-project.orgstable@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Fix validation of firmware and coeff lengths

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

>From 50dd2ea8ef67a1617e0c0658bcbec4b9fb03b936 Mon Sep 17 00:00:00 2001
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Fri, 8 Dec 2017 16:15:20 +0000
Subject: [PATCH] ASoC: wm_adsp: Fix validation of firmware and coeff lengths

The checks for whether another region/block header could be present
are subtracting the size from the current offset.  Obviously we should
instead subtract the offset from the size.

The checks for whether the region/block data fit in the file are
adding the data size to the current offset and header size, without
checking for integer overflow.  Rearrange these so that overflow is
impossible.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm_adsp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 65c059b5ffd7..66e32f5d2917 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1733,7 +1733,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 		 le64_to_cpu(footer->timestamp));
 
 	while (pos < firmware->size &&
-	       pos - firmware->size > sizeof(*region)) {
+	       sizeof(*region) < firmware->size - pos) {
 		region = (void *)&(firmware->data[pos]);
 		region_name = "Unknown";
 		reg = 0;
@@ -1782,8 +1782,8 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 			 regions, le32_to_cpu(region->len), offset,
 			 region_name);
 
-		if ((pos + le32_to_cpu(region->len) + sizeof(*region)) >
-		    firmware->size) {
+		if (le32_to_cpu(region->len) >
+		    firmware->size - pos - sizeof(*region)) {
 			adsp_err(dsp,
 				 "%s.%d: %s region len %d bytes exceeds file length %zu\n",
 				 file, regions, region_name,
@@ -2253,7 +2253,7 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 
 	blocks = 0;
 	while (pos < firmware->size &&
-	       pos - firmware->size > sizeof(*blk)) {
+	       sizeof(*blk) < firmware->size - pos) {
 		blk = (void *)(&firmware->data[pos]);
 
 		type = le16_to_cpu(blk->type);
@@ -2327,8 +2327,8 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 		}
 
 		if (reg) {
-			if ((pos + le32_to_cpu(blk->len) + sizeof(*blk)) >
-			    firmware->size) {
+			if (le32_to_cpu(blk->len) >
+			    firmware->size - pos - sizeof(*blk)) {
 				adsp_err(dsp,
 					 "%s.%d: %s region len %d bytes exceeds file length %zu\n",
 					 file, blocks, region_name,
-- 
2.15.1

From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: hda/sigmatel - remove unused variable 'stac9200_core_init'
Date: Tue, 13 Aug 2019 22:43:23 +0800
Message-ID: <20190813144323.50624-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

sound/pci/hda/patch_sigmatel.c:981:30: warning:
 stac9200_core_init defined but not used [-Wunused-const-variable=]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/pci/hda/patch_sigmatel.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 0d9b627..894f3f5 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -975,15 +975,6 @@ static int stac_create_spdif_mux_ctls(struct hda_codec *codec)
 	return 0;
 }
 
-/*
- */
-
-static const struct hda_verb stac9200_core_init[] = {
-	/* set dac0mux for dac converter */
-	{ 0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
-	{}
-};
-
 static const struct hda_verb stac9200_eapd_init[] = {
 	/* set dac0mux for dac converter */
 	{0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
-- 
2.7.4

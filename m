From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: Intel: sst: fix ix spelling mistake: "capablities" -> "capabilites"
Date: Wed, 17 Aug 2016 18:47:59 +0100
Message-ID: <1471456079-130702-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in dev_err message and reformat code
to avoid being over 80 chars wide per line

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/atom/sst/sst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst.c b/sound/soc/intel/atom/sst/sst.c
index a4b458e..498b5f7 100644
--- a/sound/soc/intel/atom/sst/sst.c
+++ b/sound/soc/intel/atom/sst/sst.c
@@ -190,7 +190,8 @@ int sst_driver_ops(struct intel_sst_drv *sst)
 
 	default:
 		dev_err(sst->dev,
-			"SST Driver capablities missing for dev_id: %x", sst->dev_id);
+			"SST Driver capabilities missing for dev_id: %x",
+			sst->dev_id);
 		return -EINVAL;
 	};
 }
-- 
2.8.1

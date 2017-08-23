From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ALSA: aaci: constify amba_id
Date: Wed, 23 Aug 2017 23:02:50 +0530
Message-ID: <f3b9e39c675002c49b2da48e67ca07076f3b9960.1503509388.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/arm/aaci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 4140b1b..05562ba 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -1085,7 +1085,7 @@ static int aaci_remove(struct amba_device *dev)
 	return 0;
 }
 
-static struct amba_id aaci_ids[] = {
+static const struct amba_id aaci_ids[] = {
 	{
 		.id	= 0x00041041,
 		.mask	= 0x000fffff,
-- 
2.7.4

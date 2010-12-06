From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Hold client_mutex while calling
	snd_soc_instantiate_cards()
Date: Mon, 06 Dec 2010 16:48:03 +0800
Message-ID: <1291625283.11404.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As the comments of snd_soc_instantiate_cards() said,
snd_soc_instantiate_cards() must be called with client_mutex.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/soc-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index eb950f7..0d69b91 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3299,7 +3299,9 @@ int snd_soc_register_dais(struct device *dev,
 		pr_debug("Registered DAI '%s'\n", dai->name);
 	}
 
+	mutex_lock(&client_mutex);
 	snd_soc_instantiate_cards();
+	mutex_unlock(&client_mutex);
 	return 0;
 
 err:
-- 
1.7.2

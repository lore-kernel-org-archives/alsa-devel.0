From: Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH] ASoC: soc-core: fix init platform memory
	handling
Date: Thu, 10 Jan 2019 14:33:02 -0800
Message-ID: <20190110223302.85927-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 43A7E267551
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 23:33:14 +0100 (CET)
Received: by mail-io1-f70.google.com with SMTP id h7so11373635iof.19
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2019 14:33:14 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

snd_soc_init_platform initializes pointers to snd_soc_dai_link which is
statically allocated and it does this by devm_kzalloc. In the event of
an EPROBE_DEFER the memory will be freed and the pointers are left
dangling. snd_soc_init_platform sees the dangling pointers and assumes
they are pointing to initialized memory and does not reallocate them on
the second probe attempt which results in a use after free bug since
devm has freed the memory from the first probe attempt.

Since the intention for snd_soc_dai_link->platform is that it can be set
statically by the machine driver we need to respect the pointer in the
event we did not set it but still catch dangling pointers. The solution
is to add a flag to track whether the pointer was dynamically allocated
or not.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 include/sound/soc.h  |  6 ++++++
 sound/soc/soc-core.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8ec1de856ee7e..e665f111b0d27 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -985,6 +985,12 @@ struct snd_soc_dai_link {
 	/* Do not create a PCM for this DAI link (Backend link) */
 	unsigned int ignore:1;
 
+	/*
+	 * This driver uses legacy platform naming. Set by the core, machine
+	 * drivers should not modify this value.
+	 */
+	unsigned int legacy_platform:1;
+
 	struct list_head list; /* DAI link list of the soc card */
 	struct snd_soc_dobj dobj; /* For topology */
 };
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0934b36645b3e..cdcc417c94ca1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1034,17 +1034,18 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 	 * this function should be removed in the future
 	 */
 	/* convert Legacy platform link */
-	if (!platform) {
+	if (!platform || dai_link->legacy_platform) {
 		platform = devm_kzalloc(card->dev,
 				sizeof(struct snd_soc_dai_link_component),
 				GFP_KERNEL);
 		if (!platform)
 			return -ENOMEM;
 
-		dai_link->platform	= platform;
-		platform->name		= dai_link->platform_name;
-		platform->of_node	= dai_link->platform_of_node;
-		platform->dai_name	= NULL;
+		dai_link->platform	  = platform;
+		dai_link->legacy_platform = 1;
+		platform->name		  = dai_link->platform_name;
+		platform->of_node	  = dai_link->platform_of_node;
+		platform->dai_name	  = NULL;
 	}
 
 	/* if there's no platform we match on the empty platform */
-- 
2.20.1.97.g81188d93c3-goog

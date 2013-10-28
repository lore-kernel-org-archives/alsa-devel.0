From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ASoC: DAPM: Fix source list debugfs outputs
Date: Mon, 28 Oct 2013 14:21:49 +0100
Message-ID: <1382966510-13075-5-git-send-email-tiwai@suse.de>
References: <1382966510-13075-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 10957261603
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:19:06 +0100 (CET)
In-Reply-To: <1382966510-13075-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

... due to a copy & paste error.

Spotted by coverity CID 710923.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c21c8e7..8ab2b35 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1975,7 +1975,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 				w->active ? "active" : "inactive");
 
 	list_for_each_entry(p, &w->sources, list_sink) {
-		if (p->connected && !p->connected(w, p->sink))
+		if (p->connected && !p->connected(w, p->source))
 			continue;
 
 		if (p->connect)
-- 
1.8.4.1

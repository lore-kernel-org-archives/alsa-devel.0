From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: hdac_hdmi: remove redundant check for
	!port condition
Date: Thu,  6 Sep 2018 10:39:01 +0100
Message-ID: <20180906093901.16682-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B5BFA267795
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 11:39:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The !port check is redundant as it being performed in the following
check. Remove it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/hdac_hdmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 7b8533abf637..dc6a0dfea050 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1961,9 +1961,6 @@ static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdev, int pcm_idx)
 
 	port = list_first_entry(&pcm->port_list, struct hdac_hdmi_port, head);
 
-	if (!port)
-		return 0;
-
 	if (!port || !port->eld.eld_valid)
 		return 0;
 
-- 
2.17.1

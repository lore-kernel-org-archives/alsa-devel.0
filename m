From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: Fix the power update function for
	snd_soc_dapm_value_mux
Date: Thu, 15 Jan 2009 14:40:47 +0200
Message-ID: <1232023247-21480-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1232023247-21480-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E33C103872
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 13:40:59 +0100 (CET)
In-Reply-To: <1232023247-21480-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, broonie@sirena.org.uk, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Modify the check for the mux type to also handle the
snd_soc_dapm_value_mux type in a same way as the snd_soc_dapm_mux.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/soc-dapm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 493a4e8..a2f1da8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -720,7 +720,8 @@ static int dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
 	struct snd_soc_dapm_path *path;
 	int found = 0;
 
-	if (widget->id != snd_soc_dapm_mux)
+	if (widget->id != snd_soc_dapm_mux &&
+	    widget->id != snd_soc_dapm_value_mux)
 		return -ENODEV;
 
 	if (!snd_soc_test_bits(widget->codec, e->reg, mask, val))
-- 
1.6.1

From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] ASoC: Make struct snd_soc_card's
	dapm_widgets and dapm_routes const
Date: Tue, 12 Apr 2011 19:31:01 +0200
Message-ID: <1302629465-21315-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-049.synserver.de (smtp-out-051.synserver.de
	[212.40.185.51]) by alsa0.perex.cz (Postfix) with SMTP id C78D9103856
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Apr 2011 19:30:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Those should not be modified (and are not) by the core code, so make them const.
This also makes them consistent with the same members of snd_soc_codec.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 435cb83..cb6b18b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -755,9 +755,9 @@ struct snd_soc_card {
 	/*
 	 * Card-specific routes and widgets.
 	 */
-	struct snd_soc_dapm_widget *dapm_widgets;
+	const struct snd_soc_dapm_widget *dapm_widgets;
 	int num_dapm_widgets;
-	struct snd_soc_dapm_route *dapm_routes;
+	const struct snd_soc_dapm_route *dapm_routes;
 	int num_dapm_routes;
 
 	struct work_struct deferred_resume_work;
-- 
1.7.2.5

From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: init delayed_work for codec-codec
	links
Date: Wed, 31 Jul 2013 14:16:44 +0100
Message-ID: <20130731131627.GA32631@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED5D526160E
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 15:16:50 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If soc_probe_link_dais() finds a codec-codec link it
skips creating a compress or pcm stream and links the
DAIs together. But it must also init the delayed_work
otherwise shutting down the DAI chain will fault when
calling flush_delayed_work_sync() on the linked DAI.

Pointing it to a dummy work callback is cleaner than taking
special cases in the code to bypass the flush_delayed_work_sync().

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4489c5b..bbe136c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -199,6 +199,10 @@ static ssize_t pmdown_time_set(struct device *dev,
 	return count;
 }
 
+static void dummy_delayed_work(struct work_struct *work)
+{
+}
+
 static DEVICE_ATTR(pmdown_time, 0644, pmdown_time_show, pmdown_time_set);
 
 #ifdef CONFIG_DEBUG_FS
@@ -1428,6 +1432,8 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 				return ret;
 			}
 		} else {
+			INIT_DELAYED_WORK(&rtd->delayed_work, dummy_delayed_work);
+
 			/* link the DAI widgets */
 			play_w = codec_dai->playback_widget;
 			capture_w = cpu_dai->capture_widget;
-- 
1.7.2.5

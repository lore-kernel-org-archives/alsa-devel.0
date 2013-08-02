From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: core: init delayed_work for codec-codec links
Date: Fri, 2 Aug 2013 11:01:08 +0100
Message-ID: <20130802100108.GA17936@opensource.wolfsonmicro.com>
References: <20130731131627.GA32631@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130731131627.GA32631@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We must init the delayed_work for codec-codec links
otherwise shutting down the DAI chain will fault when
calling flush_delayed_work_sync() on the linked DAI.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4489c5b..e649efe 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -199,6 +199,14 @@ static ssize_t pmdown_time_set(struct device *dev,
 	return count;
 }
 
+static void codec2codec_close_delayed_work(struct work_struct *work)
+{
+	/* No action required.
+	 * C2C links only represent a hardware connection and currently
+	 * we assume that we don't have to explicitly start or stop them
+	 */
+}
+
 static DEVICE_ATTR(pmdown_time, 0644, pmdown_time_show, pmdown_time_set);
 
 #ifdef CONFIG_DEBUG_FS
@@ -1428,6 +1436,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 				return ret;
 			}
 		} else {
+			INIT_DELAYED_WORK(&rtd->delayed_work,
+						codec2codec_close_delayed_work);
+
 			/* link the DAI widgets */
 			play_w = codec_dai->playback_widget;
 			capture_w = cpu_dai->capture_widget;
-- 
1.7.2.5

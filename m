From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: core: init delayed_work
	for	codec-codec links
Date: Fri, 2 Aug 2013 11:51:56 +0100
Message-ID: <20130802105156.GA20577@opensource.wolfsonmicro.com>
References: <20130731131627.GA32631@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D9412261737
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 12:51:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130731131627.GA32631@opensource.wolfsonmicro.com>
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

We must init the delayed_work for codec-codec links
otherwise shutting down the DAI chain will fault when
calling flush_delayed_work_sync() on the linked DAI.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4489c5b..450dbf4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -530,6 +530,10 @@ static int soc_ac97_dev_register(struct snd_soc_codec *codec)
 }
 #endif
 
+static void codec2codec_close_delayed_work(struct work_struct *work)
+{
+}
+
 #ifdef CONFIG_PM_SLEEP
 /* powers down audio subsystem for suspend */
 int snd_soc_suspend(struct device *dev)
@@ -1428,6 +1432,9 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
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

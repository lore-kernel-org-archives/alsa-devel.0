From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: DAPM - Notify stream event to all card
	components.
Date: Wed, 15 Feb 2012 15:15:35 +0000
Message-ID: <1329318937-14488-2-git-send-email-lrg@ti.com>
References: <1329318937-14488-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 59242103E10
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 16:15:51 +0100 (CET)
Received: by wibhm4 with SMTP id hm4so687141wib.29
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 07:15:48 -0800 (PST)
In-Reply-To: <1329318937-14488-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Currently when DAPM widgets are power sequenced the stream_event()
completion callback is only called for the stream_event originator
DAPM context. Other components in the card may also be interested so
make sure they are also notified of any widget power events.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 227887e..63a5614 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1516,6 +1516,12 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 					&async_domain);
 	async_synchronize_full_domain(&async_domain);
 
+	/* do we need to notify any clients that DAPM event is complete */
+	list_for_each_entry(d, &card->dapm_list, list) {
+		if (d->stream_event)
+			d->stream_event(d, event);
+	}
+
 	pop_dbg(dapm->dev, card->pop_time,
 		"DAPM sequencing finished, waiting %dms\n", card->pop_time);
 	pop_wait(card->pop_time);
@@ -2854,10 +2860,6 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 	}
 
 	dapm_power_widgets(dapm, event);
-
-	/* do we need to notify any clients that DAPM stream is complete */
-	if (dapm->stream_event)
-		dapm->stream_event(dapm, event);
 }
 
 /**
-- 
1.7.5.4

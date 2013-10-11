From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 1/3] ASoC: snd_soc_dai_ops trigger function
	description
Date: Fri, 11 Oct 2013 12:11:02 +0200
Message-ID: <1381486264-1672-2-git-send-email-mpa@pengutronix.de>
References: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 00D0726566E
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 12:11:56 +0200 (CEST)
In-Reply-To: <1381486264-1672-1-git-send-email-mpa@pengutronix.de>
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
Cc: kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add a comment to the trigger function in snd_soc_dai_ops struct about
possible command sequences.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 include/sound/soc-dai.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index ae9a227..0f2e5da 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -166,6 +166,13 @@ struct snd_soc_dai_ops {
 		struct snd_soc_dai *);
 	int (*prepare)(struct snd_pcm_substream *,
 		struct snd_soc_dai *);
+	/*
+	 * NOTE: Commands passed to the trigger function are not necessarily
+	 * compatible with the current state of the dai. For example this
+	 * sequence of commands is possible: START STOP STOP.
+	 * So do not unconditionally use refcounting functions in the trigger
+	 * function, e.g. clk_enable/disable.
+	 */
 	int (*trigger)(struct snd_pcm_substream *, int,
 		struct snd_soc_dai *);
 	int (*bespoke_trigger)(struct snd_pcm_substream *, int,
-- 
1.8.4.rc3

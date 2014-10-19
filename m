From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 1/2] ASoC: soc-compress: consolidate two
	identical branches
Date: Sun, 19 Oct 2014 09:07:35 +0200
Message-ID: <1413702456-8624-2-git-send-email-daniel@zonque.org>
References: <1413702456-8624-1-git-send-email-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 073062604FD
 for <alsa-devel@alsa-project.org>; Sun, 19 Oct 2014 09:07:44 +0200 (CEST)
In-Reply-To: <1413702456-8624-1-git-send-email-daniel@zonque.org>
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
Cc: broonie@kernel.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

The actions taken in both branches are identical, so we can simplify the
code. Spotted by Coverity.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/soc-compress.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index cecfab3..590a82f 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -258,10 +258,7 @@ static int soc_compr_free_fe(struct snd_compr_stream *cstream)
 	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
 		dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
-	else
-		dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
+	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
 
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
 	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
@@ -456,11 +453,7 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
 	if (ret < 0)
 		goto out;
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_START);
-	else
-		dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_START);
-
+	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_START);
 	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_PREPARE;
 
 out:
-- 
2.1.0

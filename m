From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] ASoC: dpcm: improve robustness
Date: Thu, 31 Oct 2013 15:09:20 +0000
Message-ID: <20131031150920.GB16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 6BB922617B5
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 16:09:33 +0100 (CET)
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
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark, Liam,

You may also wish to consider adding this patch as well - it avoids
oopsing due to a NULL be_substream when writing be_substream->runtime
if the frontend is marked as having a playback/capture stream but there
is no backend.

I found this with Liam's "Explicitly set capture/playback support in DAI
links" patch applied, and I'd configured the FE to have both capture and
playback, but I'd forgotten to configure the BE appropriately.  It seems
nicer to gracefully handle this than oops the kernel.

8<=====
From: Russell King <rmk+kernel@arm.linux.org.uk>
ASoC: dpcm: improve robustness

Avoid oopsing if there is no backend stream associated with a front end
stream.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/soc-pcm.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 7798072c45ea..419af79fa30e 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1036,6 +1036,12 @@ static int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 		struct snd_pcm_substream *be_substream =
 			snd_soc_dpcm_get_substream(be, stream);
 
+		if (!be_substream) {
+			dev_err(be->dev, "ASoC: no backend %s stream\n",
+				stream ? "capture" : "playback");
+			continue;
+		}
+
 		/* is this op for this BE ? */
 		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
 			continue;
@@ -1053,7 +1059,8 @@ static int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_CLOSE))
 			continue;
 
-		dev_dbg(be->dev, "ASoC: open BE %s\n", be->dai_link->name);
+		dev_dbg(be->dev, "ASoC: open %s BE %s\n",
+			stream ? "capture" : "playback", be->dai_link->name);
 
 		be_substream->runtime = be->dpcm[stream].runtime;
 		err = soc_pcm_open(be_substream);
-- 
1.7.4.4

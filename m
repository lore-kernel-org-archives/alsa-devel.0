From: Phil Vandry <vandry@TZoNE.ORG>
Subject: [PATCH] wm8753: fix mapping when MONOMIX is set to
	Stereo
Date: Mon, 21 Sep 2009 11:36:08 -0400
Message-ID: <20090921153608.GA14393@OZoNE.TZoNE.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from OZoNE.TZoNE.ORG (OZoNE.TZoNE.ORG [64.15.147.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 775AE245D1
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Sep 2009 17:36:14 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When MONOMIX is set to Stereo, Left PGA was not powered on but should be.
Add a mapping from Capture Left Mux to Capture Left Mixer to fix the issue.

Signed-off-by: Phil Vandry <vandry@TZoNE.ORG>
---
 sound/soc/codecs/wm8753.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index d80d414..5ad677c 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -595,6 +595,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 	/* Mono Capture mixer-mux */
 	{"Capture Right Mixer", "Stereo", "Capture Right Mux"},
+	{"Capture Left Mixer", "Stereo", "Capture Left Mux"},
 	{"Capture Left Mixer", "Analogue Mix Left", "Capture Left Mux"},
 	{"Capture Left Mixer", "Analogue Mix Left", "Capture Right Mux"},
 	{"Capture Right Mixer", "Analogue Mix Right", "Capture Left Mux"},

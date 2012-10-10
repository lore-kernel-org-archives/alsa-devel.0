From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH repost] ASoC: fsl/pcm030 add unique dai_link
	names
Date: Wed, 10 Oct 2012 10:10:08 -0400
Message-ID: <1349878208-93797-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 39AF32616C1
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 16:10:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

Assign each dai_link a unique name to avoid this run-time error.

[   18.978043] pcm030-audio-fabric sound.2:  wm9712-hifi <-> mpc5200-psc-ac97.0 mapping ok
[   19.003179] sysfs: cannot create duplicate filename '/devices/sound.2/AC97'

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
 sound/soc/fsl/pcm030-audio-fabric.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index 4b63ec8..4d26192 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -29,14 +29,14 @@ struct pcm030_audio_data {
 
 static struct snd_soc_dai_link pcm030_fabric_dai[] = {
 {
-	.name = "AC97",
+	.name = "AC97.0",
 	.stream_name = "AC97 Analog",
 	.codec_dai_name = "wm9712-hifi",
 	.cpu_dai_name = "mpc5200-psc-ac97.0",
 	.codec_name = "wm9712-codec",
 },
 {
-	.name = "AC97",
+	.name = "AC97.1",
 	.stream_name = "AC97 IEC958",
 	.codec_dai_name = "wm9712-aux",
 	.cpu_dai_name = "mpc5200-psc-ac97.1",
-- 
1.7.8

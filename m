From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Restore DAI ID specification for
	WM8994
Date: Tue, 12 Oct 2010 15:57:56 +0100
Message-ID: <1286895476-23198-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1286895476-23198-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 07EE7243B0
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 16:58:03 +0200 (CEST)
In-Reply-To: <1286895476-23198-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

WM8994 relies on the DAIs having IDs that match the AIF numbers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index cb9338e..9ccda44 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3850,6 +3850,7 @@ static struct snd_soc_dai_ops wm8994_aif3_dai_ops = {
 static struct snd_soc_dai_driver wm8994_dai[] = {
 	{
 		.name = "wm8994-aif1",
+		.id = 1,
 		.playback = {
 			.stream_name = "AIF1 Playback",
 			.channels_min = 2,
@@ -3868,6 +3869,7 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
 	},
 	{
 		.name = "wm8994-aif2",
+		.id = 2,
 		.playback = {
 			.stream_name = "AIF2 Playback",
 			.channels_min = 2,
@@ -3886,6 +3888,7 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
 	},
 	{
 		.name = "wm8994-aif3",
+		.id = 3,
 		.playback = {
 			.stream_name = "AIF3 Playback",
 			.channels_min = 2,
-- 
1.7.1

From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl6040: Add back support for legacy mode
Date: Wed, 6 Jul 2011 21:01:16 +0300
Message-ID: <1309975276-5986-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id CC04B243E9
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 20:01:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

The legacy mode has been accidentaly removed by commit:
ASoC: twl6040: add all ABE DAIs

Add back the twl6040-hifi dai.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi Tony, Mark, Liam,

this patch fixes the accidental removal of the twl6040-hifi
dai from the codec driver.
The series, which this patch depends on not yet pulled
(I have the branch ready), since I'm still waiting for few
acks for it.
The MFD series is mostly OK, but the threaded interrupt
related followup waits for acks, and also the PLL
restructuring series is in waiting state.

Is it OK, if I queue up this patch as well for the same pull
request, and goes with the rest through l-o (since it
is on top of those changes)?

I could try to squash it down, if you prefer to the offending
commit - I hope it is not breaking the rebase too much...

Thank you,
Peter

 sound/soc/codecs/twl6040.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index d4b944c..443032b 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1464,6 +1464,24 @@ static struct snd_soc_dai_ops twl6040_dai_ops = {
 
 static struct snd_soc_dai_driver twl6040_dai[] = {
 {
+	.name = "twl6040-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = TWL6040_RATES,
+		.formats = TWL6040_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = TWL6040_RATES,
+		.formats = TWL6040_FORMATS,
+	},
+	.ops = &twl6040_dai_ops,
+},
+{
 	.name = "twl6040-ul",
 	.capture = {
 		.stream_name = "Capture",
-- 
1.7.6

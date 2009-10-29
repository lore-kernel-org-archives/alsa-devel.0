From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: TWL4030: Add APLL supply for the capture
	path
Date: Thu, 29 Oct 2009 13:05:52 +0200
Message-ID: <1256814352-22408-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B43224684
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 12:06:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Capture path also need the APLL enabled, adding DAPM_SUPPLY
for the Virtual ADCs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---

I have forgot to run git add, so the capture path DAPM_SUPPLY was missing from
the previous series.

This also applies on top of Mark's tree, for-2.6.33-pending branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

and depends on the "ASoC: TWL4030: Change codec_muted to apll_enabled" patch.

Sorry about this.


 sound/soc/codecs/twl4030.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 277e99c..f9121ef 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1449,6 +1449,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"ADC Virtual Left2", NULL, "TX2 Capture Route"},
 	{"ADC Virtual Right2", NULL, "TX2 Capture Route"},

+	{"ADC Virtual Left1", NULL, "APLL Enable"},
+	{"ADC Virtual Right1", NULL, "APLL Enable"},
+	{"ADC Virtual Left2", NULL, "APLL Enable"},
+	{"ADC Virtual Right2", NULL, "APLL Enable"},
+
 	/* Analog bypass routes */
 	{"Right1 Analog Loopback", "Switch", "Analog Right"},
 	{"Left1 Analog Loopback", "Switch", "Analog Left"},
--
1.6.5.1

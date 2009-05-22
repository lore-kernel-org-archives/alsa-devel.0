From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2 take2] ASoC: SDP4030: Use the
	twl4030_setup_data for headset pop-removal
Date: Fri, 22 May 2009 10:13:16 +0300
Message-ID: <1242976396-7667-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1242976396-7667-1-git-send-email-peter.ujfalusi@nokia.com>
	<1242976396-7667-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id E3710243F1
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 09:13:35 +0200 (CEST)
In-Reply-To: <1242976396-7667-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, getarunks@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

With this patch the initial headset pop-removal related values are
configured for the twl4030 codec (ramp delay and sysclk).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/sdp3430.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/sdp3430.c b/sound/soc/omap/sdp3430.c
index 19966a7..b719e5d 100644
--- a/sound/soc/omap/sdp3430.c
+++ b/sound/soc/omap/sdp3430.c
@@ -276,10 +276,17 @@ static struct snd_soc_card snd_soc_sdp3430 = {
 	.num_links = ARRAY_SIZE(sdp3430_dai),
 };

+/* twl4030 setup */
+static struct twl4030_setup_data twl4030_setup = {
+	.ramp_delay_value = 3,
+	.sysclk = 26000,
+};
+
 /* Audio subsystem */
 static struct snd_soc_device sdp3430_snd_devdata = {
 	.card = &snd_soc_sdp3430,
 	.codec_dev = &soc_codec_dev_twl4030,
+	.codec_data = &twl4030_setup,
 };

 static struct platform_device *sdp3430_snd_device;
--
1.6.3

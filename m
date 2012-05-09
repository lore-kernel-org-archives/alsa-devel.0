From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH 3/3] ASoC: cs42l73: Use DAPM routes to hook AIF
	widgets to DAI's
Date: Wed, 9 May 2012 12:14:04 -0500
Message-ID: <1336583644-12349-3-git-send-email-brian.austin@cirrus.com>
References: <1336583644-12349-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe006.messaging.microsoft.com [213.199.154.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 490811046BA
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 19:17:08 +0200 (CEST)
In-Reply-To: <1336583644-12349-1-git-send-email-brian.austin@cirrus.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l73.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 1cf2206..d8b325c 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -773,6 +773,14 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
 	{"HL Left Mixer", NULL, "VSPIN"},
 	{"HL Right Mixer", NULL, "VSPIN"},
 
+	{"ASPINL", NULL, "ASP Playback"},
+	{"ASPINM", NULL, "ASP Playback"},
+	{"ASPINR", NULL, "ASP Playback"},
+	{"XSPINL", NULL, "XSP Playback"},
+	{"XSPINM", NULL, "XSP Playback"},
+	{"XSPINR", NULL, "XSP Playback"},
+	{"VSPIN", NULL, "VSP Playback"},
+
 	/* Capture Paths */
 	{"MIC1", NULL, "MIC1 Bias"},
 	{"PGA Left Mux", "Mic 1", "MIC1"},
@@ -819,6 +827,13 @@ static const struct snd_soc_dapm_route cs42l73_audio_map[] = {
 
 	{"VSPOUTL", NULL, "VSPL Output Mixer"},
 	{"VSPOUTR", NULL, "VSPR Output Mixer"},
+
+	{"ASP Capture", NULL, "ASPOUTL"},
+	{"ASP Capture", NULL, "ASPOUTR"},
+	{"XSP Capture", NULL, "XSPOUTL"},
+	{"XSP Capture", NULL, "XSPOUTR"},
+	{"VSP Capture", NULL, "VSPOUTL"},
+	{"VSP Capture", NULL, "VSPOUTR"},
 };
 
 struct cs42l73_mclk_div {
-- 
1.7.10

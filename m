From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: Convert afeb9260 to table based DAPM
	init
Date: Sun, 29 Jan 2012 16:52:51 +0800
Message-ID: <1327827171.7085.2.camel@phoenix>
References: <1327827122.7085.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 26E6D2457A
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2012 09:52:57 +0100 (CET)
Received: by dadz14 with SMTP id z14so2879243dad.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2012 00:52:57 -0800 (PST)
In-Reply-To: <1327827122.7085.1.camel@phoenix>
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
Cc: Sergey Lapin <slapin@ossfans.org>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/atmel/snd-soc-afeb9260.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/atmel/snd-soc-afeb9260.c b/sound/soc/atmel/snd-soc-afeb9260.c
index cb0130c..f65f08b 100644
--- a/sound/soc/atmel/snd-soc-afeb9260.c
+++ b/sound/soc/atmel/snd-soc-afeb9260.c
@@ -70,7 +70,7 @@ static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
 	SND_SOC_DAPM_MIC("Mic Jack", NULL),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route afeb9260_audio_map[] = {
 	{"Headphone Jack", NULL, "LHPOUT"},
 	{"Headphone Jack", NULL, "RHPOUT"},
 
@@ -85,13 +85,6 @@ static int afeb9260_tlv320aic23_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	/* Add afeb9260 specific widgets */
-	snd_soc_dapm_new_controls(dapm, tlv320aic23_dapm_widgets,
-				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
-
-	/* Set up afeb9260 specific audio path audio_map */
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
 	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	snd_soc_dapm_enable_pin(dapm, "Line In");
 	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
@@ -119,6 +112,11 @@ static struct snd_soc_card snd_soc_machine_afeb9260 = {
 	.owner = THIS_MODULE,
 	.dai_link = &afeb9260_dai,
 	.num_links = 1,
+
+	.dapm_widgets = tlv320aic23_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tlv320aic23_dapm_widgets),
+	.dapm_routes = afeb9260_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(afeb9260_audio_map),
 };
 
 static struct platform_device *afeb9260_snd_device;
-- 
1.7.5.4

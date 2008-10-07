From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][PATCH 2/2] ASoC: tlv320aic3x: Use uniform
	tlv320aic naming
Date: Tue,  7 Oct 2008 14:49:23 +0300
Message-ID: <1223380163-29041-3-git-send-email-jarkko.nikula@nokia.com>
References: <1223380163-29041-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id C00BE2454D
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 13:50:33 +0200 (CEST)
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com
	[10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m97Bo7Jf013753
	for <alsa-devel@alsa-project.org>; Tue, 7 Oct 2008 06:50:18 -0500
In-Reply-To: <1223380163-29041-1-git-send-email-jarkko.nikula@nokia.com>
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 7cff192..05336ed 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -990,7 +990,7 @@ EXPORT_SYMBOL_GPL(aic3x_headset_detected);
 			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 struct snd_soc_dai aic3x_dai = {
-	.name = "aic3x",
+	.name = "tlv320aic3x",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -1054,7 +1054,7 @@ static int aic3x_init(struct snd_soc_device *socdev)
 	struct aic3x_setup_data *setup = socdev->codec_data;
 	int reg, ret = 0;
 
-	codec->name = "aic3x";
+	codec->name = "tlv320aic3x";
 	codec->owner = THIS_MODULE;
 	codec->read = aic3x_read_reg_cache;
 	codec->write = aic3x_write;
-- 
1.5.6.5

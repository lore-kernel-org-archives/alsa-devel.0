From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [asoc-dev][RFC/PATCH 1/3] ASoC: TLV320AIC3X: Modify
	only interface related bits in aic3x_set_dai_fmt
Date: Wed, 25 Jun 2008 14:58:45 +0300
Message-ID: <1214395127-7169-2-git-send-email-jarkko.nikula@nokia.com>
References: <1214395127-7169-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id B4C7B24367
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 13:58:32 +0200 (CEST)
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com
	[10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m5PBwJ8G007450
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 14:58:30 +0300
In-Reply-To: <1214395127-7169-1-git-send-email-jarkko.nikula@nokia.com>
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

Those two serial data interface control register bits have also other
functions and they can be set before aic3x_set_dai_fmt is called.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 0c7452f..29dc0ec 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -809,8 +809,10 @@ static int aic3x_set_dai_fmt(struct snd_soc_codec_dai *codec_dai,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct aic3x_priv *aic3x = codec->private_data;
-	u8 iface_areg = 0;
-	u8 iface_breg = 0;
+	u8 iface_areg, iface_breg;
+
+	iface_areg = aic3x_read_reg_cache(codec, AIC3X_ASD_INTF_CTRLA) & 0x3f;
+	iface_breg = aic3x_read_reg_cache(codec, AIC3X_ASD_INTF_CTRLB) & 0x3f;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-- 
1.5.5.4

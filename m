From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 4/8] ASoC: AD1836: use local control_type field
Date: Tue, 14 Jun 2011 17:34:24 -0400
Message-ID: <1308087268-11464-4-git-send-email-vapier@gentoo.org>
References: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id B65C1243E7
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 23:34:05 +0200 (CEST)
In-Reply-To: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

We set up a local control_type field, so use it rather than hardcoding the
type inside of the register call.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ad1836.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 56b90aa..d60c53d 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -223,7 +223,7 @@ static int ad1836_probe(struct snd_soc_codec *codec)
 	int ret = 0;
 
 	codec->control_data = ad1836->control_data;
-	ret = snd_soc_codec_set_cache_io(codec, 4, 12, SND_SOC_SPI);
+	ret = snd_soc_codec_set_cache_io(codec, 4, 12, ad1836->control_type);
 	if (ret < 0) {
 		dev_err(codec->dev, "failed to set cache I/O: %d\n",
 				ret);
-- 
1.7.5.3

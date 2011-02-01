From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] ASoC: CX20442: fix NULL pointer dereference
Date: Tue, 1 Feb 2011 13:01:17 +0100
Message-ID: <201102011301.17699.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id E4C4924492
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 13:02:11 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The CX20442 codec driver never provided the snd_soc_codec_driver's 
.reg_cache_default member. With the latest ASoC framework changes, it 
seems to be referred unconditionally, resulting in a NULL pointer 
dereference if missing. Provide it.

Created and tested on Amstrad Delta against linux-2.6.38-rc2

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
NOTE:
I'm not sure if the value choosen is Amstrad Delta specific or not.

 sound/soc/codecs/cx20442.c |    3 +++
 1 file changed, 3 insertions(+)

--- git/sound/soc/codecs/cx20442.c.orig	2011-01-31 20:09:18.000000000 +0100
+++ git/sound/soc/codecs/cx20442.c	2011-01-31 20:16:20.000000000 +0100
@@ -367,9 +367,12 @@ static int cx20442_codec_remove(struct s
 	return 0;
 }
 
+static const u8 cx20442_reg = CX20442_TELOUT | CX20442_MIC;
+
 static struct snd_soc_codec_driver cx20442_codec_dev = {
 	.probe = 	cx20442_codec_probe,
 	.remove = 	cx20442_codec_remove,
+	.reg_cache_default = &cx20442_reg,
 	.reg_cache_size = 1,
 	.reg_word_size = sizeof(u8),
 	.read = cx20442_read_reg_cache,

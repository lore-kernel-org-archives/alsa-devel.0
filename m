From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: Don't oops in soc_probe_aux_dev in case
	of missing codec
Date: Fri,  3 Dec 2010 09:18:22 +0200
Message-ID: <1291360702-5709-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F0796103AFD
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 08:17:49 +0100 (CET)
Received: by eyg24 with SMTP id 24so4829466eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 02 Dec 2010 23:17:43 -0800 (PST)
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

Blind copy of codec finding algorithm from soc_bind_dai_link does not work
in soc_probe_aux_dev if matching codec name is not found. In that case the
code falls through and tries to start the probing procedure with invalid
codec pointer.

Fix this and add an error print showing the codec name that cannot be found.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/soc-core.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index eb950f7..1fd5e72 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1609,7 +1609,7 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
 	struct snd_soc_codec *codec;
 	const char *temp;
-	int ret = 0;
+	int ret = -ENODEV;
 
 	/* find CODEC from registered CODECs*/
 	list_for_each_entry(codec, &codec_list, list) {
@@ -1620,10 +1620,14 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 				ret = -EBUSY;
 				goto out;
 			}
-			break;
+			goto found;
 		}
 	}
+	/* codec not found */
+	dev_err(card->dev, "asoc: codec %s not found", aux_dev->codec_name);
+	goto out;
 
+found:
 	if (!try_module_get(codec->dev->driver->owner))
 		return -ENODEV;
 
-- 
1.7.2.3

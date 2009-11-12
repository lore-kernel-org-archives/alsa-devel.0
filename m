From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2] soc-core: move setting ac97 platformdata
	earlier than ac97 read/write
Date: Thu, 12 Nov 2009 12:01:47 +0800
Message-ID: <1257998507-31864-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id C8759103802
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 05:01:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>, Marek Vasut <marek.vasut@gmail.com>
List-Id: alsa-devel@alsa-project.org

While probing, AC97 codec drivers and soc-core generically execute the
following sequence:
snd_soc_new_ac97_codec -> snd_soc_new_pcms -> reset ac-link/read AC97 ID
to detect ->...  -> set platform_data to ac97 by soc-core

commit 474828a40f6ddab6e2a3475a19c5c84aa3ec7d60 adds platform_data to
snd_ac97 instance. But ac97 platform data hasn't given to snd_ac97
before actual ac97 operations. Then while ac97_read access platform_data
of snd_ac97 for detecting, NULL pointer oops will fire. That means old
platform_data patch doesn't work in real-life cases.

This patch moves the operation of setting ac97 platform_data earlier
than ac97 reading/writing operations. Then it makes platform_data of
AC97 become practically useful.

Signed-off-by: Barry Song <21cnbao@gmail.com>
cc: Marek Vasut <marek.vasut@gmail.com>
---
 sound/soc/soc-core.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e2b6d75..ef8f282 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1083,11 +1083,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 				continue;
 			}
 		}
-		if (card->dai_link[i].codec_dai->ac97_control) {
+		if (card->dai_link[i].codec_dai->ac97_control)
 			ac97 = 1;
-			snd_ac97_dev_add_pdata(codec->ac97,
-				card->dai_link[i].cpu_dai->ac97_pdata);
-		}
 	}
 
 	snprintf(codec->card->shortname, sizeof(codec->card->shortname),
@@ -1510,6 +1507,10 @@ int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *xid)
 			mutex_unlock(&codec->mutex);
 			return ret;
 		}
+		if (card->dai_link[i].codec_dai->ac97_control) {
+			snd_ac97_dev_add_pdata(codec->ac97,
+				card->dai_link[i].cpu_dai->ac97_pdata);
+		}
 	}
 
 	mutex_unlock(&codec->mutex);
-- 
1.5.6.3

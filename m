From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] ASoC: dapm: add initialization for
	w_param_text pointer
Date: Tue, 10 Oct 2017 11:20:10 +0200
Message-ID: <20171010092052.2551973-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by alsa0.perex.cz (Postfix) with ESMTP id E306326727C
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 11:22:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Arnd Bergmann <arnd@arndb.de>, anish kumar <yesanishhere@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

We now allocate the array conditionally, but we always pass
the pointer to the new snd_soc_dapm_free_kcontrol() function,
which introduces a warning for the case that it is not
initialized:

sound/soc/soc-dapm.c: In function 'snd_soc_dapm_new_pcm':
sound/soc/soc-dapm.c:3940:2: error: 'w_param_text' may be used uninitialized in this function [-Werror=maybe-uninitialized]

As snd_soc_dapm_free_kcontrol() is global, it doesn't get inlined
and gcc fails to notice that we don't actually access the array
in that case, so the code is actually safe. Adding an initialization
for the array pointer shuts up the warning.

Fixes: 19ad683abc85 ("ASoC: dapm: Avoid creating kcontrol for params")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/soc-dapm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ceec185c871f..19babdae1a06 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3905,6 +3905,8 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 			ret = -ENOMEM;
 			goto param_fail;
 		}
+	} else {
+		w_param_text = NULL;
 	}
 	dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
 
-- 
2.9.0

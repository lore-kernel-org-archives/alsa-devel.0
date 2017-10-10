From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: add initialization for
	w_param_text pointer" to the asoc tree
Date: Tue, 10 Oct 2017 10:30:57 +0100
Message-ID: <E1e1qsL-0004qV-F0@debutante>
References: <20171010092052.2551973-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 54AC52672B4
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 11:31:03 +0200 (CEST)
In-Reply-To: <20171010092052.2551973-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, anish kumar <yesanishhere@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: add initialization for w_param_text pointer

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 667ebc97c99a2ea9279bf3fdd791d97adfafbbc2 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 10 Oct 2017 11:20:10 +0200
Subject: [PATCH] ASoC: dapm: add initialization for w_param_text pointer

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 44aed3383c62..12eb74d5f5c1 100644
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
2.14.1

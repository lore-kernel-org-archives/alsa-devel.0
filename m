From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] wm8727: add a missing return in wm8727_platform_probe
Date: Wed, 14 Jul 2010 18:57:31 +0800
Message-ID: <1279105051.2290.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, Neil Jones <neil.jones@imgtec.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

otherwise the error path will always be executed.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8727.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8727.c b/sound/soc/codecs/wm8727.c
index 1072621..9d1df26 100644
--- a/sound/soc/codecs/wm8727.c
+++ b/sound/soc/codecs/wm8727.c
@@ -127,6 +127,8 @@ static __devinit int wm8727_platform_probe(struct platform_device *pdev)
 		goto err_codec;
 	}
 
+	return 0;
+
 err_codec:
 	snd_soc_unregister_codec(codec);
 err:
-- 
1.7.0.4

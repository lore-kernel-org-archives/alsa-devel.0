From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: Remove unneeded hw_write
	initialisation in wm8523
Date: Tue, 04 Oct 2011 11:45:41 +0800
Message-ID: <1317699941.19150.1.camel@phoenix>
References: <1317699882.19150.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 47E9F2446B
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 05:45:48 +0200 (CEST)
Received: by yxk8 with SMTP id 8so85868yxk.38
	for <alsa-devel@alsa-project.org>; Mon, 03 Oct 2011 20:45:47 -0700 (PDT)
In-Reply-To: <1317699882.19150.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

It is not required after commit 8d50e447
"ASoC: Factor out I/O for Wolfson 8 bit data 16 bit register CODECs"

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8523.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index 5355a7a..db7a681 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -406,7 +406,6 @@ static int wm8523_probe(struct snd_soc_codec *codec)
 	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
 	int ret, i;
 
-	codec->hw_write = (hw_write_t)i2c_master_send;
 	wm8523->rate_constraint.list = &wm8523->rate_constraint_list[0];
 	wm8523->rate_constraint.count =
 		ARRAY_SIZE(wm8523->rate_constraint_list);
-- 
1.7.4.1

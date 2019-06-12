From: Nathan Huckleberry <nhuck@google.com>
Subject: [PATCH] ASoC: tas571x: Fix -Wunused-const-variable
Date: Wed, 12 Jun 2019 16:25:02 -0700
Message-ID: <20190612232502.256846-1-nhuck@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw1-xc49.google.com (mail-yw1-xc49.google.com
 [IPv6:2607:f8b0:4864:20::c49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 687F1F80791
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 01:25:44 +0200 (CEST)
Received: by mail-yw1-xc49.google.com with SMTP id d135so11912733ywd.0
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 16:25:44 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: cernekee@chromium.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: clang-built-linux@googlegroups.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nathan Huckleberry <nhuck@google.com>
List-Id: alsa-devel@alsa-project.org

Clang produces the following warning

sound/soc/codecs/tas571x.c:666:38: warning: unused variable
'tas5721_controls' [-Wunused-const-variable]

In the chip struct definition tas5711_controls is used rather than
tac5712_controls. Looks like a typo was made in the original commit.

Since tac5711_controls is identical to tas5721_controls we can just swap
them

Cc: clang-built-linux@googlegroups.com
Link: https://github.com/ClangBuiltLinux/linux/issues/522
Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 sound/soc/codecs/tas571x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 20798fa2988a..1554631cb397 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -721,8 +721,8 @@ static const struct regmap_config tas5721_regmap_config = {
 static const struct tas571x_chip tas5721_chip = {
 	.supply_names			= tas5721_supply_names,
 	.num_supply_names		= ARRAY_SIZE(tas5721_supply_names),
-	.controls			= tas5711_controls,
-	.num_controls			= ARRAY_SIZE(tas5711_controls),
+	.controls			= tas5721_controls,
+	.num_controls			= ARRAY_SIZE(tas5721_controls),
 	.regmap_config			= &tas5721_regmap_config,
 	.vol_reg_size			= 1,
 };
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

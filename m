From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: max98926: make max98926_spk_tlv and
	max98926_current_tlv static
Date: Sun, 13 Aug 2017 16:00:33 +0100
Message-ID: <20170813150033.17049-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AE6B42669F3
 for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2017 17:00:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, "Gustavo A . R . Silva" <garsilva@embeddedor.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

max98926_spk_tlv and max98926_current_tlv are local to the source and do
not need to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'max98926_spk_tlv' was not declared. Should it be static?
symbol 'max98926_current_tlv' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/max98926.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 59d03d036945..03d07bf4d942 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -213,8 +213,8 @@ static bool max98926_readable_register(struct device *dev, unsigned int reg)
 	}
 };
 
-DECLARE_TLV_DB_SCALE(max98926_spk_tlv, -600, 100, 0);
-DECLARE_TLV_DB_RANGE(max98926_current_tlv,
+static DECLARE_TLV_DB_SCALE(max98926_spk_tlv, -600, 100, 0);
+static DECLARE_TLV_DB_RANGE(max98926_current_tlv,
 	0, 11, TLV_DB_SCALE_ITEM(20, 20, 0),
 	12, 15, TLV_DB_SCALE_ITEM(320, 40, 0),
 );
-- 
2.11.0

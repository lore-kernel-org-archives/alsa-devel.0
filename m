From: kbuild test robot <fengguang.wu@intel.com>
Subject: [RFC PATCH asoc] ASoC: uniphier: aiodma_rb_get_rp()
	can be static
Date: Tue, 13 Feb 2018 01:53:10 +0800
Message-ID: <20180212175310.GA13659@lkp-wsm-ep1>
References: <201802130150.A223WMAh%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 344D9267426
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 18:53:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201802130150.A223WMAh%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


Fixes: f37fe2f9987b ("ASoC: uniphier: add support for UniPhier AIO common driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 aio-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 7e9451c..1e5f053 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -904,7 +904,7 @@ void aiodma_ch_set_enable(struct uniphier_aio_sub *sub, int enable)
 	}
 }
 
-u64 aiodma_rb_get_rp(struct uniphier_aio_sub *sub)
+static u64 aiodma_rb_get_rp(struct uniphier_aio_sub *sub)
 {
 	struct regmap *r = sub->aio->chip->regmap;
 	u32 pos_u, pos_l;

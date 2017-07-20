From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Remove never used variables" to
	the asoc tree
Date: Thu, 20 Jul 2017 13:23:48 +0100
Message-ID: <E1dYAUe-000176-Gx@debutante>
References: <20170718173419.65980-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3694826238082982004=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D5713266CE1
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 14:24:02 +0200 (CEST)
In-Reply-To: <20170718173419.65980-4-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, John Keeping <john@metanate.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

--===============3694826238082982004==
Content-Type: text/plain

The patch

   ASoC: rt5677: Remove never used variables

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

>From c0d1cb8366bab9963822c27b0d40cb8b32928cdc Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 18 Jul 2017 20:34:19 +0300
Subject: [PATCH] ASoC: rt5677: Remove never used variables
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are two variables that have never been used.

sound/soc/codecs/rt5677.c:785:35: warning: ‘in_vol_tlv’ defined but not used [-Wunused-const-variable=]
static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);

sound/soc/codecs/rt5677.c:783:35: warning: ‘out_vol_tlv’ defined but not used [-Wunused-const-variable=]
static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -4650, 150, 0);

Simple remove them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index a3cce57739c3..9e9de0e274ea 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -780,9 +780,7 @@ static int rt5677_set_dsp_vad(struct snd_soc_codec *codec, bool on)
 	return 0;
 }
 
-static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -4650, 150, 0);
 static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -6525, 75, 0);
-static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
 static const DECLARE_TLV_DB_SCALE(st_vol_tlv, -4650, 150, 0);
-- 
2.13.2


--===============3694826238082982004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3694826238082982004==--

From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/42] ASoC: Replace users of TLV_DB_RANGE_HEAD
Date: Sun,  2 Aug 2015 17:19:28 +0200
Message-ID: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-138.synserver.de (smtp-out-138.synserver.de
 [212.40.185.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 452B4260678
 for <alsa-devel@alsa-project.org>; Sun,  2 Aug 2015 17:20:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>, Anish Kumar <yesanishhere@gmail.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Usage of TLV_DB_RANGE_HEAD() is deprecated in favor of
DECLARE_TLV_DB_RANGE(). The reason for this is that the former requires to
specify the number of items inside the range container while the later is
able to calculate this automatically and hence leaves less room for error.

While non of the current users of TLV_DB_RANGE_HEAD() gets it wrong it
still makes sense to clean this up since existing drivers are often used as
templates for new drivers. As an added bonus the code is also slightly
shorter.

There are also a few drivers which use TLV_DB_RANGE_HEAD() with only a
single sub-item. Those are updated to not use a range container at all
since it is not necessary.

Most of the conversion was auto-generated using the following coccinelle
script:

// <smpl>
@@
declarer name DECLARE_TLV_DB_RANGE;
identifier tlv;
constant x;
@@
-unsigned int tlv[] = {
-	TLV_DB_RANGE_HEAD(x),
+DECLARE_TLV_DB_RANGE(tlv,
	...
-};
+);
// </smpl>

- Lars

Lars-Peter Clausen (42):
  ASoC: 88pm860x: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: ab8500: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: adau1373: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: alc5623: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: alc5632: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: cs42l52: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: cs42l56: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: cs42l73: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: da7210: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: da7213: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: da9055: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: jz4740: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: max9768: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: max98088: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: max98090: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: max98095: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: max9850: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: max9877: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: rt5631: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: rt5640: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: rt5645: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: rt5651: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: rt5670: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: rt5677: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: sgtl5000: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: ssm2602: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: tpa6130a2: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: twl4030: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: uda1380: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: wm8350: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: wm8400: Don't use range container for TLV with one entry
  ASoC: wm8737: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: wm8753: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: wm8961: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: wm8962: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: wm8990: Don't use range container for TLV with one entry
  ASoC: wm8991: Don't use range container for TLVs with one entry
  ASoC: wm8993: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: wm9081: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: wm9090: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: wm9713: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE
  ASoC: wm_hubs: Replace TLV_DB_RANGE_HEAD with DECLARE_TLV_DB_RANGE

 sound/soc/codecs/88pm860x-codec.c | 28 +++++++++------------
 sound/soc/codecs/ab8500-codec.c   |  7 +++---
 sound/soc/codecs/adau1373.c       | 21 +++++++---------
 sound/soc/codecs/alc5623.c        |  7 +++---
 sound/soc/codecs/alc5632.c        |  7 +++---
 sound/soc/codecs/cs42l52.c        |  7 +++---
 sound/soc/codecs/cs42l56.c        | 21 +++++++---------
 sound/soc/codecs/cs42l73.c        | 14 +++++------
 sound/soc/codecs/da7210.c         | 22 +++++++----------
 sound/soc/codecs/da7213.c         | 15 +++++------
 sound/soc/codecs/da9055.c         | 15 +++++------
 sound/soc/codecs/jz4740.c         |  7 +++---
 sound/soc/codecs/max9768.c        |  7 +++---
 sound/soc/codecs/max98088.c       | 23 ++++++++---------
 sound/soc/codecs/max98090.c       | 42 ++++++++++++++-----------------
 sound/soc/codecs/max98095.c       | 35 +++++++++++---------------
 sound/soc/codecs/max9850.c        |  7 +++---
 sound/soc/codecs/max9877.c        | 14 +++++------
 sound/soc/codecs/rt5631.c         |  7 +++---
 sound/soc/codecs/rt5640.c         |  7 +++---
 sound/soc/codecs/rt5645.c         |  7 +++---
 sound/soc/codecs/rt5651.c         |  7 +++---
 sound/soc/codecs/rt5670.c         |  7 +++---
 sound/soc/codecs/rt5677.c         |  7 +++---
 sound/soc/codecs/sgtl5000.c       |  7 +++---
 sound/soc/codecs/ssm2602.c        |  7 +++---
 sound/soc/codecs/tpa6130a2.c      | 14 +++++------
 sound/soc/codecs/twl4030.c        |  7 +++---
 sound/soc/codecs/uda1380.c        | 14 +++++------
 sound/soc/codecs/wm8350.c         |  7 +++---
 sound/soc/codecs/wm8400.c         |  5 +---
 sound/soc/codecs/wm8737.c         |  7 +++---
 sound/soc/codecs/wm8753.c         |  7 +++---
 sound/soc/codecs/wm8961.c         |  7 +++---
 sound/soc/codecs/wm8962.c         | 14 +++++------
 sound/soc/codecs/wm8990.c         |  5 +---
 sound/soc/codecs/wm8991.c         | 52 +++++++--------------------------------
 sound/soc/codecs/wm8993.c         |  7 +++---
 sound/soc/codecs/wm9081.c         |  7 +++---
 sound/soc/codecs/wm9090.c         | 21 +++++++---------
 sound/soc/codecs/wm9713.c         |  7 +++---
 sound/soc/codecs/wm_hubs.c        |  7 +++---
 42 files changed, 216 insertions(+), 327 deletions(-)

-- 
2.1.4

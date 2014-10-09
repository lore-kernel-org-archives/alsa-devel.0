From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH v2] ASoC: rt5677: make volume TLV closer to
	reality
Date: Thu,  9 Oct 2014 15:11:27 -0700
Message-ID: <1412892687-1264-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f202.google.com (mail-pd0-f202.google.com
 [209.85.192.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E72C26044D
 for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2014 00:11:31 +0200 (CEST)
Received: by mail-pd0-f202.google.com with SMTP id fp1so149260pdb.5
 for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2014 15:11:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: oder_chiou@realtek.com, anatol.pomozov@gmail.com, tiwai@suse.de, benzh@chromium.org, broonie@kernel.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

The volume blocks have an step of 0.375dB, but TLV uses 0.01dB for
units.  Switch to use TLV_DB_MINMAX as this allows the minimum to be
off by only 0.005dB.  This is an improvement from the ~500dB is was
misreported by before.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/soc/codecs/rt5677.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 16aa4d9..a4c71f9 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -538,9 +538,9 @@ static bool rt5677_readable_register(struct device *dev, unsigned int reg)
 }
 
 static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -4650, 150, 0);
-static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
+static const DECLARE_TLV_DB_MINMAX(dac_vol_tlv, -6562, 0);
 static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
-static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_MINMAX(adc_vol_tlv, -1762, 0);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
 static const DECLARE_TLV_DB_SCALE(st_vol_tlv, -4650, 150, 0);
 
-- 
2.1.2.330.g565301e

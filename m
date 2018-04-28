From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] ASoC: tas6424: diags_enum can be static
Date: Sat, 28 Apr 2018 17:21:22 +0800
Message-ID: <20180428092122.GA115601@ivytown2>
References: <1524837349-16350-4-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DBF82675E6
 for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2018 11:22:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1524837349-16350-4-git-send-email-jjhiblot@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org, broonie@kernel.org, kbuild-all@01.org, Jean-Jacques Hiblot <jjhiblot@ti.com>, afd@ti.com, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org


Fixes: c9f4b53ff449 ("ASoC: tas6424: Allow disabling auto diagnostics for faster power-on")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 tas6424.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 8eb4842..8bca6b2 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -58,7 +58,7 @@ static DECLARE_TLV_DB_SCALE(dac_tlv, -10350, 50, 0);
 
 static const char * const diags_enum_texts[] = {"OFF", "ON"};
 static unsigned int diags_enum_values[] = {1, 0};
-SOC_VALUE_ENUM_SINGLE_DECL(diags_enum, TAS6424_DC_DIAG_CTRL1,
+static SOC_VALUE_ENUM_SINGLE_DECL(diags_enum, TAS6424_DC_DIAG_CTRL1,
 			   TAS6424_LDGBYPASS_SHIFT, TAS6424_LDGBYPASS_MASK,
 			   diags_enum_texts, diags_enum_values);
 

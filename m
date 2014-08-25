From: Inha Song <ideal.song@samsung.com>
Subject: [RESEND PATCH v4 1/2] mfd: arizona: Add support for
 INn_Mode register control
Date: Mon, 25 Aug 2014 18:25:39 +0900
Message-ID: <1408958740-1037-2-git-send-email-ideal.song@samsung.com>
References: <1408958740-1037-1-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 by alsa0.perex.cz (Postfix) with ESMTP id AEF1E264F1A
 for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2014 11:29:11 +0200 (CEST)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NAU006HDVOLWGB0@mailout3.samsung.com> for
 alsa-devel@alsa-project.org; Mon, 25 Aug 2014 18:29:09 +0900 (KST)
In-reply-to: <1408958740-1037-1-git-send-email-ideal.song@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, sameo@linux.intel.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, robh+dt@kernel.org, galak@codeaurora.org, ckeepax@opensource.wolfsonmicro.com, lee.jones@linaro.org, Inha Song <ideal.song@samsung.com>
List-Id: alsa-devel@alsa-project.org

Some boards need to set the INn_MODE[1:0] register to change
the input signal patch. This wlf,inmode property is optional.
If present, values must be specified less than or equal to
the number of input singals. If values less than the number
of input signals, elements that has not been specifed are set
to 0 by default.

Example:
   - wlf,inmode = <2 0 2>;	/* IN1, IN3 use DMIC */

Signed-off-by: Inha Song <ideal.song@samsung.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/mfd/arizona-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 10a0cb9..81e6db8 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -534,7 +534,7 @@ EXPORT_SYMBOL_GPL(arizona_of_get_named_gpio);
 static int arizona_of_get_core_pdata(struct arizona *arizona)
 {
 	struct arizona_pdata *pdata = &arizona->pdata;
-	int ret, i;
+	int ret, i, proplen;
 
 	pdata->reset = arizona_of_get_named_gpio(arizona, "wlf,reset", true);
 
@@ -560,6 +560,12 @@ static int arizona_of_get_core_pdata(struct arizona *arizona)
 			ret);
 	}
 
+	proplen = of_property_count_u32_elems(arizona->dev->of_node,
+					      "wlf,inmode");
+	if (proplen > 0 && proplen <= ARRAY_SIZE(arizona->pdata.inmode))
+		of_property_read_u32_array(arizona->dev->of_node, "wlf,inmode",
+					   arizona->pdata.inmode, proplen);
+
 	return 0;
 }
 
-- 
2.0.0.390.gcb682f8

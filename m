From: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [alsa-devel] [PATCH v2 1/2] mfd: arizona: Add support for INn_Mode
 register control
Date: Wed, 13 Aug 2014 20:53:13 +0900
Message-ID: <20140813205313.65bbe343@songinha-Samsung-DeskTop-System>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Some boards need to set the INn_MODE[1:0] register to change
the input signal patch. This wlf,inmode property is optional.
If present values must be specified by the number of
ARIZONA_MAX_INPUT.

Example:
   - wlf,inmode = <2 0 2 0>;	/* IN1, IN3 use DMIC */

Signed-off-by: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/mfd/arizona-core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 10a0cb9..2b68ccd 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -534,7 +534,7 @@ EXPORT_SYMBOL_GPL(arizona_of_get_named_gpio);
 static int arizona_of_get_core_pdata(struct arizona *arizona)
 {
 	struct arizona_pdata *pdata = &arizona->pdata;
-	int ret, i;
+	int ret, i, proplen;
 
 	pdata->reset = arizona_of_get_named_gpio(arizona, "wlf,reset", true);
 
@@ -560,6 +560,15 @@ static int arizona_of_get_core_pdata(struct arizona *arizona)
 			ret);
 	}
 
+	proplen = of_property_count_u32_elems(arizona->dev->of_node,
+					      "wlf,inmode");
+	if (proplen > 0 && proplen <= ARRAY_SIZE(arizona->pdata.inmode)) {
+		for (i = 0; i < proplen; i++)
+			of_property_read_u32_index(arizona->dev->of_node,
+						   "wlf,inmode", i,
+						    &arizona->pdata.inmode[i]);
+	}
+
 	return 0;
 }
 
-- 
2.0.0.390.gcb682f8

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

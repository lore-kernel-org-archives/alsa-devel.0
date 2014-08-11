From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Choosing the sysclk in simple-card looks broken to
	me.
Date: Sun, 10 Aug 2014 20:04:43 -0400
Message-ID: <CAKON4Ozth8VHa3OK+HNU7Lp29MqCbvVD7mh3v6KM7ejF0CGDpA@mail.gmail.com>
References: <CAKON4Oxusv_VuHNgbum1wBBz_N_V-a11N_rPu8m-rLFYAcQ_sQ@mail.gmail.com>
 <20140810105405.GW17528@sirena.org.uk>
 <CAKON4OzhSFJ4-cGkbr10LNorb+ihi6gqm1V4-YhTMHq8kmcWGg@mail.gmail.com>
 <CAKON4OxvoLBiq64t6Oh1i3CgA=Zy5DU7xYEe2kkpVdWkXMmqsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com
 [209.85.217.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BC30264F8D
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 02:04:44 +0200 (CEST)
Received: by mail-lb0-f174.google.com with SMTP id c11so5307711lbj.19
 for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2014 17:04:43 -0700 (PDT)
In-Reply-To: <CAKON4OxvoLBiq64t6Oh1i3CgA=Zy5DU7xYEe2kkpVdWkXMmqsg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, zengzm.kernel@gmail.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

After much messing around and learning the internals of OF clocks, it
looks like this is what I need.

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 03a7fdc..05d074b 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
 #include <linux/string.h>
 #include <sound/simple_card.h>
 #include <sound/soc-dai.h>
@@ -116,6 +117,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 {
  struct device_node *node;
  struct clk *clk;
+ struct of_phandle_args clkspec;
  int ret;

  /*
@@ -156,11 +158,14 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
      "system-clock-frequency",
      &dai->sysclk);
  } else {
- clk = of_clk_get(node, 0);
- if (!IS_ERR(clk))
+ clkspec.np = node;
+ clk = of_clk_get_from_provider(&clkspec);
+
+ if (!IS_ERR(clk)) {
  dai->sysclk = clk_get_rate(clk);
+ clk_put(clk);
+ }
  }
-
  return 0;
 }




-- 
Jon Smirl
jonsmirl@gmail.com

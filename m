From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Choosing the sysclk in simple-card looks broken to me.
Date: Sat, 9 Aug 2014 20:08:45 -0400
Message-ID: <CAKON4Oxusv_VuHNgbum1wBBz_N_V-a11N_rPu8m-rLFYAcQ_sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f169.google.com (mail-lb0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D5DD42619F3
 for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2014 02:08:45 +0200 (CEST)
Received: by mail-lb0-f169.google.com with SMTP id s7so4874263lbd.14
 for <alsa-devel@alsa-project.org>; Sat, 09 Aug 2014 17:08:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
Cc: kuninori.morimoto.gx@renesas.com, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, zengzm.kernel@gmail.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The problem is in asoc_simple_card_sub_parse_of()
in the else case..
} else {
clk = of_clk_get(node, 0);
if (!IS_ERR(clk))
dai->sysclk = clk_get_rate(clk);
}

This is picking up the input clocks to the devices.  On the cpu-dai
you want to pick up the ouput mclk (my first input clock is an 80Mhz
bus clock).  My IIS output clock is: clock-output-names = "mclk0";

Setting clocks="" doesn't work either, it also picks up the input clock.

if (of_property_read_bool(np, "clocks")) {
  clk = of_clk_get(np, 0);
  if (IS_ERR(clk)) {
     ret = PTR_ERR(clk);
  return ret;

When the codec-dai bit runs it finds the input clock on the codec,
which is really my cpu-dai's output clock and it gets the correct
value.

But then simple goes and tries to set both system clocks - my 80Mhz
bus clock and the 22.5 true sysclk. And my cpu-dai barfs when it is
passed a 80Mhz sysclk.

How to fix? Is anyone using this feature?  This needs to be fixed to
pick up output clocks, not input ones.

-- 
Jon Smirl
jonsmirl@gmail.com

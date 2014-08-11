From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Choosing the sysclk in simple-card looks broken to
	me.
Date: Sun, 10 Aug 2014 22:10:51 -0400
Message-ID: <CAKON4Oz0VbZ=j-0YqkN=9C+yXbWycc8TvsdTCNH0UzuvrcXs_w@mail.gmail.com>
References: <CAKON4Oxusv_VuHNgbum1wBBz_N_V-a11N_rPu8m-rLFYAcQ_sQ@mail.gmail.com>
 <20140810105405.GW17528@sirena.org.uk>
 <CAKON4OzhSFJ4-cGkbr10LNorb+ihi6gqm1V4-YhTMHq8kmcWGg@mail.gmail.com>
 <CAKON4OxvoLBiq64t6Oh1i3CgA=Zy5DU7xYEe2kkpVdWkXMmqsg@mail.gmail.com>
 <CAKON4Ozth8VHa3OK+HNU7Lp29MqCbvVD7mh3v6KM7ejF0CGDpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id BAC4D264FF9
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 04:10:51 +0200 (CEST)
Received: by mail-la0-f51.google.com with SMTP id pn19so6161680lab.38
 for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2014 19:10:51 -0700 (PDT)
In-Reply-To: <CAKON4Ozth8VHa3OK+HNU7Lp29MqCbvVD7mh3v6KM7ejF0CGDpA@mail.gmail.com>
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

As I debug further I am getting a better understanding of the problem.
This is my simple-audio binding.

sound {
compatible = "simple-audio-card";
simple-audio-card,format = "i2s";

simple-audio-card,cpu {
sound-dai = <&iis0>;
};

simple-audio-card,codec {
clocks = <&iis0>;
sound-dai = <&sgtl5000>;
};
};

I'm having trouble with the simple-audio-card,cpu node, not the
simple-audio-card,codec node.  As simple-audio is currently
implemented when simple-audio-card,cpu is processed it will pick up my
80Mhz apb clock and set it as sysclk.

After spending all day trying to fix that else clause, I'm coming to
the conclusion that the else clause simply shouldn't be there at all.
I just hit this because I had code checking for bogus values in
setsysclk.

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 03a7fdc..b389d9c2 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -155,10 +155,6 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
  of_property_read_u32(np,
      "system-clock-frequency",
      &dai->sysclk);
- } else {
- clk = of_clk_get(node, 0);
- if (!IS_ERR(clk))
- dai->sysclk = clk_get_rate(clk);
  }

  return 0;


-- 
Jon Smirl
jonsmirl@gmail.com

From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: cs35l34: Initial commit of the
 cs35l34 CODEC driver.
Date: Thu, 10 Nov 2016 15:54:02 +0300
Message-ID: <20161110125402.GB18664@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 24741266569
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 13:54:15 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul.Handrigan@cirrus.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Paul Handrigan,

The patch c1124c09e103: "ASoC: cs35l34: Initial commit of the cs35l34
CODEC driver." from Oct 12, 2016, leads to the following static
checker warning:

	sound/soc/codecs/cs35l34.c:613 cs35l34_dai_set_sysclk()
	warn: odd binop '0xffffffffffffffef & 0x0'

sound/soc/codecs/cs35l34.c
   604  static int cs35l34_dai_set_sysclk(struct snd_soc_dai *dai,
   605                                  int clk_id, unsigned int freq, int dir)
   606  {
   607          struct snd_soc_codec *codec = dai->codec;
   608          struct cs35l34_private *cs35l34 = snd_soc_codec_get_drvdata(codec);
   609          unsigned int value;
   610  
   611          switch (freq) {
   612          case CS35L34_MCLK_5644:
   613                  value = ~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_5P6448;
                                                    ^^^^^^^^^^^^^^^^^^^^^^^^
This is zero.  Maybe intentional?  If so just send a reply to this email
and I won't bother you again.

   614                  cs35l34->mclk_int = freq;
   615          break;
   616          case CS35L34_MCLK_6:
   617                  value = ~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_6P0000;
   618                  cs35l34->mclk_int = freq;
   619          break;
   620          case CS35L34_MCLK_6144:
   621                  value = ~CS35L34_MCLK_DIV & CS35L34_MCLK_RATE_6P1440;
   622                  cs35l34->mclk_int = freq;
   623          break;
   624          case CS35L34_MCLK_11289:
   625                  value = CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_5P6448;
   626                  cs35l34->mclk_int = freq / 2;
   627          break;
   628          case CS35L34_MCLK_12:
   629                  value = CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_6P0000;
   630                  cs35l34->mclk_int = freq / 2;
   631          break;
   632          case CS35L34_MCLK_12288:
   633                  value = CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_6P1440;
   634                  cs35l34->mclk_int = freq / 2;
   635          break;
   636          default:
   637                  dev_err(codec->dev, "ERROR: Invalid Frequency %d\n", freq);
   638                  cs35l34->mclk_int = 0;
   639                  return -EINVAL;
   640          }
   641          regmap_update_bits(cs35l34->regmap, CS35L34_MCLK_CTL,
   642                          CS35L34_MCLK_DIV | CS35L34_MCLK_RATE_MASK, value);
   643          return 0;
   644  }

regards,
dan carpenter

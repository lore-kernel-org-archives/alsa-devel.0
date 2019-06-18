From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: meson: axg-card: fix null pointer
 dereference in clean up
Date: Tue, 18 Jun 2019 14:07:11 +0300
Message-ID: <20190618110710.GA14934@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 335A0F89682
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 13:07:24 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: jbrunet@baylibre.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Jerome Brunet,

The patch 960f428ca0a0: "ASoC: meson: axg-card: fix null pointer
dereference in clean up" from Jun 10, 2019, leads to the following
static checker warning:

	sound/soc/meson/axg-card.c:121 axg_card_clean_references()
	warn: address of 'link->codecs[j]' is non-NULL

sound/soc/meson/axg-card.c
   109  static void axg_card_clean_references(struct axg_card *priv)
   110  {
   111          struct snd_soc_card *card = &priv->card;
   112          struct snd_soc_dai_link *link;
   113          struct snd_soc_dai_link_component *codec;
   114          int i, j;
   115  
   116          if (card->dai_link) {
   117                  for_each_card_prelinks(card, i, link) {
   118                          if (link->cpus)
   119                                  of_node_put(link->cpus->of_node);
   120                          for_each_link_codecs(link, j, codec)
   121                                  if (codec)
                                            ^^^^^
"codec" is the list iterator so it can't possibly be NULL.

   122                                          of_node_put(codec->of_node);
   123                  }
   124          }
   125  
   126          if (card->aux_dev) {
   127                  for (i = 0; i < card->num_aux_devs; i++)
   128                          of_node_put(card->aux_dev[i].codec_of_node);
   129          }
   130  
   131          kfree(card->dai_link);
   132          kfree(priv->link_data);
   133  }

regards,
dan carpenter

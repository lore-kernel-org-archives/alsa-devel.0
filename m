From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: add audio-graph-card support
Date: Fri, 19 May 2017 00:33:12 +0300
Message-ID: <20170518213312.7rpntem46hmo2nbu@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D2A2267236
 for <alsa-devel@alsa-project.org>; Thu, 18 May 2017 23:33:22 +0200 (CEST)
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
To: kuninori.morimoto.gx@renesas.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Kuninori Morimoto,

The patch 2692c1c63c29: "ASoC: add audio-graph-card support" from Apr
20, 2017, leads to the following static checker warning:

	sound/soc/generic/audio-graph-card.c:275 asoc_graph_card_probe()
	info: return a literal instead of 'ret'

sound/soc/generic/audio-graph-card.c
   268                  goto err;
   269          }
   270  
   271          snd_soc_card_set_drvdata(card, priv);
   272  
   273          ret = devm_snd_soc_register_card(dev, card);
   274          if (ret >= 0)
   275                  return ret;

This code is confusing.  I'm pretty sure that devm_snd_soc_register_card()
returns zero on success or negative error codes but why are we checking
>= 0 here?

It's better to do error handling than success handling.  People often
get a bit creative with the last condition in a function...  :/  In
other words, it's cleaner like this:

		ret = devm_snd_soc_register_card(dev, card);
		if (ret)
			goto err;

		return 0;

	err:
		asoc_simple_card_clean_reference(card);

		return ret;


   276  err:
   277          asoc_simple_card_clean_reference(card);
   278  
   279          return ret;
   280  }

regards,
dan carpenter

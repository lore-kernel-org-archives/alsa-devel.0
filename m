From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ASoC: simple-card: Fix missing
	of_node_put() at simple_dai_link_of()
Date: Tue, 19 Feb 2019 16:46:48 +0100
Message-ID: <20190219154652.13644-3-tiwai@suse.de>
References: <20190219154652.13644-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 295ED265538
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 16:46:54 +0100 (CET)
In-Reply-To: <20190219154652.13644-1-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

We forgot to unreference the platform node object obtained from
of_get_child_by_name().  This leads to the unbalance of node
refcount.

Fixes: e0ae225b7e96 ("ASoC: simple-card: support platform in dts parse")
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Only compile-tested.  Please review carefully.  Thanks!

 sound/soc/generic/simple-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 08df261024cf..3e677dd1137e 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -421,6 +421,7 @@ static int simple_dai_link_of(struct simple_priv *priv,
 	asoc_simple_card_canonicalize_platform(dai_link);
 
 dai_link_of_err:
+	of_node_put(plat);
 	of_node_put(node);
 
 	return ret;
-- 
2.16.4

From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ASoC: rcar: off by one in rsnd_scu_set_route()
Date: Fri, 8 Nov 2013 12:46:10 +0300
Message-ID: <20131108094610.GE27977@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id B69EB265611
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2013 10:46:22 +0100 (CET)
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
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

If "id == ARRAY_SIZE(routes)" then we read one space beyond the end of
the routes[] array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/sh/rcar/scu.c b/sound/soc/sh/rcar/scu.c
index 1ab1bce..5e46ef2 100644
--- a/sound/soc/sh/rcar/scu.c
+++ b/sound/soc/sh/rcar/scu.c
@@ -68,7 +68,7 @@ static int rsnd_scu_set_route(struct rsnd_priv *priv,
 		return 0;
 
 	id = rsnd_mod_id(mod);
-	if (id < 0 || id > ARRAY_SIZE(routes))
+	if (id < 0 || id >= ARRAY_SIZE(routes))
 		return -EIO;
 
 	/*

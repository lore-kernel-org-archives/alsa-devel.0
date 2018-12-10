From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: simple-card-utils: fix build warning
	without CONFIG_OF
Date: Mon, 10 Dec 2018 21:46:10 +0100
Message-ID: <20181210204640.2407929-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 282AB26770D
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2018 21:46:59 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
List-Id: alsa-devel@alsa-project.org

When CONFIG_OF is disabled, of_graph_parse_endpoint() does not
initialize 'info', and gcc can see that:

sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_card_parse_graph_dai':
sound/soc/generic/simple-card-utils.c:284:13: error: 'info.port' may be used uninitialized in this function [-Werror=maybe-uninitialized]

It's probably best to check the return code anyway, and that also
takes care of the warning.

Fixes: b6f3fc005a2c ("ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id() counting")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/generic/simple-card-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 6a31d07976b9..17d8aee43835 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -280,7 +280,10 @@ static int asoc_simple_card_get_dai_id(struct device_node *ep)
 	 * Non HDMI sound case, counting port/endpoint on its DT
 	 * is enough. Let's count it.
 	 */
-	of_graph_parse_endpoint(ep, &info);
+	ret = of_graph_parse_endpoint(ep, &info);
+	if (ret)
+		return -ENXIO;
+
 	return info.port;
 }
 
-- 
2.20.0

From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: fix build warning
	without CONFIG_OF" to the asoc tree
Date: Tue, 11 Dec 2018 01:15:45 +0000 (GMT)
Message-ID: <20181211011545.C4DD111254C7@debutante.sirena.org.uk>
References: <20181210204640.2407929-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F2242267B4A
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 02:15:48 +0100 (CET)
In-Reply-To: <20181210204640.2407929-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: fix build warning without CONFIG_OF

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 2b320e046495e6cf02d1f0b1abf07042ac5635ea Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Dec 2018 21:46:10 +0100
Subject: [PATCH] ASoC: simple-card-utils: fix build warning without CONFIG_OF

When CONFIG_OF is disabled, of_graph_parse_endpoint() does not
initialize 'info', and gcc can see that:

sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_card_parse_graph_dai':
sound/soc/generic/simple-card-utils.c:284:13: error: 'info.port' may be used uninitialized in this function [-Werror=maybe-uninitialized]

It's probably best to check the return code anyway, and that also
takes care of the warning.

Fixes: b6f3fc005a2c ("ASoC: simple-card-utils: fixup asoc_simple_card_get_dai_id() counting")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2

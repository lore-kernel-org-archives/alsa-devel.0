From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH] ASoC: Remove erroneous
	soc_cleanup_card_resources() call
Date: Fri, 07 Jun 2019 17:49:26 +0200
Message-ID: <20190607154926.11373-1-s.nawrocki@samsung.com>
References: <CGME20190607155000epcas2p48f3a736f27c39c3b16486c067f8fe11a@epcas2p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11420F896CE
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 17:50:07 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, b.zolnierkie@samsung.com, lgirdwood@gmail.com, krzk@kernel.org, tzungbi@google.com, Sylwester Nawrocki <s.nawrocki@samsung.com>, festevam@gmail.com, m.szyprowski@samsung.com
List-Id: alsa-devel@alsa-project.org

When soc_init_dai_link() call at the beginning of snd_soc_instantiate_card
function fails soc_cleanup_card_resources() and then snd_soc_dapm_free()
gets called with an incompletely initialized card->dapm. In particular
card->dapm.card is NULL and it gets dereferenced in dapm_free_widgets().
Also dapm->list is invalid and there is an invalid pointer dereference
from list_del().

The function call stack (deferred probing) on Chromebook Snow where this
issue has shown up in today's -next is:

 snd_soc_dapm_free
 soc_cleanup_card_resources
 snd_soc_instantiate_card
 snd_soc_register_card
 devm_snd_soc_register_card
 snow_probe

In patch 70fc53734e71 "ASoC: core: move DAI pre-links initiation to
snd_soc_instantiate_card" there is an soc_cleanup_platform() call instead
of soc_cleanup_card_resources() as in current -next.

soc_cleanup_platform got renamed to soc_cleanup_legacy, then removed
in commit adb76b5b9c47 "ASoC: soc-core: remove legacy style dai_link".

It seems in merge conflict resolution the soc_cleanup_platform() call got
renamed to soc_cleanup_card_resources(), instead of being removed.

Correct this by removing an unnecessary soc_cleanup_card_resources() call.

Fixes: a8e992342ce4 ("Merge branch 'asoc-5.2' into asoc-5.3")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Suggested-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/soc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 94a36ee8eb22..f0fa289c90d8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1986,7 +1986,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	for_each_card_prelinks(card, i, dai_link) {
 		ret = soc_init_dai_link(card, dai_link);
 		if (ret) {
-			soc_cleanup_card_resources(card);
 			dev_err(card->dev, "ASoC: failed to init link %s: %d\n",
 				dai_link->name, ret);
 			mutex_unlock(&client_mutex);
--
2.17.1

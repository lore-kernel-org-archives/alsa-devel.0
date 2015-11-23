From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: rcar: remove unused variable
Date: Mon, 23 Nov 2015 10:35:54 +0100
Message-ID: <4929159.b95vLdVRYU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by alsa0.perex.cz (Postfix) with ESMTP id F026C260455
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 10:36:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

After a recent cleanup, the soc_card variable became unused
and now produces a warning:

soc/sh/rcar/core.c: In function '__rsnd_kctrl_new':
soc/sh/rcar/core.c:801:23: warning: unused variable 'soc_card' [-Wunused-variable]

This removes the variable.

Fixes: 1a497983a5ae ("ASoC: Change the PCM runtime array to a list")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index c6685f14b9cb..90b244c1f526 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -798,7 +798,6 @@ static int __rsnd_kctrl_new(struct rsnd_mod *mod,
 			    void (*update)(struct rsnd_dai_stream *io,
 					   struct rsnd_mod *mod))
 {
-	struct snd_soc_card *soc_card = rtd->card;
 	struct snd_card *card = rtd->card->snd_card;
 	struct snd_kcontrol *kctrl;
 	struct snd_kcontrol_new knew = {

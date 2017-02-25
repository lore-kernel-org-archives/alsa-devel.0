From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Subject: [PATCH] ASoC: pxa: The open brace is placed with the
	previous line
Date: Sat, 25 Feb 2017 23:54:16 +0200
Message-ID: <1488059656-16725-1-git-send-email-codrut.cristian.grosu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 7161A266B0F
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 22:54:32 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id r18so8003129wmd.3
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 13:54:32 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, daniel@zonque.org, robert.jarzmik@free.fr, haojian.zhuang@gmail.com, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Codrut Grosu <codrut.cristian.grosu@gmail.com>, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/raumfeld.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 552b763..47c9173 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -228,14 +228,12 @@ static int raumfeld_ak4104_hw_params(struct snd_pcm_substream *substream,
 	.codec_name	= "spi0.0",			\
 }

-static struct snd_soc_dai_link snd_soc_raumfeld_connector_dai[] =
-{
+static struct snd_soc_dai_link snd_soc_raumfeld_connector_dai[] = {
 	DAI_LINK_CS4270,
 	DAI_LINK_AK4104,
 };

-static struct snd_soc_dai_link snd_soc_raumfeld_speaker_dai[] =
-{
+static struct snd_soc_dai_link snd_soc_raumfeld_speaker_dai[] = {
 	DAI_LINK_CS4270,
 };

--
1.9.1

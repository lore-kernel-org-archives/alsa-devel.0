From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Subject: [PATCH] ASoC: pxa: Add space around ':' and '('
Date: Sat, 25 Feb 2017 22:42:33 +0200
Message-ID: <1488055353-12412-1-git-send-email-codrut.cristian.grosu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: perex@perex.cz, daniel@zonque.org, robert.jarzmik@free.fr, haojian.zhuang@gmail.com, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Codrut Grosu <codrut.cristian.grosu@gmail.com>, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Codrut Grosu <codrut.cristian.grosu@gmail.com>
---
 sound/soc/pxa/pxa2xx-i2s.c | 2 +-
 sound/soc/pxa/tosa.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 0389cf7..27aa0e4 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -119,7 +119,7 @@ static int pxa_i2s_wait(void)
 	int i;

 	/* flush the Rx FIFO */
-	for(i = 0; i < 16; i++)
+	for (i = 0; i < 16; i++)
 		SADR;
 	return 0;
 }
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index e022b2a..1812748 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -133,7 +133,7 @@ static int tosa_set_spk(struct snd_kcontrol *kcontrol,
 static int tosa_hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
-	gpio_set_value(TOSA_GPIO_L_MUTE, SND_SOC_DAPM_EVENT_ON(event) ? 1 :0);
+	gpio_set_value(TOSA_GPIO_L_MUTE, SND_SOC_DAPM_EVENT_ON(event) ? 1 : 0);
 	return 0;
 }

--
1.9.1

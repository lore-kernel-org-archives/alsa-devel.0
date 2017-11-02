From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: stm32: sai: attempt to fix uninitialized
	variable
Date: Thu,  2 Nov 2017 12:15:48 +0100
Message-ID: <20171102111620.3688534-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E7D126737F
 for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2017 12:16:33 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

After commit 61fb4ff70377 ("ASoC: stm32: sai: Move static
settings to DAI init"), we get a valid warning about the
use of an uninitialized variable:

sound/soc/stm/stm32_sai_sub.c: In function 'stm32_sai_hw_params':
sound/soc/stm/stm32_sai_sub.c:485:7: error: 'cr1' may be used uninitialized in this function [-Werror=maybe-uninitialized]

I could not immediately figure out what the code should do
instead, this is the hack I applied locally to shut up the
warning. It may or may not be correct, please take a look.

Fixes: 61fb4ff70377 ("ASoC: stm32: sai: Move static settings to DAI init")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/stm/stm32_sai_sub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 150ad546d8b9..d8a51fce368a 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -480,6 +480,7 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 
 	/* Mode, data format and channel config */
 	cr1_mask = SAI_XCR1_DS_MASK;
+	cr1 = 0;
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
 		cr1 |= SAI_XCR1_DS_SET(SAI_DATASIZE_8);
-- 
2.9.0

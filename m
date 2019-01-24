From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: Intel: bytcht_es8316: make
	mic_name static, reduces object code size
Date: Thu, 24 Jan 2019 17:06:21 +0000
Message-ID: <20190124170621.7583-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B30E72674A9
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 18:06:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array mic_name on the stack but instead make
it static. Makes the object code smaller by 28 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  14107	   8832	    224	  23163	   5a7b	bytcht_es8316.o

After:
   text	   data	    bss	    dec	    hex	filename
  14015	   8896	    224	  23135	   5a5f	bytcht_es8316.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index fa9c4cf97686..1364e4e601d8 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -437,7 +437,7 @@ static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
 
 static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 {
-	const char * const mic_name[] = { "in1", "in2" };
+	static const char * const mic_name[] = { "in1", "in2" };
 	struct byt_cht_es8316_private *priv;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
-- 
2.19.1

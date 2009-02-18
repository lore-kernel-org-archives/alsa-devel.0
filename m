From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/11] ASoC: Fix DaVinci module unload error
Date: Wed, 18 Feb 2009 12:02:23 +0000
Message-ID: <1234958553-16049-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CDCE01038A3
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:02:45 +0100 (CET)
In-Reply-To: <20090218120135.GA15414@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Chaithrika U S <chaithrika@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Kevin Hilman <khilman@deeprootsystems.com>

Fix for the error when the audio module is unloaded.  On unregistering
the platform_device, platform_device_release will free the platform
data.If platform data is static the kernel panics when it is freed.
Instead use the platform device helper function to add data.

This change has been tested on DM644x EVM, DM644x SFFSDR and DM355 EVM.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/davinci/davinci-evm.c    |    3 ++-
 sound/soc/davinci/davinci-sffsdr.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 54851f3..9b90b34 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -186,7 +186,8 @@ static int __init evm_init(void)
 
 	platform_set_drvdata(evm_snd_device, &evm_snd_devdata);
 	evm_snd_devdata.dev = &evm_snd_device->dev;
-	evm_snd_device->dev.platform_data = &evm_snd_data;
+	platform_device_add_data(evm_snd_device, &evm_snd_data,
+				 sizeof(evm_snd_data));
 
 	ret = platform_device_add_resources(evm_snd_device, evm_snd_resources,
 					    ARRAY_SIZE(evm_snd_resources));
diff --git a/sound/soc/davinci/davinci-sffsdr.c b/sound/soc/davinci/davinci-sffsdr.c
index 50baef1..0bf81ab 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -141,7 +141,8 @@ static int __init sffsdr_init(void)
 
 	platform_set_drvdata(sffsdr_snd_device, &sffsdr_snd_devdata);
 	sffsdr_snd_devdata.dev = &sffsdr_snd_device->dev;
-	sffsdr_snd_device->dev.platform_data = &sffsdr_snd_data;
+	platform_device_add_data(sffsdr_snd_device, &sffsdr_snd_data,
+				 sizeof(sffsdr_snd_data));
 
 	ret = platform_device_add_resources(sffsdr_snd_device,
 					    sffsdr_snd_resources,
-- 
1.5.6.3

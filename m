From: chaithrika@ti.com
Subject: [PATCH]: ARM DaVinci ASoC: Fix module unload error
Date: Fri, 13 Feb 2009 12:39:39 +0530
Message-ID: <1234508979-13522-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 92BB62433B
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 09:38:25 +0100 (CET)
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1D8cH6V001175
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 02:38:23 -0600
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

From: Chaithrika U S <chaithrika@ti.com>

Fix for the error when the audio module is unloaded.
On unregistering the platform_device, platform_device_release will free the 
platform data.If platform data is static the kernel panics when it is freed.
Instead use the platform device helper function to add data.

This change has been tested on DM644x EVM.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
 sound/soc/davinci/davinci-evm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 1aad262..95c44bf 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -225,7 +225,7 @@ static int __init evm_init(void)
 
 	platform_set_drvdata(evm_snd_device, &evm_snd_devdata);
 	evm_snd_devdata.dev = &evm_snd_device->dev;
-	evm_snd_device->dev.platform_data = data;
+	platform_device_add_data(evm_snd_device, data, sizeof(data));
 
 	ret = platform_device_add_resources(evm_snd_device, resources, 1);
 	if (ret) {
-- 
1.5.6

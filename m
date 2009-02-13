From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]: ARM DaVinci ASoC: Fix module unload error
Date: Fri, 13 Feb 2009 11:36:37 -0800
Message-ID: <87fxiijfi2.fsf@deeprootsystems.com>
References: <1234508979-13522-1-git-send-email-chaithrika@ti.com>
	<20090213133057.GC31085@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CFC7243F7
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 20:36:41 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so820992ywa.2
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 11:36:40 -0800 (PST)
In-Reply-To: <20090213133057.GC31085@sirena.org.uk> (Mark Brown's message of
	"Fri\, 13 Feb 2009 13\:30\:57 +0000")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: chaithrika@ti.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@sirena.org.uk> writes:

> On Fri, Feb 13, 2009 at 12:39:39PM +0530, chaithrika@ti.com wrote:
>> From: Chaithrika U S <chaithrika@ti.com>
>
>> Fix for the error when the audio module is unloaded.
>> On unregistering the platform_device, platform_device_release will free the 
>> platform data.If platform data is static the kernel panics when it is freed.
>> Instead use the platform device helper function to add data.
>
> Which kernel tree is this patch against?  It doesn't apply against
> either the topic/asoc or fix/asoc branch of
>
> 	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

Hi Mark,

This patch is against DaVinci git[1], which still has some differences
compared to the upstream trees.

Below is a version of this patch against Linus' tree, with the SFFSDR
board changes from Hugo included.

Kevin


[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=summary


commit 53748f550f8dcd2cad676e67804d69cd4424ab4f
Author: Chaithrika U S <chaithrika@ti.com>
Date:   Fri Feb 13 12:39:39 2009 +0530

    ASoC: DaVinci: fix module unload error
    
    Fix for the error when the audio module is unloaded.  On unregistering
    the platform_device, platform_device_release will free the platform
    data.If platform data is static the kernel panics when it is freed.
    Instead use the platform device helper function to add data.
    
    This change has been tested on DM644x EVM, DM644x SFFSDR and DM355 EVM.
    
    Signed-off-by: Chaithrika U S <chaithrika@ti.com>
    Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

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
index 4935d1b..5a2e5e0 100644
--- a/sound/soc/davinci/davinci-sffsdr.c
+++ b/sound/soc/davinci/davinci-sffsdr.c
@@ -127,7 +127,8 @@ static int __init sffsdr_init(void)
 
 	platform_set_drvdata(sffsdr_snd_device, &sffsdr_snd_devdata);
 	sffsdr_snd_devdata.dev = &sffsdr_snd_device->dev;
-	sffsdr_snd_device->dev.platform_data = &sffsdr_snd_data;
+	platform_device_add_data(sffsdr_snd_device, &sffsdr_snd_data,
+				 sizeof(sffsdr_snd_data));
 
 	ret = platform_device_add_resources(sffsdr_snd_device,
 					    sffsdr_snd_resources,

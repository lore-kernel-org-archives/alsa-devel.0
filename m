From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: ALSA issue on DA850/OMAP-L138/AM18x
Date: Tue, 18 Jan 2011 10:13:14 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302484734E0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 37031246C2
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 05:43:38 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, Michael Williamson <michael.williamson@criticallink.com>, "Nori,
	Sekhar" <nsekhar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Resending with proper $SUBJECT...

Hi,

I was testing Audio with 2.6.37 on DA850 from Kevin Hilman Linux tree
at [1] and found that audio is broken. Below patch fixes the issue.

---
From: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>

davinci: fixes for audio on da850/omap-l138/am18x

On DA850/OMAP-L138/AM18x, AIC3x codec is at 0x18 slave address.
But in sound/soc/davinci/davinci-evm.c file, "struct snd_soc_dai_link"
has the wrong AIC3x codec slave address. This patch fixes this issue.

Also, this patch registers the platform device for davinci-pcm-audio.

Signed-off-by: Rajashekhara, Sudhakar <sudhakar.raj@ti.com>
---
 arch/arm/mach-davinci/devices-da8xx.c |   12 ++++++++++++
 sound/soc/davinci/davinci-evm.c       |    2 +-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 9eec630..17c0dbc 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -473,6 +473,11 @@ static struct resource da850_mcasp_resources[] = {
 	},
 };
 
+struct platform_device davinci_pcm_device = {
+	.name	= "davinci-pcm-audio",
+	.id	= -1,
+};
+
 static struct platform_device da850_mcasp_device = {
 	.name		= "davinci-mcasp",
 	.id		= 0,
@@ -480,8 +485,15 @@ static struct platform_device da850_mcasp_device = {
 	.resource	= da850_mcasp_resources,
 };
 
+static void davinci_init_pcm(void)
+{
+	platform_device_register(&davinci_pcm_device);
+}
+
 void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata)
 {
+	davinci_init_pcm();
+
 	/* DA830/OMAP-L137 has 3 instances of McASP */
 	if (cpu_is_davinci_da830() && id == 1) {
 		da830_mcasp1_device.dev.platform_data = pdata;
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index bc9e6b0..07db881 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -224,7 +224,7 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
 	.stream_name = "AIC3X",
 	.cpu_dai_name= "davinci-mcasp.0",
 	.codec_dai_name = "tlv320aic3x-hifi",
-	.codec_name = "tlv320aic3x-codec.0-001a",
+	.codec_name = "tlv320aic3x-codec.1-0018",
 	.platform_name = "davinci-pcm-audio",
 	.init = evm_aic3x_init,
 	.ops = &evm_ops,
---

Also, I found that either CONFIG_REGULATOR should not be defined or if
CONFIG_REGULATOR is defined then CONFIG_REGULATOR_DUMMY should also be
defined. Without this menuconfig fix, Soundcard does not get detected.

With the above fixes, arecord and aplay does not work for the first time.
Couple of times I get the below error:

root@da850-omapl138-evm:~# arecord -f dat | aplay -f dat
arecord: main:608: audio open error: Invalid argument
aplay: playback:2297: read error
root@da850-omapl138-evm:~# arecord -f dat | aplay -f dat
aplay: main:608: audio open error: Invalid argument
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo

Third time arecord and aplay work normally.

Has anyone seen such issues on DA850 or any other platform?

I am currently debugging this issue. I'll submit the above patch to community
once the issue of fixed.

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=summary 

Regards,
Sudhakar
_______________________________________________
Davinci-linux-open-source mailing list
Davinci-linux-open-source@linux.davincidsp.com
http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source

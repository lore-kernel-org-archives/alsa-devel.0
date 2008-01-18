From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/17] Don't lock the codec list
	in	snd_soc_dapm_new_widgets()
Date: Fri, 18 Jan 2008 10:18:16 +0000
Message-ID: <20080118101816.GA19291@rakim.wolfsonmicro.main>
References: <1199971035-13553-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1199971035-13553-10-git-send-email-broonie@opensource.wolfsonmicro.com>
	<bc64b4640801151540n4cb66f99u68ba0d42c91b5ff6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A8C262483E
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 11:18:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <bc64b4640801151540n4cb66f99u68ba0d42c91b5ff6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry <dbaryshkov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 16, 2008 at 02:40:55AM +0300, Dmitry wrote:

> I'm sorry, but I tested this patch only now. And I just got another
> message from lockdep:

Could you give this patch a try, please?

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f5fe7c6..283a0ba 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1131,7 +1131,6 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 	struct snd_soc_machine *machine = socdev->machine;
 	int ret = 0, i, ac97 = 0, err = 0;
 
-	mutex_lock(&codec->mutex);
 	for(i = 0; i < machine->num_links; i++) {
 		if (socdev->machine->dai_link[i].init) {
 			err = socdev->machine->dai_link[i].init(codec);
@@ -1157,12 +1156,14 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 		goto out;
 	}
 
+	mutex_lock(&codec->mutex);
 #ifdef CONFIG_SND_SOC_AC97_BUS
 	if (ac97) {
 		ret = soc_ac97_dev_register(codec);
 		if (ret < 0) {
 			printk(KERN_ERR "asoc: AC97 device register failed\n");
 			snd_card_free(codec->card);
+			mutex_unlock(&codec->mutex);
 			goto out;
 		}
 	}
@@ -1175,8 +1176,10 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 	err = device_create_file(socdev->dev, &dev_attr_codec_reg);
 	if (err < 0)
 		printk(KERN_WARNING "asoc: failed to add codec sysfs entries\n");
-out:
+
 	mutex_unlock(&codec->mutex);
+
+out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_card);

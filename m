From: Sangsu Park <sangsu@gmail.com>
Subject: Re: [PATCH] ASoC: Allocate PCM operations dynamically
 to support multiple DAIs
Date: Tue, 27 Dec 2011 17:06:56 +0900
Message-ID: <CANh+=Y-xM6hq6N1umMxR4PATBj-OmKkfHoSpnzR5q2kjt2b79g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9390024344
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2011 09:06:58 +0100 (CET)
Received: by yenr11 with SMTP id r11so3273275yen.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2011 00:06:56 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lars@metafoo.de
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, sangsu4u.park@samsung.com
List-Id: alsa-devel@alsa-project.org

> This looks wrong. It will probably cause regression for all non ASoC sound
> card drivers.
>
> The issue this patch addresses came up before and I think the conclusion was
> that it is best to embed the snd_pcm_ops struct into the snd_soc_pcm_runtime
> struct.

Hi, I'm Sangsu Park. (sangsu4u.park@samsung.com)
I'm using gmail because of company's firewall problems...

I agree you, So I've changed some code like follows.
If you like that, I'll make patch version 2nd using that.

//------------------------------------------------------------------------------
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 42ad2db..d1468aa 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -918,6 +918,9 @@ static void soc_remove_dai_link(struct
snd_soc_card *card, int num, int order)
                list_del(&cpu_dai->card_list);
                module_put(cpu_dai->dev->driver->owner);
        }
+
+       /* free the ops memory */
+       if (rtd->ops) kfree(rtd->ops);
 }
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 8aa7cec..4eb793b 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -641,22 +645,23 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
        INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
        rtd->pcm = pcm;
+       rtd->ops = soc_pcm_ops;
        pcm->private_data = rtd;
        if (platform->driver->ops) {
------------------------------------------------------------------------------//

Thanks.
